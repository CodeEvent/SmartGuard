// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TestMint {
    address public owner;
    uint256 public totalSupply;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function mint(address, uint256 amount) external onlyOwner {
        totalSupply += amount; // No supply cap check - vulnerable
    }
}