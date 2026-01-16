// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "forge-std/console2.sol";

import {Hooks} from "@uniswap/v4-core/src/libraries/Hooks.sol";
import {HookMiner} from "@uniswap/v4-periphery/src/utils/HookMiner.sol";

import {BaseScript} from "./base/BaseScript.sol";

import {Counter} from "../src/Counter.sol";
import {IPoolManager} from "@uniswap/v4-core/src/interfaces/IPoolManager.sol";

/// @notice Mines the address and deploys the Counter.sol Hook contract
contract DeployHookScript is BaseScript {
    function run() public {
        poolManager = IPoolManager(0x0D9BAf34817Fccd3b3068768E5d20542B66424A5);
        // hook contracts must have specific flags encoded in the address
        uint160 flags = uint160(
            Hooks.BEFORE_SWAP_FLAG |
                Hooks.AFTER_SWAP_FLAG |
                Hooks.BEFORE_ADD_LIQUIDITY_FLAG |
                Hooks.BEFORE_REMOVE_LIQUIDITY_FLAG
        );

        // Mine a salt that will produce a hook address with the correct flags
        bytes memory constructorArgs = abi.encode(poolManager);
        (address hookAddress, bytes32 salt) = HookMiner.find(
            CREATE2_FACTORY,
            flags,
            type(Counter).creationCode,
            constructorArgs
        );

        // Deploy the hook using CREATE2
        vm.startBroadcast();
        Counter counter = new Counter{salt: salt}(poolManager);
        vm.stopBroadcast();

        require(
            address(counter) == hookAddress,
            "DeployHookScript: Hook Address Mismatch"
        );

        console2.log("Deployed counter", address(counter));
        console2.log("  Salt", uint256(salt));
    }
}
