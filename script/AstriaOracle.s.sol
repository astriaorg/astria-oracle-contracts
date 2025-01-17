// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {AstriaOracle} from "../src/AstriaOracle.sol";

contract AstriaOracleScript is Script {
    function deploy() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        address oracleSenderAddress = vm.envAddress("EVM_ORACLE_SENDER_ADDRESS");
        new AstriaOracle(oracleSenderAddress);

        vm.stopBroadcast();
    }

    function initializeCurrencyPairsAndSetPrices() public {
        address oracleContract = vm.envAddress("ORACLE_CONTRACT_ADDRESS");
        AstriaOracle oracle = AstriaOracle(oracleContract);

        vm.startBroadcast(vm.envUint("EVM_ORACLE_SENDER_ADDRESS_PRIVATE_KEY"));

        bytes32 pairA = keccak256(bytes(vm.envString("CURRENCY_PAIR_A")));
        bytes32 pairB = keccak256(bytes(vm.envString("CURRENCY_PAIR_B")));
        bytes32[] memory pairs = new bytes32[](2);
        pairs[0] = pairA;
        pairs[1] = pairB;
        uint128[] memory prices = new uint128[](2);
        prices[0] = uint128(400000000000000);
        prices[1] = uint128(500000000000000);

        oracle.initializeCurrencyPair(pairA, 18);
        oracle.initializeCurrencyPair(pairB, 18);
        oracle.updatePriceData(pairs, prices);

        vm.stopBroadcast();
    }

    function getPrice() public view {
        address oracleContract = vm.envAddress("ORACLE_CONTRACT_ADDRESS");
        AstriaOracle oracle = AstriaOracle(oracleContract);
        bytes32 pair = keccak256(bytes(vm.envString("CURRENCY_PAIR_A")));
        uint256 latestBlockNumber = oracle.latestBlockNumber();
        (uint128 price,) = oracle.priceData(latestBlockNumber, pair);
        console.logUint(price);
    }
}
