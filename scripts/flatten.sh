#!/bin/sh

rm -rf temp
mkdir -p temp

cd contracts
find . -type f -name "*.sol" -exec sed -i 's/pragma solidity 0.4.18/pragma solidity ^0.4.18/g' {} +
cd ..

alias flatten="solidity_flattener --solc-paths zeppelin-solidity=$(pwd)/node_modules/zeppelin-solidity"

flatten contracts/WyvernToken.sol --output temp/WyvernTokenFlattened.sol
flatten contracts/WyvernDAO.sol --output temp/WyvernDAOFlattened.sol
flatten contracts/WyvernExchange.sol --output temp/WyvernExchangeFlattened.sol
flatten contracts/WyvernProxyRegistry.sol --output temp/WyvernProxyRegistryFlattened.sol

cd contracts
find . -type f -name "*.sol" -exec sed -i 's/pragma solidity ^0.4.18/pragma solidity 0.4.18/g' {} +
cd ..
