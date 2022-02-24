const Vulnerable = artifacts.require("Vulnerable");
const Fixed = artifacts.require("Fixed");
const Destructor = artifacts.require("Destructor");
const Worker = artifacts.require("Worker");
const Registry = artifacts.require("Registry");
const Election = artifacts.require("Election");
const SendEtherGoodWay = artifacts.require("SendEtherGoodWay");
const SendEtherBadWay = artifacts.require("SendEtherBadWay");
const MyContract = artifacts.require("MyContract");
const AttackingContract = artifacts.require("AttackingContract");

module.exports = function(deployer) {
    deployer.deploy(Vulnerable);
    deployer.deploy(Fixed);
    deployer.deplopy(Destructor);
    deployer.deploy(Worker);
    deployer.deploy(Registry);
    deployer.deploy(Election);
    deployer.deploy(SendEtherGoodWay);
    deployer.deploy(SendEtherBadWay);
    deployer.deploy(MyContract);
    deployer.deploy(AttackingContract);
}