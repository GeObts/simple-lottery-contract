// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleLottery {
    address[] public players;
    address public winner;
    address public owner;
    bool public isActive;
    uint256 public entryFee;
    uint256 public totalPrize;
    
    event PlayerEntered(address player, uint256 totalPlayers);
    event WinnerPicked(address winner, uint256 prizeAmount);
    event LotteryReset();
    
    constructor(uint256 _entryFeeInWei) {
        owner = msg.sender;
        isActive = true;
        entryFee = _entryFeeInWei; // Entry fee in wei (e.g., 10000000000000000 = 0.01 ETH)
    }
    
    function enter() public payable {
        require(isActive, "Lottery has ended");
        require(msg.value >= entryFee, "Insufficient entry fee");
        require(msg.sender != owner, "Owner cannot participate");
        
        // Check if player already entered
        for (uint i = 0; i < players.length; i++) {
            require(players[i] != msg.sender, "Player already entered");
        }
        
        players.push(msg.sender);
        totalPrize += msg.value;
        
        emit PlayerEntered(msg.sender, players.length);
    }
    
    function pickWinner() public {
        require(msg.sender == owner, "Only owner can pick winner");
        require(players.length > 0, "No players in lottery");
        require(isActive, "Lottery already ended");
        
        // Generate pseudo-random number
        uint256 randomIndex = uint256(
            keccak256(
                abi.encodePacked(
                    block.timestamp,
                    block.difficulty,
                    players.length,
                    msg.sender
                )
            )
        ) % players.length;
        
        winner = players[randomIndex];
        isActive = false;
        
        // Transfer prize to winner (90% to winner, 10% to owner as fee)
        uint256 winnerPrize = (totalPrize * 90) / 100;
        uint256 ownerFee = totalPrize - winnerPrize;
        
        payable(winner).transfer(winnerPrize);
        payable(owner).transfer(ownerFee);
        
        emit WinnerPicked(winner, winnerPrize);
    }
    
    function resetLottery(uint256 _newEntryFee) public {
        require(msg.sender == owner, "Only owner can reset");
        require(!isActive, "Current lottery must end first");
        
        delete players;
        winner = address(0);
        isActive = true;
        entryFee = _newEntryFee;
        totalPrize = 0;
        
        emit LotteryReset();
    }
    
    // View functions
    function getPlayers() public view returns (address[] memory) {
        return players;
    }
    
    function getPlayerCount() public view returns (uint256) {
        return players.length;
    }
    
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
    
    function isPlayerEntered(address player) public view returns (bool) {
        for (uint i = 0; i < players.length; i++) {
            if (players[i] == player) {
                return true;
            }
        }
        return false;
    }
}
