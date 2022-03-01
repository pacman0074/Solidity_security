// SPDX-License-Identifier: MIT
pragma solidity 0.8.12;

contract MyContract {

    address public owner;
    uint public balance;

    function myContract() public {
        owner = msg.sender;
        balance = address(this).balance;

    }

    
    function block() external view returns(uint){
        return block.timestamp;
    }

    function sendTo(address payable receiver, uint amount) public {
        require(tx.origin == owner,"toto");
        (bool success, ) = receiver.call{value:amount}("");
        require(success);
    }

    receive() external payable{}

}
