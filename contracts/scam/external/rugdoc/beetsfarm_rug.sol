// SPDX-License-Identifier: UNLICENSED
// Beetsfarm Finance - Admin Withdraw (Table 2.3, ID:2)
// Address: 0x369CaBe555716a3349d537DE71b3720D41aC1a1A
contract BeetsfarmRug {
    address public admin;

    constructor() {
        admin = msg.sender;
    }

    // VULNERABILITY: Funds go to admin wallet, not users
    function emergencyWithdraw() external {
        payable(admin).transfer(address(this).balance);
    }
}