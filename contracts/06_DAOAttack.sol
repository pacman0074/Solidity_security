// SPDX-License-Identifier: MIT
pragma solidity 0.8.12;

contract Bob {
  bool sent = false;
  function ping(address c) public {
      if(!sent){
          (bool success, ) = c.call{value: 2}("");
          if(success){
          sent = true;
          }
      }
  }
}
contract Mallory{
  fallback () external {
      Bob(msg.sender).ping(address(this));
  }
}
