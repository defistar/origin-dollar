pragma solidity 0.5.11;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import { IUniswapV2Router } from "../interfaces/uniswap/IUniswapV2Router02.sol";
import { Helpers } from "../utils/Helpers.sol";
import { StableMath } from "../utils/StableMath.sol";

contract MockUniswapRouter is IUniswapV2Router {
    using StableMath for uint256;

    address tok0;
    address tok1;

    address public WETH = address(0);

    function initialize(address _token0, address _token1) public {
        tok0 = _token0;
        tok1 = _token1;
    }

    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts) {
        IERC20(tok0).transferFrom(msg.sender, address(this), amountIn);
        IERC20(tok1).transfer(
            to,
            amountIn.scaleBy(
                int8(Helpers.getDecimals(tok1) - Helpers.getDecimals(tok0))
            )
        );
    }
}
