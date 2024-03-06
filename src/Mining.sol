pragma solidity ^0.8.13;
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract Mining {
    IERC20 public token;
    using SafeERC20 for IERC20; 
    uint256 lastBlockNumber;
    address internal immutable WETH;
     constructor (address tokenAddress, address _WETH) {
        token = IERC20(tokenAddress);
        WETH = _WETH;
        lastBlockNumber = block.number;
    }

    // 质押ETH获得token,每个区块得到10个token
    // function depositeEthAndGetToken(address depositer, uint amount, ) public {
        
    // }

}