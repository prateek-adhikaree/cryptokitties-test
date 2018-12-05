# Cryptokitties test

Code taken from the cryptokitties repository: https://github.com/cryptocopycats/awesome-cryptokitties

## Functions used

Used the basic functions to support the following features:

- Create Promo kitty
- Make kitty pregnant
- Transfer

## Changes made to the contracts in order to test

- Removed function access modifiers such as onlyCEO, onlyCTO ..
- Removed "external" function calling necessity for certain functions
- Removed "whenNotPaused" function access specifiers where required

## Relevant file added

[TestKittyCore.sol](https://github.com/blocktest-official/cryptokitties-test/blob/master/contracts/TestKittyCore.sol)

## Contract Inheritance

This is the contract hierarchy used:
``` solidity
contract KittyAccessControl
contract KittyBase is KittyAccessControl
contract KittyOwnership is KittyBase, ERC721
contract KittyBreeding is KittyOwnership
contract KittyAuction is KittyBreeding
contract KittyMinting is KittyAuction
contract KittyCore is KittyMinting
contract TestKittyCore is KittyCore
```

## Methodology

BlockTEST’s patented testbed is an intelligent platform that evaluates blockchain projects based on objective performance measures.

We tested 11 basic CryptoKitties functions (i.e. createPromoKitty, isReadyToBreed, \_breedWith, approveSiring, and transfer), with minor adjustments within the code to enable the contracts for testing. 

We ran each contract through a series of tests, varying workload (1-4 threads) and network size (2-16 nodes). Through each test, the testbed monitors project performance and uses what it sees to calculate a number of metrics that measure the project’s efficiency, security, and scalability.

The testbed currently supports projects built on Ethereum and Hyperledger.

## Synopsis

Overall, the CryptoKitties blockchain displays impressive scalability and performance efficiency with respect to variable network and workload sizes.

With each increase in workload level, meaning a doubled number of transactions, latency increased by <10% and throughput increased by roughly 50%. This indicates that the CryptoKitties blockchain responds appropriately to stress on the network – more transactions are passed per second, and speeds remain relatively stable despite more activity.

CryptoKitties’ failure rate is low across the board, staying below .02% regardless of network or workload size. Across all metrics we tested, (including latency, throughput, fail ratio, CPU usage and RAM usage) all remain fairly stable with respect to network size, adjusting appropriately with the addition of new nodes.

CryptoKitties employs an impressive deployment hierarchy with few vulnerabilities. Our testbed highlighted only informational warnings: multiple sends executed in a single transaction in the createAuction function, and an unchecked call return value in the withdrawBalance function.

## One page report

Curious to read more? Check out the full report here:

[BlockTEST_One_Page_Report.pdf](https://github.com/blocktest-official/cryptokitties-test/blob/master/BlockTEST_One_Page_Report.pdf)

## Questions?

Feel free to reach us at prateek.adhikaree@blocktest.net
