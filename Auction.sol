// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Auction {
    address public owner;
    address public currentBidder;
    uint public currentBid;
    uint private minBid;
    bool public auctionInProgress;
    
    event Log(address indexed sender, string message, uint value);
    event Log(address indexed sender, string message);

    constructor() {
        owner = msg.sender;
        auctionInProgress = false;
        minBid = 2;
    }

    function startAuction( uint minimumBid) public  {
        require(msg.sender == owner, "Only the owner set minimum bid price");
        require(!auctionInProgress,"The minimum bid price can only be set before the auction starts");
        minBid = minimumBid;
        auctionInProgress = true; 
        emit Log(msg.sender, "The auction is now open and the starting bid price:",minBid);
    }

    
    function bid() public payable {
        require(msg.value > minBid, "The bid must exceed current bid price");
        require(auctionInProgress,"Auction is closed at this time");
        refund();
        currentBidder = msg.sender;
        currentBid = msg.value;
        minBid = msg.value;
        emit Log(msg.sender, "The current bid is:", currentBid );
    }

    
    function closeAuction() public {
        require(msg.sender == owner, "Only the owner can close the auction");
        require(auctionInProgress,"Auction is already closed");
        payable(owner).transfer(currentBid);
        auctionInProgress = false;
        emit Log(msg.sender, "The auction is now closed.");
    }

    function refund() private {
        payable(currentBidder).transfer(currentBid);

    }
}
