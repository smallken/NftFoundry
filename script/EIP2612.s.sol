// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// import {Script, console} from "forge-std/Script.sol";
import "../src/MyEIP2612.sol";
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
        MyEIP2612 myEIP2612 = new MyEIP2612("Dragon","DRG");
        // 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512
        console2.log("Counter deployed on %s", address(myEIP2612));
        vm.stopBroadcast();
    }
}
