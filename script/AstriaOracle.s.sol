// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {AstriaOracle} from "../src/AstriaOracle.sol";

contract AstriaOracleScript is Script {
    AstriaOracle public astriaOracle;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        astriaOracle = new AstriaOracle();

        vm.stopBroadcast();
    }
}
