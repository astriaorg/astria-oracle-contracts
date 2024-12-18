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
