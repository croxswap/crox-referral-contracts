// SPDX-License-Identifier: MIT

//** CroxSwap Migration Script */
//** Author Alex Hong : CroxSwap 2021.5 */

const CroxReferral = artifacts.require("CroxReferral");
const CroxTimelock = artifacts.require("CroxTimelock");

module.exports = function (deployer) {
  deployer.deploy(CroxReferral);
  deployer.deploy(
    CroxTimelock,
    "0x23853fde632616E7f3BBa4C7662b86A21A326A89",
    60 * 2
  );
};
