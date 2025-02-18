// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "lib/forge-std/src/Test.sol";
import "../src/AsheERC20Token.sol"; // Adjust the path to your contract

contract AsheERC20TokenTest is Test {
    AsheERC20Token private token;
    address private owner = address(0x123);
    address private user1 = address(0x456);
    address private user2 = address(0x789);

    function setUp() public {
        // Deploy the token contract with an initial supply of 1000 tokens
        vm.prank(owner);
        token = new AsheERC20Token(1000 ether); // 1000 tokens with 18 decimals
    }

    // Test initial supply and owner balance
    function testInitialSupply() public view {
        assertEq(token.totalSupply(), 1000 ether);
        assertEq(token.balanceOf(owner), 1000 ether);
    }

    // Test token transfer
    function testTransfer() public {
        vm.prank(owner);
        token.transfer(user1, 100 ether);

        assertEq(token.balanceOf(owner), 900 ether);
        assertEq(token.balanceOf(user1), 100 ether);
    }

    // Test token transferFrom with approval
    function testTransferFrom() public {
        vm.prank(owner);
        token.approve(user1, 100 ether);

        vm.prank(user1);
        token.transferFrom(owner, user2, 100 ether);

        assertEq(token.balanceOf(owner), 900 ether);
        assertEq(token.balanceOf(user2), 100 ether);
        assertEq(token.allowance(owner, user1), 0);
    }

    // Test minting new tokens
    function testMint() public {
        vm.prank(owner);
        token.mint(user1, 200 ether);

        assertEq(token.balanceOf(user1), 200 ether);
        assertEq(token.totalSupply(), 1200 ether);
    }

    // Test burning tokens
    function testBurn() public {
        vm.prank(owner);
        token.burn(owner, 100 ether);

        assertEq(token.balanceOf(owner), 900 ether);
        assertEq(token.totalSupply(), 900 ether);
    }

    // Test transfer with insufficient balance
    function testTransferInsufficientBalance() public {
        vm.prank(owner);
        vm.expectRevert("ERC20: transfer amount exceeds balance");
        token.transfer(user1, 2000 ether);
    }

    // Test transferFrom with insufficient allowance
    function testTransferFromInsufficientAllowance() public {
        vm.prank(owner);
        token.approve(user1, 50 ether);

        vm.prank(user1);
        vm.expectRevert("ERC20: transfer amount exceeds allowance");
        token.transferFrom(owner, user2, 100 ether);
    }
}
