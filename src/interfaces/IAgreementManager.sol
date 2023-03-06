// SPDX-License-Identifier: Unlicensed
pragma solidity 0.8.15;

/**
 * @notice Interface for the agreement manager contract.
 */
interface IAgreementManager {
  struct Agreement {
    address offeree;
    address offeror; // The service provider
    uint256 deadline;
    address paymentToken;
    uint256 paymentAmount;
    string terms; // IPFS hash?
  }

  error DeadlineMustBeInFuture();
  error PaymentAmountCannotBeZero();
  error OffereeCannotBeOfferor();
  error PaymentTokenNotAccepted();

  /**
   * @notice Creates an agreement with the specified details.
   * @param paymentToken The token to be used for payment.
   * @param paymentAmount The amount of payment token required.
   * @param deadline The deadline for the completion of the service.
   * @param offeree Address of the indended offeree.
   */
  function createAgreement(
    address paymentToken,
    uint256 paymentAmount,
    uint256 deadline,
    address offeree
  ) external returns (uint256 agreementId);
}
