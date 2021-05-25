// SPDX-License-Identifier: MIT

//** CroxSwap Migration Contract */
//** Author Alex Hong : CroxSwap 2021.5 */

pragma solidity 0.6.6;

interface ICroxReferral {
  /**
   * @dev event when new referral recorded
   */
  event ReferralRecorded(address indexed user, address indexed referrer);

  /**
   * @dev event when new commissions recorded
   */
  event ReferralCommissionRecorded(
    address indexed referrer,
    uint256 commission
  );

  /**
   * @dev even when admin role updated
   */
  event AdminUpdated(address indexed admin, bool indexed status);

  /**
   * @dev Record referral.
   */
  function recordReferral(address user, address referrer) external;

  /**
   * @dev Record referral commission.
   */
  function recordReferralCommission(address referrer, uint256 commission)
    external;

  /**
   * @dev Get the referrer address that referred the user.
   */
  function getReferrer(address user) external view returns (address);
}
