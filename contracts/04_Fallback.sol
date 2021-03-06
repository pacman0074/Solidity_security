// SPDX-License-Identifier: MIT
pragma solidity 0.8.12;

contract SendEtherGoodWay{

event LogDepositReceived(address sender);
mapping (address => uint256) balances;
// mauvais
fallback() external payable { balances[msg.sender] += msg.value; }

}

contract SendEtherBadWay{

event LogDepositReceived(address sender);
mapping (address => uint256) balances;
// bon
function deposit() payable external { balances[msg.sender] += msg.value; }

fallback() external payable { require(msg.data.length == 0); emit LogDepositReceived(msg.sender); }
receive() external payable{}

}


