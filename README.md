# Auction Smart Contract

This project is a simple **Auction Smart Contract** implemented in Solidity. The contract allows an owner to create and manage an auction where participants can place bids. It ensures secure bidding and guarantees the highest bid is recorded while refunding previous bids.

---

## Features
- **Auction Initialization**: Allows the owner to set a minimum starting bid and open the auction.
- **Secure Bidding**: Tracks the highest bidder and ensures refunds for previous bids.
- **Owner Controls**: Only the owner can start and close the auction.
- **Event Logging**: Provides transparency by emitting events for key actions.

---

## Contract Details

### State Variables
- `owner` (address): Stores the address of the auction owner.
- `currentBidder` (address): Stores the address of the highest bidder.
- `currentBid` (uint): Tracks the current highest bid.
- `minBid` (uint, private): The minimum acceptable bid amount.
- `auctionInProgress` (bool): Indicates whether the auction is active.

### Events
- `Log(address indexed sender, string message, uint value)`: Logs actions with associated values (e.g., bids).
- `Log(address indexed sender, string message)`: Logs actions without values (e.g., auction closure).

---

## Functions

### `constructor()`
Initializes the contract with the following:
- Sets the deploying address as the owner.
- Sets the initial state of the auction as inactive.
- Sets the default `minBid` to 2.

---

### `startAuction(uint minimumBid)`
Starts the auction with a user-defined `minimumBid`.

#### Requirements:
- Only the owner can call this function.
- The auction must not already be in progress.

#### Actions:
- Updates the `minBid` to the provided `minimumBid`.
- Activates the auction.
- Emits a `Log` event announcing the auction's start and the minimum bid.

---

### `bid()`
Allows participants to place a bid.

#### Requirements:
- The bid amount must exceed the current minimum bid.
- The auction must be in progress.

#### Actions:
- Refunds the current highest bidder.
- Updates `currentBidder` and `currentBid` to the new highest bid and bidder.
- Emits a `Log` event with the new highest bid.

---

### `closeAuction()`
Closes the auction and transfers the highest bid to the owner.

#### Requirements:
- Only the owner can call this function.
- The auction must be in progress.

#### Actions:
- Transfers `currentBid` to the owner.
- Deactivates the auction.
- Emits a `Log` event indicating the auction's closure.

---

### `refund()`
Handles the refund for the current highest bidder. This is a private function called during bidding.

---

## Deployment Instructions
1. Deploy the contract on a Solidity-compatible blockchain network.
2. The owner (deployer) can start the auction using `startAuction(uint minimumBid)`.
3. Participants can place bids using the `bid()` function.
4. The owner can close the auction with `closeAuction()`.

---

## Usage Notes
- Only the contract owner can start and close the auction.
- Participants must bid higher than the current `minBid`.
- Refunds for previous bids are automatically handled.

---

## License
This project is licensed under the MIT License. See the SPDX identifier in the source code.
