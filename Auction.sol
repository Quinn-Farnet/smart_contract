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

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    modifier auctionActive() {
        require(auctionInProgress, "The auction is not active");
        _;
    }

    constructor() {
        owner = msg.sender;
        auctionInProgress = false;
        minBid = 0 ether;
    }

    function startAuction(uint minimumBid) public onlyOwner {
        require(!auctionInProgress, "The minimum bid price can only be set before the auction starts");
        
        currentBidder = address(0); 
        currentBid = 0;            
        
        minBid = minimumBid * 1 ether;
        auctionInProgress = true; 
        emit Log(msg.sender, "The auction is now open and the starting bid price:", minBid);
    }

    function bid() public payable auctionActive {
        require(msg.value > minBid, "The bid must exceed current bid price"); 
        refund();

        currentBidder = msg.sender;
        currentBid = msg.value;
        minBid = msg.value;
       
        emit Log(msg.sender, "The current bid is:", currentBid);
    }

    function closeAuction() public onlyOwner auctionActive {
        payable(owner).transfer(currentBid);
        auctionInProgress = false;
        
        emit Log(msg.sender, "The auction is now closed.");
    }

    function refund() private {
        payable(currentBidder).transfer(currentBid);
    }
}
