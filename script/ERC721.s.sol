// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// import {Script, console} from "forge-std/Script.sol";
import "../src/MyERC721.sol";
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
        MyERC721 myEIP721 = new MyERC721();
        // 0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0
        console2.log("Counter deployed on %s", address(myEIP721));
        vm.stopBroadcast();
    }
}
