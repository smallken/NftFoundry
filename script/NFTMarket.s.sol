// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// import {Script, console} from "forge-std/Script.sol";
import "../src/NFTMarket.sol";
import "../lib/forge-std/src/Script.sol";

contract CounterScript is Script {
    function run() external {
        // 助记词部署
        string memory mnemonic = vm.envString("MNEMONIC");
        (address deployer, ) = deriveRememberKey(mnemonic, 0);    
        vm.startBroadcast(deployer);
        // 私钥部署
        // uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        // vm.startBroadcast(deployerPrivateKey);
        address addressEIP2612 = 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512 ;
        address addressERC721 = 0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0;
        // NFTMarket nftMarket = new NFTMarket(addressERC721,addressEIP2612);
        // 0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9
        // console2.log("Counter deployed on %s", address(nftMarket));
        vm.stopBroadcast();
    }
}
