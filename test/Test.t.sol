pragma solidity ^0.8.13;

import {Test, console} from "../lib/forge-std/src/Test.sol";

contract CounterTest is Test {
    // Counter public counter;

    function setUp() public {
        address admin = address(0x1);
        
    }

    function create() public {
        address a = makeAddr("admin");
        address b = makeAddr("player");
        // console.logBytes(re);
        // emit log("re:",re);
    }


}