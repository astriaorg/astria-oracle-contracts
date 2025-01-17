// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Aggregator} from "../src/Aggregator.sol";
import {AggregatorV3Interface} from "../src/interfaces/AggregatorV3Interface.sol";

contract AggregatorScript is Script {
    function setUp() public {}

    function deploy() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        address oracleContractAddress = vm.envAddress("ORACLE_CONTRACT_ADDRESS");
        bytes32 currencyPairHash = keccak256(bytes(vm.envString("CURRENCY_PAIR")));
        new Aggregator(oracleContractAddress, currencyPairHash);

        vm.stopBroadcast();
    }

    function getLatestRoundData() public view {
        AggregatorV3Interface aggregator = AggregatorV3Interface(vm.envAddress("AGGREGATOR_CONTRACT_ADDRESS"));
        (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) =
            aggregator.latestRoundData();
        console.logUint(roundId);
        console.logInt(answer);
        console.logUint(startedAt);
        console.logUint(updatedAt);
        console.logUint(answeredInRound);
    }
}
