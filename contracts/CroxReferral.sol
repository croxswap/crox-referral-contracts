// SPDX-License-Identifier: MIT

//** CroxSwap Referral Contract */
//** Author Alex Hong : CroxSwap 2021.5 */

pragma solidity 0.6.6;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./libraries/IBEP20.sol";
import "./libraries/SafeBEP20.sol";
import "./interface/ICroxReferral.sol";

contract CroxReferral is ICroxReferral, Ownable {
  using SafeBEP20 for IBEP20;

  /**
   * @dev admins is the mapping of address list indiciating admin status
   */
  mapping(address => bool) public admins;

  /**
   * @dev referrers is indiciting mapping list of user and referrer, user => referrer
   */
  mapping(address => address) public referrers;

  /**
   * @dev refferalsCount will indicatings referral counts of per referrer account
   */
  mapping(address => uint256) public referralsCount;

  /**
   * @dev totalReferralComission indiciating the total earned referral comissions per referrer address
   */
  mapping(address => uint256) public totalReferralCommissions;

  /**
   * @dev this modifier will verify if sender is registered as admin
   */
  modifier onlyAdmin {
    require(admins[msg.sender], "Admin: caller is not the admin");
    _;
  }

  /**
   * @dev record new referral
   * _user is address of customer who is going to trying referral link
   * _referrer is address of referrer who shared referral link
   */
  function recordReferral(address _user, address _referrer)
    public
    override
    onlyAdmin
  {
    if (
      _user != address(0) &&
      _referrer != address(0) &&
      _user != _referrer &&
      referrers[_user] == address(0)
    ) {
      /** update referrers and refferalsCount mappings */
      referrers[_user] = _referrer;
      referralsCount[_referrer] += 1;

      /** emit the new referral update event */
      emit ReferralRecorded(_user, _referrer);
    }
  }

  /**
   * @dev record new referral commission
   * _referrer is address of referrer who shares referral link
   * _commission is the commission generated from rewards from farm
   */
  function recordReferralCommission(address _referrer, uint256 _commission)
    public
    override
    onlyAdmin
  {
    if (_referrer != address(0) && _commission > 0) {
      /** update total gained commissions of referrer when condition is meet */
      totalReferralCommissions[_referrer] += _commission;

      /** emit the event of new commisions recorded */
      emit ReferralCommissionRecorded(_referrer, _commission);
    }
  }

  /**
   * @dev get the referrer address that referred the user
   * _user is address of the referred the user and it returns address of referrer
   */
  function getReferrer(address _user) public view override returns (address) {
    return referrers[_user];
  }

  /**
   * @dev update the status of admin role
   * _admin is address of admin and _status indiciates the status of admin willing to change
   */
  function updateAdmin(address _admin, bool _status) external onlyOwner {
    /** update hte admin status, should be owner access */
    admins[_admin] = _status;

    /** emit the admin update event */
    emit AdminUpdated(_admin, _status);
  }
}
