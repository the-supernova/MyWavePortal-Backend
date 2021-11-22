// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    address[] walletAddresses;
    mapping(address => uint256) public walletWaves;
    constructor() {
        console.log("Yo yo, I am a contract and I am smart");
    }
    function wave() public {
        walletWaves[msg.sender] += 1;
        walletAddresses.push(msg.sender);
        totalWaves += 1;
        console.log("%s has waved!", msg.sender);
    }
    function getTotalWaves() public view returns (uint256) {
        console.log("Total waves: %s", totalWaves);
        console.log("Total wallets: %s", walletAddresses.length);
        return totalWaves;
    }
}
