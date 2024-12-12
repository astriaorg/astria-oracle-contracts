pragma solidity ^0.8.21;

import {AggregatorV2V3Interface} from "./interfaces/AggregatorV2V3Interface.sol";
import {AstriaOracle} from "./AstriaOracle.sol";

// Mock currency pair aggregator contract for a single currency pair.
contract MockAggregator is AggregatorV2V3Interface {
    // core oracle contract
    AstriaOracle public immutable oracle;

    // currency pair hash
    bytes32 public immutable currencyPairHash;

    constructor(AstriaOracle _oracle, bytes32 _currencyPairHash) {
        oracle = _oracle;
        currencyPairHash = _currencyPairHash;
    }

    /* v2 aggregator interface */

    function latestAnswer() external view returns (int256) {
        (uint128 price,) = oracle.priceData(oracle.latestBlockNumber(), currencyPairHash);
        return int256(uint256(price));
    }

    function latestTimestamp() external view returns (uint256) {
        (, uint256 timestamp) = oracle.priceData(oracle.latestBlockNumber(), currencyPairHash);
        return timestamp;
    }

    function latestRound() external view returns (uint256) {
        return oracle.latestBlockNumber();
    }

    function getAnswer(uint256 roundId) external view returns (int256) {
        (uint128 price,) = oracle.priceData(roundId, currencyPairHash);
        return int256(uint256(price));
    }

    function getTimestamp(uint256 roundId) external view returns (uint256) {
        (, uint256 timestamp) = oracle.priceData(roundId, currencyPairHash);
        return timestamp;
    }

    /* v3 aggregator interface */

    function decimals() external view returns (uint8) {
        (, uint8 _decimals) = oracle.currencyPairInfo(currencyPairHash);
        return _decimals;
    }

    function description() external pure returns (string memory) {
        return "MockAggregator";
    }

    function version() external pure returns (uint256) {
        return 0;
    }

    function getRoundData(uint80 _roundId)
        external
        view
        returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound)
    {
        (uint128 price, uint256 timestamp) = oracle.priceData(_roundId, currencyPairHash);
        return (_roundId, int256(uint256(price)), timestamp, timestamp, _roundId);
    }

    function latestRoundData()
        external
        view
        returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound)
    {
        roundId = uint80(oracle.latestBlockNumber());
        (uint128 price, uint256 timestamp) = oracle.priceData(roundId, currencyPairHash);
        return (roundId, int256(uint256(price)), timestamp, timestamp, roundId);
    }
}
