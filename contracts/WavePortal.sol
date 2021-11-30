// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    uint256 private seed;
    address[] walletAddresses;
    mapping(address => uint256) public walletWaves;
    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    event NewWave(address indexed from, uint256 timestamp, string message);
    Wave[] waves;

    mapping(address => uint256) public lastWavedAt;

    constructor() payable {
        console.log("Yo yo, I am a contract and I am smart");
        seed = (block.timestamp + block.difficulty) % 100;
    }
    function wave(string memory _message) public {
        require(
            lastWavedAt[msg.sender] + 15 minutes < block.timestamp,
            "Wait 15m"
        );
        lastWavedAt[msg.sender] = block.timestamp;
        
        walletWaves[msg.sender] += 1;
        walletAddresses.push(msg.sender);
        totalWaves += 1;
        console.log("%s has waved!", msg.sender);

        waves.push(Wave(msg.sender, _message, block.timestamp));
        seed = (block.difficulty + block.timestamp + seed) % 100;
        console.log("Seed: %d", seed);
        if(seed <= 50) {
            console.log("%s has been rewarded!", msg.sender);
            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more than you have"
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }
        emit NewWave(msg.sender, block.timestamp, _message);
    }
    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
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
