// SPDX-License-Identifier: MIT or Apache-2.0
pragma solidity ^0.8.21;

// Core oracle contract for Astria's native oracle.
// This contract stores the price data for every currency pair supported by the oracle.
contract AstriaOracle {
    // the `astriaOracleSenderAddress` built into the astria-geth node
    address public immutable ORACLE;

    struct PriceData {
        uint128 price;
        uint256 timestamp;
    }

    // mapping of block number to mapping of hash of the currency pair string to its price data
    mapping(uint256 => mapping(bytes32 => PriceData)) public priceData;

    struct CurrencyPairInfo {
        // require an explicit initialization boolean, as otherwise the default value of 0 would be ambiguous
        bool initialized;
        uint8 decimals;
    }

    // mapping of hash of the currency pair string to the number of decimals the price is represented in
    mapping(bytes32 => CurrencyPairInfo) public currencyPairInfo;

    // block number of the latest price data update
    uint256 public latestBlockNumber;

    modifier onlyOracle() {
        require(msg.sender == ORACLE, "AstriaOracle: only oracle can update");
        _;
    }

    constructor(address _oracle) {
        ORACLE = _oracle;
    }

    function initializeCurrencyPair(bytes32 _currencyPair, uint8 _decimals) external onlyOracle {
        currencyPairInfo[_currencyPair] = CurrencyPairInfo(true, _decimals);
    }

    function updatePriceData(bytes32[] memory _currencyPairs, uint128[] memory _prices) external onlyOracle {
        require(_currencyPairs.length == _prices.length, "currency pair and price length mismatch");
        latestBlockNumber = block.number;
        for (uint256 i = 0; i < _currencyPairs.length; i++) {
            priceData[latestBlockNumber][_currencyPairs[i]] = PriceData(_prices[i], block.timestamp);
        }
    }
}
