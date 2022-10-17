// SPDX-License-Identifier: Unlicensed
pragma solidity 0.8.15;

import { IERC20 } from "openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";
import { IMentoExchange } from "./interfaces/IMentoExchange.sol";

contract BuyStable {
    IMentoExchange public cUSDExchange;
    IERC20 public celoToken;
    IERC20 public cUSDToken;

    constructor(
        IMentoExchange _cUSDExchange,
        IERC20 _celoToken,
        IERC20 _cUSDToken
    ) {
        cUSDExchange = _cUSDExchange;
        celoToken = _celoToken;
        cUSDToken = _cUSDToken;
    }

    function BuyStableWithCelo(uint256 amountOfCeloToSell) external {
        // Approve spend
        celoToken.approve(msg.sender, amountOfCeloToSell);

        // Transfer Celo to contract
        celoToken.transferFrom(msg.sender, address(this), amountOfCeloToSell);

        // Sell a known amount of CELO for cUSD
        uint256 cUSDReceived = cUSDExchange.sell(amountOfCeloToSell, 0, true);

        // Transfer cUSD to msg sender
        cUSDToken.transfer(msg.sender, cUSDReceived);
    }
}
