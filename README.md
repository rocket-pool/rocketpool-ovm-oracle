# Rocket Pool rETH Exchange Rate Oracle for Optimism

This repository contains 2 main contracts. `RocketOvmPriceMessenger` which can be called by anyone to submit the current
rETH exchange rate (as reported by `RocketNetworkBalances`) to the `RocketOvmPriceOracle` contract which is deployed on
Optimism OVM.

## Notice

Rocket Pool provides this exchange rate oracle as-is for convenience and offers no guarantee about its accuracy or the
freshness of the data. These contracts have not been formally audited for security or correctness.

## Usage

Calling `rate()` on `RocketOvmPriceOracle` will return the latest rETH exchange rate reported. This value is in the form
of the ETH value of 1 rETH. e.g. If 1 rETH is worth 1.5 ETH `rate()` will return 1.5e18. `lastUpdated()` can be called to
retrieve the timestamp that the rate was last updated.

## Deployments

Rocket Pool maintains a Goerli testnet instance of the protocol alongside our mainnet deployment which can be used for 
integration testing before promotion to mainnet.

| Chain | RocketOvmPriceMessenger (EVM) | RocketOvmPriceOracle (OVM) |
| -- | -- | -- |
| Mainnet | tba | tba |
| Goerli | 0x87E2deCE7d0A080D579f63cbcD7e1629BEcd7E7d | 0xc6307a58556FDcF93255ad541dccacCC10b75eA4 |
