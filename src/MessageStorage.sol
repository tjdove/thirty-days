// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract MessageStorage {
    // Variable to store the message
    string private message;

    // Event to log when the message is updated
    event MessageUpdated(string newMessage);

    // Function to store a new message
    function setMessage(string memory _message) public {
        message = _message;
        emit MessageUpdated(_message); // Emit an event when the message is updated
    }

    // Function to retrieve the stored message
    function getMessage() public view returns (string memory) {
        return message;
    }
}
