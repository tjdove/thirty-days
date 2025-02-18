// Token Contract (ERC-20) - Feb 6
//     - Create an ERC-20 token with basic functions like
//     `transfer`,`balanceOf`, and `approve`.

// SPDX-License-Identifier: MIT
import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

pragma solidity >=0.8.28;

// pragma solidity ^0.8.0;
contract AsheERC20Token is ERC20 {
    constructor(uint256 initialSupply) ERC20("AsheToken", "ASC") {
        _mint(msg.sender, initialSupply);
    }

    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }

    function burn(address account, uint256 amount) external {
        _burn(account, amount);
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        _transfer(sender, recipient, amount);
        uint256 currentAllowance = allowance(sender, _msgSender());
        require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");
        _approve(sender, _msgSender(), currentAllowance - amount);
        return true;
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }
}
