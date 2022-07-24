// SPDX-License-Identifier: Unlicensed
pragma solidity 0.8.15;

/**
 * @notice Interface for the agreement contract.
 */
interface IAgreement {
    // Needs to allow offeror to create agreement. With info:
    //  - Terms. Token URI with JSON metadata.
    //        - e.g. https://ikzttp.mypinata.cloud/ipfs/QmQFkLSQysj94s5GvTHPyzTxrawwtjgiiYS2TBLgrvw8CW/1
    //  - State: Enum(Valid, Void, Executed)
    //  - Price: mapping(uint => mapping(address => uint)) agreement -> payment token -> amount
    //  - Due: timestamp of when agreement is due to be executed
    //  - Parties: Fixed address array(2) mapping(uint => address[]) address[0] = offeror, address[1] = offeree

    function acceptOffer()
}
