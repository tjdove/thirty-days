// SPDX-License-Identifier: MIT
pragma solidity >=0.6.2 <0.9.0;

import "lib/forge-std/src/Test.sol";
import "../src/MessageStorage.sol";

contract MessageStorageTest is Test {
    MessageStorage messageStorage;

    function setUp() public {
        messageStorage = new MessageStorage();
    }

    function testSetMessage() public {
        string memory testMessage = "Hello, World!";
        messageStorage.setMessage(testMessage);
        assertEq(messageStorage.getMessage(), testMessage);
    }

    function testGetMessage() public view {
        string memory defaultMessage = "";
        assertEq(messageStorage.getMessage(), defaultMessage);
    }
}
