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
    function getMaxWaves() public view returns (address, uint256) {
        address maxWallet = walletAddresses[0];
        uint256 maxWaves = walletWaves[maxWallet];
        for (uint256 i = 1; i < walletAddresses.length; i++) {
            if (walletWaves[walletAddresses[i]] > maxWaves) {
                maxWallet = walletAddresses[i];
                maxWaves = walletWaves[maxWallet];
            }
        }
        console.log("%s has waved the most! (%s times)", maxWallet, maxWaves);
        return (maxWallet, maxWaves);
    }
    function getTotalWaves() public view returns (uint256) {
        console.log("Total waves: %s", totalWaves);
        console.log("Total wallets: %s", walletAddresses.length);
        return totalWaves;
    }
}
