// SPDX-License-Identifier: UNLICENSED
// Patrick Finance - Hard Rug (Table 2.3, ID:1)
// Address: 0x4381Aeba9b22538BcaeE9B7cCD91D39d300eCaeA
contract PatrickFinance {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function deposit() external payable {}

    // VULNERABILITY: NO ACCESS CONTROL
    function withdraw() external {
        payable(msg.sender).transfer(address(this).balance);
    }
}