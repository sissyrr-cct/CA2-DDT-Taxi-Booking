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
     event JourneyCompleted(address driver, address passenger);

    BookingStatus public status;

    constructor() {
        driver = payable(msg.sender);
        status = BookingStatus.Available;
    }

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

    function completeJourney() public {
        require(
            msg.sender == driver,
            "Driver only"
        );

        require(
            status == BookingStatus.Booked,
            "Journey is not booked"
        );

        status = BookingStatus.JourneyCompleted;

        emit JourneyCompleted(driver, passenger);
    }

}
