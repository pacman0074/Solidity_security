// SPDX-License-Identifier: MIT
pragma solidity 0.8.12;

contract Crowdsale {
 
   address public owner; // the owner of the contract
   address public escrow; // wallet to collect raised ETH
   uint256 public savedBalance = 0; // Total amount raised in ETH
   mapping (address => uint256) public balances; // Balances in incoming Ether
 
   // Initialization
   constructor (address _escrow) {
       //owner = tx.origin; //TxOrigin faille
       owner = msg.sender;
       // add address of the specific contract
       escrow = _escrow;
   }
  
   // function to receive ETH
   //function() public { //Pour recevoir des ethers un contrat doit avoir soit une fonction receive soit une fonction fallback
   receive() external payable {
       balances[msg.sender] += msg.value;
       savedBalance += msg.value;
       (bool success, ) = payable(escrow).call{value : msg.value}("");//Absurde , on lui redonne les ethers qu'il a envoyé les contrats
       require(success);
   }
  
   // refund investisor
   function withdrawPayments() public{
       address payee = msg.sender;
       uint256 payment = balances[payee];

       savedBalance -= payment;
       balances[payee] = 0;
 
       (bool success, ) = payable(payee).call{value : payment}("");//Reentrency
       require(success);
 
       //savedBalance -= payment;
       //balances[payee] = 0;
   }
}


contract CrowdsaleFixed {
    
  address public owner; // the owner of the contract
  address payable public escrow; // wallet to collect raised ETH
  uint256 public savedBalance = 0; // Total amount raised in ETH
  mapping (address => uint256) public balances; // Balances in incoming Ether
  // Event to record each time Ether is paid out
  event PayEther( 
  address indexed _receiver,
  uint256 indexed _value,
  uint256 indexed _timestamp
  );
  // Initialization
  constructor (address payable _escrow) {
      owner = msg.sender;
      // add address of the specific contract
      escrow = _escrow;
  }
   // function to receive ETH
  receive() payable external {
      balances[msg.sender] += msg.value;
      savedBalance += msg.value;
      escrow.call{value:msg.value};
      emit PayEther(escrow, msg.value, block.timestamp);
  }
   // refund investisor
   //to refund investor, escrow SC needs to refund before calling this function
  function withdrawPayments() public{
      address payable payee = payable(msg.sender);
      uint256 payment = balances[payee];
      require(payment != 0);
      require(address(this).balance >= payment);
    
      savedBalance -= payment;
      balances[payee] = 0;
    
      payee.call{value:payment};
      emit PayEther(payee, payment, block.timestamp);
  }
}


contract CrowdsaleFixed2 {
    
  uint256 public savedBalance = 0; // Total amount raised in ETH
  mapping (address => uint256) public balances; // Balances in incoming Ether
  // Event to record each time Ether is paid out
  event PayEther(
  address indexed _receiver,
  uint256 indexed _value,
  uint256 indexed _timestamp
  );
  // function to receive ETH
  receive() payable external {
      balances[msg.sender] += msg.value;
      savedBalance += msg.value;
      emit PayEther(address(this), msg.value, block.timestamp);
  }
   // refund investisor
  function withdrawPayments() public{
      address payable payee = payable(msg.sender);
      uint256 payment = balances[payee];
      require(payment != 0);
      require(address(this).balance >= payment);
    
      savedBalance -= payment;
      balances[payee] = 0;
    
      payee.call{value:payment};
      emit PayEther(payee, payment, block.timestamp);
  }
}

