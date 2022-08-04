# Rocket Pool rETH Exchange Rate Oracle for Optimism

This repository contains 2 main contracts. `RocketOvmPriceMessenger` which can be called by anyone to submit the current
rETH exchange rate (as reported by `RocketNetworkBalances`) to the `RocketOvmPriceOracle` contract which is deployed on
Optimism OVM.

## Notice

Rocket Pool provides this exchange rate oracle as-is for convenience and offers no guarantee about its accuracy or the
freshness of the data. These contracts have not been formally audited for security or correctness.

## Usage

Calling `getRate()` on `RocketOvmPriceOracle` will return the latest rETH exchange rate reported. This value is in the form
of the ETH value of 1 rETH. e.g. If 1 rETH is worth 1.5 ETH `getRate()` will return 1.5e18. `getLastUpdated()` can be called to
retrieve the timestamp that the rate was last updated.

## Deployments

Rocket Pool maintains a Goerli testnet instance of the protocol alongside our mainnet deployment which can be used for 
integration testing before promotion to mainnet.

| Chain | RocketOvmPriceMessenger (EVM) | RocketOvmPriceOracle (OVM) |
| -- | -- | -- |
| Mainnet | tba | tba |
| Goerli | 0x3bF13C170a664e0CeAB1E878669F1Ef5A65280b5 | 0x96a6da00d79C6fa355B9D9f5b49488310E84D3a1 |

### Goerli

```
export RPC_OPTIMISM=https://goerli.optimism.io
export RPC_ETHEREUM=https://xxx
export PRIVATE_KEY=xxx
export ETHERSCAN_API_KEY=xxx

forge create \
  --legacy \
  --rpc-url $RPC_OPTIMISM \
  --private-key $PRIVATE_KEY \
  src/RocketOvmPriceOracle.sol:RocketOvmPriceOracle \
  --constructor-args 0x4200000000000000000000000000000000000007

forge create \
  --rpc-url $RPC_ETHEREUM \
  --private-key $PRIVATE_KEY \
  src/RocketOvmPriceMessenger.sol:RocketOvmPriceMessenger \
  --constructor-args 0xd8cd47263414afeca62d6e2a3917d6600abdceb3 0x96a6da00d79C6fa355B9D9f5b49488310E84D3a1 0x5086d1eef304eb5284a0f6720f79403b4e9be294 \
  --etherscan-api-key $ETHERSCAN_API_KEY \
  --verify
```
