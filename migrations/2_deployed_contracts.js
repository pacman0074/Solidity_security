const Vulnerable = artifacts.require("Vulnerable");
const Fixed = artifacts.require("Fixed");
const Destructor = artifacts.require("Destructor");
const Worker = artifacts.require("Worker");

module.exports = function(deployer) {
    deployer.deploy(Vulnerable);
    deployer.deploy(Fixed);
    deployer.deplopy(Destructor);
    deployer.deploy(Worker);
}