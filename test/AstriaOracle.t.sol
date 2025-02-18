// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {AstriaOracle} from "../src/AstriaOracle.sol";

contract AstriaOracleTest is Test {
    AstriaOracle public oracle;
    address public oracleCallerAddress = 0x0000000000000000000000000000000000000089;
    address public owner;

    function setUp() public {
        owner = msg.sender;
        oracle = new AstriaOracle(oracleCallerAddress, false);
    }

    function test_initializeCurrencyPair_noAuthorizationNeeded() public {
        vm.prank(oracleCallerAddress);

        bytes32 pair = keccak256(bytes("ETH/USD"));
        oracle.initializeCurrencyPair(pair, 18);
        (bool initialized, uint8 decimals) = oracle.currencyPairInfo(pair);
        assert(initialized);
        assertEq(decimals, 18, "decimals should be 18");
    }

    function test_initializeCurrencyPair_authorizationNeeded() public {
        bytes32 pair = keccak256(bytes("ETH/USD"));
        oracle.setRequireCurrencyPairAuthorization(true);
        vm.expectRevert();
        vm.prank(oracleCallerAddress);
        oracle.initializeCurrencyPair(pair, 18);

        oracle.authorizeCurrencyPair(pair);
        vm.prank(oracleCallerAddress);
        oracle.initializeCurrencyPair(pair, 18);
        (bool initialized, uint8 decimals) = oracle.currencyPairInfo(pair);
        assert(initialized);
        assertEq(decimals, 18, "decimals should be 18");
    }
}
