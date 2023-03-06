// SPDX-License-Identifier: Unlicensed
pragma solidity 0.8.15;

import { Ownable } from "oz-contracts/access/Ownable.sol";
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
contract AgreementManager is IAgreementManager, Ownable {
  enum AgreementStatus {
    DRAFT,
    NEGOTIATION,
    ACCEPTED,
    EXECUTION,
    FULFILLED,
    BREACH,
    DISPUTE,
    CLOSED
  }

  /*//////////////////////////////////////////////////////////////
                            State Variables
    //////////////////////////////////////////////////////////////*/

  // Maps an agreement ID to an agreement struct
  mapping(uint256 => Agreement) public agreements;

  // Maps a token address to a boolean indicating if it is an allowed payment token
  mapping(address => bool) public isPaymentToken;

  // The next agreement ID to be used
  uint256 private nextId = 0;

  /*//////////////////////////////////////////////////////////////
                            Constructor
    //////////////////////////////////////////////////////////////*/

  constructor(address[] memory _paymentTokens) {
    addPaymentTokens(_paymentTokens);
  }

  /*//////////////////////////////////////////////////////////////
                            Mutative Functions
    //////////////////////////////////////////////////////////////*/

  /*********************** Payment Tokens ***********************/

  function addPaymentTokens(address[] memory _paymentTokens) public onlyOwner {
    for (uint256 i = 0; i < _paymentTokens.length; i++) {
      isPaymentToken[_paymentTokens[i]] = true;
    }
  }

  function removePaymentToken(address _paymentToken) public onlyOwner {
    isPaymentToken[_paymentToken] = false;
  }

  /*********************** Agreements ***********************/

  function createAgreement(
    address paymentToken,
    uint256 paymentAmount,
    uint256 deadline,
    address offeree
  ) external returns (uint256 agreementId) {
    if (!isPaymentToken[paymentToken]) revert PaymentTokenNotAccepted();
    if (paymentAmount == 0) revert PaymentAmountCannotBeZero();
    if (offeree == msg.sender) revert OffereeCannotBeOfferor();
    if (block.timestamp >= deadline) revert DeadlineMustBeInFuture();

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
