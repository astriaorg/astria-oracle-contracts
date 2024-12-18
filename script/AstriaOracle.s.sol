// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {AstriaOracle} from "../src/AstriaOracle.sol";

contract AstriaOracleScript is Script {
    AstriaOracle public astriaOracle;

    function setUp() public {}

    function deploy() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        address oracleSenderAddress = vm.envAddress("EVM_ORACLE_SENDER_ADDRESS");
        AstriaOracle oracle = new AstriaOracle(oracleSenderAddress);

        vm.stopBroadcast();

        console.logBytes(address(oracle).code);
    }

    function getPrice() public view {
        address oracleContract = vm.envAddress("ORACLE_CONTRACT_ADDRESS");
        AstriaOracle oracle = AstriaOracle(oracleContract);
        bytes32 pair = keccak256("ETH/USD");
        uint256 latestBlockNumber = oracle.latestBlockNumber();
        (uint128 price,) = oracle.priceData(latestBlockNumber, pair);
        console.logUint(price);
    }
}
