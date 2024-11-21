# Auction Smart Contract

This Solidity contract enables secure auctions with real-time bidding, refunds, and owner controls.

## Features
- **Owner Actions**: Start/close auctions, set minimum bids.
- **Secure Bidding**: Tracks highest bid, refunds previous bidders.
- **Event Logs**: Tracks key actions for transparency.

## Key Functions
- `startAuction(uint minBid)`: Starts the auction with a minimum bid.
- `bid()`: Places a bid, ensuring refunds for previous bids.
- `closeAuction()`: Closes the auction and transfers funds to the owner.

## Usage
1. Deploy the contract on a blockchain.
2. Owner starts the auction with `startAuction`.
3. Participants bid using `bid()`.
4. Owner closes the auction with `closeAuction`.

## License
Licensed under the MIT License (SPDX identifier in the source code).
