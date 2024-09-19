// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";


contract orderToken {
struct Order{
    address makers;
    address tokenToBuy;
    address tokenToSell;
    uint256 amountToBuy;
    uint256 amountToSell;
    bool isActive;

}

}
Order[] public orders;

mapping(address =>uint256[]) userOrders;

event OrderCreated(uint256 indexed orderId, address indexed maker, address tokenToSell, uint256 amountToSell, address tokenToBuy, uint256 amountToBuy);
    event OrderFulfilled(uint256 indexed orderId, address indexed taker);
    event OrderCancelled(uint256 indexed orderId);

function depositOrder(address _tokenToBuy, address tokenToSell, uint256 amountToBuy, uint256 amountToSell) external{

    Order memory newOrder = Order({
        maker: msg.sender,
        tokenToSell: _tokenToSell,
        amountToSell: _amountToSell
        tokenToBuy: _tokenToBuy;
        amountToSell: _amountToSell;
        isActive: true
    
    });
    orders.push(newOrder);
        uint256 orderId = orders.length - 1;
        userOrders[msg.sender].push(orderId);

        emit OrderCreated(orderId, msg.sender, _tokenToSell, _amountToSell, _tokenToBuy, _amountToBuy);

        function confirmOrder(uint256 _orderId) external{
        require(_orderId < order.length, "Invalid Order Id");
         Order storage order = orders[_orderId];
         require(order.isActive, "Order is not active");

        }

        function cancelOrder() external{

        }

        function getOrderCount() external{

        }

        function getUserOrderCount() external{

        }

         
}