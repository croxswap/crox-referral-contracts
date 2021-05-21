// SPDX-License-Identifier: MIT

//** CroxSwap Migration Script */
//** Author Alex Hong : CroxSwap 2021.5 */

const Migrations = artifacts.require("Migrations");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
};
