# OrderToken Smart Contract

## Overview

The OrderToken smart contract is a decentralized exchange (DEX) implementation that allows users to create, fulfill, and cancel token exchange orders on the Ethereum blockchain. This contract facilitates peer-to-peer token swaps without the need for a centralized authority.

## Features

- Create token exchange orders
- Fulfill existing orders
- Cancel your own orders
- View total number of orders

## Contract Details

- **License**: MIT
- **Solidity Version**: ^0.8.24
- **Dependencies**: OpenZeppelin Contracts (IERC20, SafeERC20)

## Main Functions

### `depositOrder`

Creates a new token exchange order.

Parameters:
- `_tokenToBuy`: Address of the token to buy
- `_tokenToSell`: Address of the token to sell
- `_amountToBuy`: Amount of tokens to buy
- `_amountToSell`: Amount of tokens to sell

### `confirmOrder`

Fulfills an existing order.

Parameters:
- `_orderId`: ID of the order to fulfill

### `cancelOrder`

Cancels an existing order (only callable by the order creator).

Parameters:
- `_orderId`: ID of the order to cancel

### `getOrdersCount`

Returns the total number of orders created.

## Events

- `OrderCreated`: Emitted when a new order is created
- `OrderFulfilled`: Emitted when an order is fulfilled
- `OrderCancelled`: Emitted when an order is cancelled

## Usage

1. Deploy the contract to Lisk-sepolia network.
2. To create an order, call `depositOrder` with the required parameters.
3. To fulfill an order, call `confirmOrder` with the order ID.
4. To cancel your order, call `cancelOrder` with the order ID.

## Security Considerations

- This contract uses OpenZeppelin's SafeERC20 to prevent common ERC20 token vulnerabilities.
- Ensure that you approve the contract to spend your tokens before creating or fulfilling orders.
- Always verify the order details before confirming or canceling an order.

## Development and Testing

To set up the development environment:

1. Install Node.js and npm.
2. Install Hardhat as your Ethereum development framework.
3. Install the required dependencies:
   ```
   npm install @openzeppelin/contracts
   ```
4. Compile the contract:
   ```
   npx hardhat compile
   ```
  
5. Deploy to a local blockchain or testnet for testing.

## Disclaimer

This smart contract is provided as-is. It has not been audited and may contain vulnerabilities. Use at your own risk. It is recommended to thoroughly test and potentially have the contract audited before deploying it on the mainnet.

## Contributing

Contributions, issues, and feature requests are welcome. Feel free to check issues page if you want to contribute.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.