// SPDX-License-Identifier: Unlicensed
pragma solidity 0.8.15;

interface IMentoExchange {
    function sell(
        uint256 sellAmount,
        uint256 minBuyAmount,
        bool sellCelo
    ) external returns (uint256);
}
