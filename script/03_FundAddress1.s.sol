// script/testing/DeployTestTokens.s.sol
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "forge-std/console2.sol";

import {MockERC20} from "solmate/src/test/utils/mocks/MockERC20.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DeployTestTokens is Script {
    function run() external {
        vm.startBroadcast();

        address token0 = address(0x3Aa5ebB10DC797CAC828524e59A333d0A371443c);
        address token1 = address(0xc6e7DF5E7b4f2A278906862b61205850344D4e7d);

        IERC20(token0).transfer(0x70997970C51812dc3A010C7d01b50e0d17dc79C8, 2_000 ether);
        IERC20(token1).transfer(0x70997970C51812dc3A010C7d01b50e0d17dc79C8, 2_000 ether);

        vm.stopBroadcast();
    }
}
