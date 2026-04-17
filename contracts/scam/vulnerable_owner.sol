// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VulnerableOwner {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function setOwner(address _newOwner) public {
        owner = _newOwner;
    }

    function withdraw() public {
        payable(msg.sender).transfer(address(this).balance);
    }
}