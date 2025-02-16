// Token Contract (ERC-20) - Feb 6
//     - Create an ERC-20 token with basic functions like
//     `transfer`,`balanceOf`, and `approve`.
// SPDX-License-Identifier: UNLICENSED
import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

pragma solidity >=0.8.28;

// pragma solidity ^0.8.0;
contract AsheERC20Token is ERC20 {
    constructor(uint256 initialSupply) ERC20("AsheToken", "ASC") {
        _mint(msg.sender, initialSupply);
    }

    // function balanceOf(address account) public override returns (uint256)  {

    // }
}
