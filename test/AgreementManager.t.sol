// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.15;

// solhint-disable func-name-mixedcase

import { PRBTest } from "@prb/test/PRBTest.sol";
import { StdCheats } from "forge-std/StdCheats.sol";

import { IAgreementManager } from "contracts/interfaces/IAgreementManager.sol";
import { AgreementManager } from "contracts/AgreementManager.sol";

contract AgreementManagerTest is PRBTest, StdCheats {
  address public deployer;
  address public fakeOfferor;
  address public fakeOfferee;

  AgreementManager public agreementManager;

  function setUp() public {
    deployer = makeAddr("deployer");
    fakeOfferor = makeAddr("fakeOfferor");
    fakeOfferee = makeAddr("fakeOfferee");

    address[] memory paymentTokens = new address[](1);
    paymentTokens[0] = makeAddr("testToken");

    agreementManager = new AgreementManager(paymentTokens);
  }

  function test_createAgreement_whenInValidPaymentTokenIsUsed_shouldRevert() public {
    changePrank(fakeOfferor);
    address paymentToken = makeAddr("invalidToken");

    vm.expectRevert(IAgreementManager.PaymentTokenNotAccepted.selector);
    agreementManager.createAgreement(paymentToken, 1 ether, block.timestamp + 6 weeks, fakeOfferee);
  }

  function test_createAgreement_whenPaymentAmountIsZero_shouldRevert() public {
    changePrank(fakeOfferor);
    address paymentToken = makeAddr("testToken");

    vm.expectRevert(IAgreementManager.PaymentAmountCannotBeZero.selector);
    agreementManager.createAgreement(paymentToken, 0, block.timestamp + 6 weeks, fakeOfferee);
  }

  function test_createAgreement_whenDeadlineIsInThePast_shouldRevert() public {
    changePrank(fakeOfferor);
    address paymentToken = makeAddr("testToken");

    vm.expectRevert(IAgreementManager.DeadlineMustBeInFuture.selector);
    agreementManager.createAgreement(paymentToken, 1 ether, block.timestamp - 1, fakeOfferee);
  }

  function test_createAgreement_whenOffereeIsOfferor_shouldRevert() public {
    changePrank(fakeOfferor);
    address paymentToken = makeAddr("testToken");

    vm.expectRevert(IAgreementManager.OffereeCannotBeOfferor.selector);
    agreementManager.createAgreement(paymentToken, 1 ether, block.timestamp + 6 weeks, fakeOfferor);
  }
}
