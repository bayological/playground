// SPDX-License-Identifier: Unlicensed
pragma solidity 0.8.15;

import { IAgreement } from "./interfaces/IAgreement.sol";

/**
 * @notice  Represents an agreement between two parties to perform some service.
 *          One party must offer to enter into an agreement and the other must accept
 *          the terms of the offer. Each agreement has two parties, offeror and offeree.
 *          The offeror first defines the terms of the offer, including token for payment
 *          and amount of token. Then the offeror will add thier signature and send the
 *          agreement to the offeree. The offeree can either accept or reject the agreement.
 *          If they accept, their signature is added to the agreement, the requested amount
 *          is deducted and transfered to the chescrow contract along with the Agreement.
 */
contract Agreement is IAgreement {

}
