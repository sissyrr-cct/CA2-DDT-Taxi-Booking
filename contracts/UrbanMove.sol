// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

contract UrbanMove {
    address payable public driver;
    address public passenger;

    uint256 public constant FARE = 0.01 ether;

    enum BookingStatus {
        Available,
        Booked,
        JourneyCompleted,
        Paid
    }

     event TaxiBooked(address passenger, uint256 fare);

    BookingStatus public status;

    constructor() {
        driver = payable(msg.sender);
        status = BookingStatus.Available;
    }

     // passenger books and pays the fare
    function bookTaxi() public payable {
        require(
            status == BookingStatus.Available,
            "Taxi already booked"
        );

        require(
            msg.sender != driver,
            "Driver cannot book taxi"
        );

        require(
            msg.value == FARE,
            "Incorrect fare amount"
        );

        passenger = msg.sender;
        status = BookingStatus.Booked;

        emit TaxiBooked(passenger, msg.value);
    }
}
