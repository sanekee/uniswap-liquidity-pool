// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {PoolKey} from "@uniswap/v4-core/src/types/PoolKey.sol";

import {BaseScript} from "./base/BaseScript.sol";

import {IPoolManager} from "@uniswap/v4-core/src/interfaces/IPoolManager.sol";

import {IPositionManager} from "@uniswap/v4-periphery/src/interfaces/IPositionManager.sol";

import {IUniswapV4Router04} from "hookmate/interfaces/router/IUniswapV4Router04.sol";

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SwapScript is BaseScript {
    function run() external {
        poolManager = IPoolManager(0x0D9BAf34817Fccd3b3068768E5d20542B66424A5);
        positionManager = IPositionManager(0x90aAE8e3C8dF1d226431D0C2C7feAaa775fAF86C);

        swapRouter = IUniswapV4Router04(payable(0xB61598fa7E856D43384A8fcBBAbF2Aa6aa044FfC));

        PoolKey memory poolKey = PoolKey({
            currency0: currency0,
            currency1: currency1,
            fee: 3000,
            tickSpacing: 60,
            hooks: hookContract // This must match the pool
        });
        bytes memory hookData = new bytes(0);

        vm.startBroadcast();

        // We'll approve both, just for testing.
        if (address(token1) != address(0)) {
            IERC20(token1).approve(address(swapRouter), type(uint256).max);
        }
        if (address(token0) != address(0)) {
            IERC20(token0).approve(address(swapRouter), type(uint256).max);
        }

        // Execute swap
        swapRouter.swapExactTokensForTokens({
            amountIn: 1_000,
            amountOutMin: 0, // Very bad, but we want to allow for unlimited price impact
            zeroForOne: true,
            poolKey: poolKey,
            hookData: hookData,
            // receiver: address(this),
            receiver: msg.sender,
            // deadline: block.timestamp + 30
            deadline: type(uint256).max
        });

        vm.stopBroadcast();
    }
}
