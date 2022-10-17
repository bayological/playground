// SPDX-License-Identifier: Unlicensed
pragma solidity 0.8.15;

import { IMentoExchange } from "./interfaces/IMentoExchange.sol";
import { IMentoStable } from "./interfaces/IMentoStable.sol";

contract BuyStable {
    IMentoExchange public cUSDExchange;
    IMentoStable public cUSD;

    constructor(IMentoExchange _cUSDExchange, IMentoStable _cUSD) {
        cUSDExchange = _cUSDExchange;
        cUSD = _cUSD;
    }

    function doMinting(address to, uint256 value) external {
        // Create reference to Exchange
        // Create reference to cUSD
        // Approve Exchange to spend senders CELO
        //
    }
}
