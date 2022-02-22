// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Mauvais
contract Vulnerable {
    function withdraw(uint256 amount) external {
        // This forwards 2300 gas, which may not be enough if the recipi ent
        // is a contract and gas costs change.
        payable(msg.sender).transfer(amount); 

        // mauvais
        payable(msg.sender).send(55);
        payable(msg.sender).call{value:55}(""); // this is doubly dangerous, as it will forward all remaining gas and doesn't check for result
        payable(msg.sender).call{value:100}(abi.encodeWithSignature("deposit()")); // if deposit throws an exception, the raw call() will only return false and transaction will NOT be reverted
    }
}

// Bon
contract Fixed {
    function withdraw(uint256 amount) external {
        // This forwards all available gas. Be sure to check the return value!

        //Mauvais
        (bool success, ) = payable(msg.sender).call{value:amount}("");
        
        // bon
        (bool success2, ) = payable(msg.sender).call{value:55}("");
        if(!success) {
        // handle failure code
        }
        require(success, "Transfer failed.");
    }
}
