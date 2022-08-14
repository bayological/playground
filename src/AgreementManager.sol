// SPDX-License-Identifier: Unlicensed
pragma solidity 0.8.15;

import { IAgreementManager } from "./interfaces/IAgreementManager.sol";

/**
 * @notice  Allows the creation of an agreement between two parties to perform some service.
 *          One party must offer to enter into an agreement and the other must accept
 *          the terms of the agreement. Each agreement has two parties, offeror and offeree.
 *          The offeror first defines the terms of the offer, including token for payment
 *          and amount of token. Then the offeror will add thier signature and send the
 *          agreement to the offeree. The offeree can either accept or reject the agreement.
 *          If they accept, their signature is added to the agreement, the requested amount
 *          is deducted and transfered to the chescrow contract along with the Agreement.
 */
contract AgreementManager is IAgreementManager {
    mapping(uint256 => Agreement) agreements;
    uint256 private nextId = 0;

    function createAgreement(
        address paymentToken,
        uint256 paymentAmount,
        uint256 deadline,
        address offeree
    ) external returns (uint256 agreementId) {
        if (block.timestamp >= deadline) revert DeadlineMustBeInFuture();
        if (paymentAmount == 0) revert PaymentIsZero();
        if (offeree == msg.sender) revert OffereeIsOfferor();

        Agreement memory newAgreement;

        newAgreement.deadline = deadline;
        newAgreement.paymentToken = paymentToken;
        newAgreement.paymentAmount = paymentAmount;
        newAgreement.offeree = offeree;
        newAgreement.offeror = msg.sender;

        agreementId = nextId;

        agreements[agreementId] = newAgreement;

        nextId++;
    }
}
