pragma solidity ^0.8.13;

import "lib/v2-core/contracts/UniswapV2Factory.sol";
import "lib/v2-core/contracts/UniswapV2Pair.sol";

contract uniswap {
    UniswapV2Factory factory;

    constructor (address _factory) {
        factory = UniswapV2Factory(_factory);
    }

    // 创建交易对
    function createPairUni(address a, address b) public returns (address pair){
        return pair = factory.createPair(a, b);
    }

    // 兑换
    function swapUni() public {
        
    }

}