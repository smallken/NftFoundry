pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "../src/NFTMarket.sol";
import "../src/MyEIP2612.sol";
import "../src/MyERC721.sol";
// import "../src/interfaces/IUniswapV2Router02.sol";
// import "../src/interfaces/IUniswapV2Factory.sol";
import "../src/uniswpV2/WETH9.sol";
import "../src/uniswpV2/UniswapV2Router02.sol";
import "../src/uniswpV2/UniswapV2Factory.sol";

contract TestNFTMarket is Test {
    NFTMarket public nftMarket;
    MyEIP2612 public myEIP2612;
    MyERC721 public myERC721;
    WETH9 public weth;
    enum Status {OffSale, OnSale, Sold}
    address player = makeAddr("player");
     // 定义admin
    address admin = makeAddr("admin");
    UniswapV2Router02 public router;
    UniswapV2Factory public factory;
    function setUp() public {
        vm.startPrank(admin);
            {
                myEIP2612 = new MyEIP2612("Dragon", "DRG");
                myERC721 = new MyERC721();
                weth = new WETH9();
                factory = new UniswapV2Factory(admin);
                router = new UniswapV2Router02(address(factory), address(weth));
                nftMarket = new NFTMarket(address(myERC721), address(myEIP2612), address(router), address(weth));
                // 这是给admin转myEIP2612的代币，单位都是ether
                deal(address(myEIP2612), admin, 10000 ether);
                deal(address(weth), admin, 10000 ether);
                // 这是转以太
                deal(admin, 100 ether);
                nftMarket.getHash();
                myEIP2612.approve(address(router), 1000 ether);
                weth.approve(address(router), 500 ether);
                (uint amountA, uint amountB, uint liquidity) = router.addLiquidity(address(weth), address(myEIP2612), 500 ether, 1000 ether, 1, 1, address(nftMarket), block.timestamp + 10000);
                //  console.log("amountA:", amountA,";amountB:",amountB,";liquidity:",liquidity);
            }
        vm.stopPrank();
        }



    function test() public {
        
        //转账到账户player
        vm.startPrank(admin);
        myEIP2612.transfer(player, 100000);
        console.log("player balance:", myEIP2612.balanceOf(player));
        
        // function mint(address student, string memory tokenURI) public returns (uint256) {
        // 创建NFT 
        // ipfs://QmWzNBw5YQCEQ8WovNDEGtkxwrAkHcqkzoSZTFw5XAo13T

        uint nftID = myERC721.mint(admin, "ipfs://QmWzNBw5YQCEQ8WovNDEGtkxwrAkHcqkzoSZTFw5XAo13T");
        console.log("nftID:", nftID);
        address owner = myERC721.ownerOf(nftID);
        console.log("owner:", owner);
        myERC721.approve(0x5FC8d32690cc91D4c39d9d3abcBD16989F875707, nftID);
        nftMarket.onList(nftID, 555);
        // Status isOnSale = nftMarket.Status(nftMarket.isOnSale(nftID));
        // console.log("isOnSale:", string(nftMarket.isOnSale(nftID)));
        vm.stopPrank();
        vm.startPrank(player);
        // myEIP2612.approve(0x5FC8d32690cc91D4c39d9d3abcBD16989F875707, 555);
        // 这里代码要修改，权限要给到合约去调用
        myEIP2612.approve(address(nftMarket), 555);
        nftMarket.buyNFT(nftID, 555);
         address owner2 = myERC721.ownerOf(nftID);
        console.log("owner2:",owner2);
        assertEq(myERC721.ownerOf(nftID), player);
        vm.stopPrank();

    // --chain 127.0.0.1:8545
    }

    function testBuyBySwap() public {
        vm.startPrank(admin);
        uint nftID = myERC721.mint(admin, "ipfs://QmWzNBw5YQCEQ8WovNDEGtkxwrAkHcqkzoSZTFw5XAo13T");
        console.log("nftID:", nftID);
        address owner = myERC721.ownerOf(nftID);
        console.log("owner:", owner);
        myERC721.approve(address(nftMarket), nftID);
        nftMarket.onList(nftID, 5 ether);
        // factory.createPair(address(weth), address(myEIP2612));
        vm.stopPrank();
        vm.startPrank(player);
        deal(player,10 ether);
        deal(address(myEIP2612), player, 10 ether);
        deal(address(weth), player, 6 ether);
        deal(address(weth), address(nftMarket), 1 ether);
        weth.deposit();
        // weth.deposit();
        uint256 currentTime = block.timestamp;
        uint256 fiveMinutes = 5 minutes;
        uint256 deadline = currentTime + fiveMinutes;
        address[] memory path = new address[](2);
        path[0] = address(weth);
        path[1] = address(myEIP2612);
        // uint[] memory amounts = router.getAmountsIn(5 ether, path);
        uint[] memory amounts = router.getAmountsOut(5 ether, path);
        console.log("amounts[1]:", amounts[1]);
        // TestSwap
        console.log("before:",weth.balanceOf(player));
        // weth.approve(address(nftMarket), 5 ether);
        weth.approve(address(nftMarket), amounts[0]);
        // (address tokenSender, IERC20 tokenIn, uint256 amountInMax, uint256 amountOut, uint deadline)
        nftMarket.swap(address(player), IERC20(weth), 5 ether, amounts[1], deadline);
        console.log("after:",weth.balanceOf(player));
        // myEIP2612.approve(address(nftMarket), 555);  
        // nftMarket.buyNftThroughSwap(weth, 1000, nftID, deadline);
        //  address owner2 = myERC721.ownerOf(nftID);
        // console.log("owner2:",owner2);
        // assertEq(myERC721.ownerOf(nftID), player);
        vm.stopPrank();
    }
}