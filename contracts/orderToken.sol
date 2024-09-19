// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract OrderToken {
    using SafeERC20 for IERC20; 

    struct Order {
        address maker; 
        address tokenToBuy;
        address tokenToSell;
        uint256 amountToBuy;
        uint256 amountToSell;
        bool isActive;
    }

    Order[] public orders; 

    mapping(address => uint256[]) public userOrders; 

    event OrderCreated(uint256 indexed orderId, address indexed maker, address tokenToSell, uint256 amountToSell, address tokenToBuy, uint256 amountToBuy);
    event OrderFulfilled(uint256 indexed orderId, address indexed taker);
    event OrderCancelled(uint256 indexed orderId);

    function depositOrder(address _tokenToBuy, address _tokenToSell, uint256 _amountToBuy, uint256 _amountToSell) external {
        require(_tokenToSell != address(0) && _tokenToBuy != address(0), "Invalid token addresses");
        require(_amountToSell > 0 && _amountToBuy > 0, "Invalid amounts");

        IERC20(_tokenToSell).safeTransferFrom(msg.sender, address(this), _amountToSell);

        Order memory newOrder = Order({
            maker: msg.sender,
            tokenToSell: _tokenToSell,
            amountToSell: _amountToSell,
            tokenToBuy: _tokenToBuy,
            amountToBuy: _amountToBuy, 
            isActive: true
        });
        orders.push(newOrder);
        uint256 orderId = orders.length - 1;
        userOrders[msg.sender].push(orderId);

        emit OrderCreated(orderId, msg.sender, _tokenToSell, _amountToSell, _tokenToBuy, _amountToBuy);
    }

    function confirmOrder(uint256 _orderId) external {
        require(_orderId < orders.length, "Invalid Order Id");
        Order storage order = orders[_orderId];
        require(order.isActive, "Order is not active");

        IERC20(order.tokenToBuy).safeTransferFrom(msg.sender, order.maker, order.amountToBuy);
        IERC20(order.tokenToSell).safeTransfer(msg.sender, order.amountToSell);

        order.isActive = false;

        emit OrderFulfilled(_orderId, msg.sender);
    }

    function cancelOrder(uint256 _orderId) external { 
        require(_orderId < orders.length, "Invalid order ID");
        Order storage order = orders[_orderId];
        require(order.maker == msg.sender, "Not the order maker");
        require(order.isActive, "Order is not active");

        IERC20(order.tokenToSell).safeTransfer(msg.sender, order.amountToSell);
        order.isActive = false;

        emit OrderCancelled(_orderId);
    }

    function getOrdersCount() external view returns (uint256) {
        return orders.length;
    }
}