// script/testing/DeployTestTokens.s.sol
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "forge-std/console2.sol";

import {MockERC20} from "solmate/src/test/utils/mocks/MockERC20.sol";

contract DeployTestTokens is Script {
    function run() external {
        vm.startBroadcast();

        MockERC20 token0 = new MockERC20("Token A", "TKA", 18);
        MockERC20 token1 = new MockERC20("Token B", "TKB", 18);

        token0.mint(msg.sender, 1_000_000 ether);
        token1.mint(msg.sender, 1_000_000 ether);

        console2.log("Token0:", address(token0));
        console2.log("Token1:", address(token1));

        vm.stopBroadcast();
    }
}
