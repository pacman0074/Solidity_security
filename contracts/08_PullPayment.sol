// SPDX-License-Identifier: MIT
pragma solidity 0.8.12;
 
contract auction {
    address public highestBidder;
    uint public highestBid;
 
    function bid() payable public {
        require(msg.value >= highestBid);
 
        if (highestBidder != address(0)) {
            (bool success, ) = highestBidder.call{value:highestBid}("");
            require(success); // if this call consistently fails, no one else can bid
        }
 
       highestBidder = msg.sender;
       highestBid = msg.value;
    }
}

contract auctionFixed {
    address highestBidder;
    uint highestBid;
    mapping(address => uint) refunds;
 
    function bid() payable external {
        require(msg.value >= highestBid);
 
        if (highestBidder != address(0)) {
            refunds[highestBidder] += highestBid; // record the refund that this user can claim
        }
 
        highestBidder = msg.sender;
        highestBid = msg.value;
    }
 
    function withdrawRefund() external {
        uint refund = refunds[msg.sender];
        refunds[msg.sender] = 0;
        (bool success, ) = msg.sender.call{value:refund}("");
        require(success);
    }
}