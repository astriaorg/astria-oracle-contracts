# astria-oracle-contracts

Repository of contracts used for Astria's native oracle.

### deploy 

Copy the example .env: `cp local.env.example .env`

Put your private key in `.env` and `source .env`.

To deploy `AstriaOracle.sol`:

```sh
forge script script/AstriaOracle.s.sol:AstriaOracleScript \
   --rpc-url $RPC_URL --broadcast --sig "deploy()" -vvvv
```

### query contract

The script has an example function which calls `getPrice()` for `ETH/USD`. You can update the test for different currency pair strings to get their price.

```sh
forge script script/AstriaOracle.s.sol:AstriaOracleScript    --rpc-url $RPC_URL --broadcast --sig "getPrice()" -vvvv
```

### deploy an aggregator 

In `.env`, set `ORACLE_CONTRACT_ADDRESS` to the contract address of a deployed `AstriaOracle` contract and set `CURRENCY_PAIR` to the desired currency pair.

```sh
forge script script/Aggregator.s.sol:AggregatorScript   --rpc-url $RPC_URL --broadcast --sig "deploy()" -vvvv
```

### query aggregator
