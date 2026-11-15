// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

contract UrbanMove {
    address payable public driver;
    address public passenger;

    // Test fare only
    uint256 public constant FARE = 0.01 ether;

    enum BookingStatus {
        Available,
        Booked,
        JourneyCompleted,
        Paid
    }

    BookingStatus public status;

    constructor() {
        driver = payable(msg.sender);
        status = BookingStatus.Available;
    }
}
