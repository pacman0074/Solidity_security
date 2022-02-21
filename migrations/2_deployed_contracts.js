const Vulnerable = artifacts.require("Vulnerable");
const Fixed = artifacts.require("Fixed");

module.exports = function(deployer) {
    deployer.deploy(Vulnerable);
    deployer.deploy(Fixed);
}