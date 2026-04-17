// SPDX-License-Identifier: UNLICENSED
// Evo - Honeypot (Table 2.3, ID:3)
// Address: 0x887F...7778
contract EvoHoneypot {
    string public name = "Evo";
    string public symbol = "EVO";
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function transfer(address to, uint256 amount) external returns (bool) {
        return true;
    }

    // HONEYPOT: Only owner can sell
    function transferFrom(address from, address to, uint256 amount) external view returns (bool) {
        require(msg.sender == owner, "Honeypot: cannot sell");
        return true;
    }
}