// SPDX-License-Identifier: MIT
// STRATOS CHAIN - PROOF-OF-TRAFFIC (PoT) REWARD CONTRACT
// COMMIT: 78e7317d24d69ad57b8f22f508e43446c25b1e30
// AUDIT: BlockSec - 12 HIGH-risk findings
// AUDIT ID: STRATOS-2024-001
pragma solidity ^0.8.0;

contract StratosPoTReward {
    mapping(address => uint256) public rewards;
    address public owner;
    uint256 public totalMinted;

    event RewardAdded(address indexed user, uint256 amount);
    event RewardWithdrawn(address indexed user, uint256 amount);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor() {
        owner = msg.sender;
        emit OwnershipTransferred(address(0), owner);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    // VULNERABILITY 1: No access control on addReward - anyone can mint
    function addReward(address user, uint256 amount) external {
        rewards[user] += amount;
        totalMinted += amount;
        emit RewardAdded(user, amount);
    }

    // VULNERABILITY 2: No supply cap on withdrawReward
    function withdrawReward(uint256 amount) external {
        require(rewards[msg.sender] >= amount, "Insufficient rewards");
        rewards[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit RewardWithdrawn(msg.sender, amount);
    }

    // VULNERABILITY 3: No zero-address check
    function setOwner(address _newOwner) external {
        owner = _newOwner;
        emit OwnershipTransferred(msg.sender, _newOwner);
    }

    function getReward(address user) external view returns (uint256) {
        return rewards[user];
    }
}