var Casino = artifacts.require("./Casino.sol");
module.exports = function(deployer) {
  deployer.deploy(web3.toWei(0.1, 'ether'), 100, {gas: 300000000000000});
};
