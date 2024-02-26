pragma solidity ^0.8.13;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import  "../src/uniswap.sol";

contract CounterTest is Test {
    // Counter public counter;
    uniswap public uni;

    function setUp() public {
        address admin = address(0x1);
        uni = new uniswap(admin);
        
    }

    function create() public {
        address a = makeAddr("admin");
        address b = makeAddr("player");
        address re = uni.createPairUni(a, b);
        // console.logBytes(re);
        // emit log("re:",re);
        console.log("re:",re);
    }


}