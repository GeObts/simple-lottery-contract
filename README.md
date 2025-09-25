# simple-lottery-contract
Simple lottery contract
# Simple Lottery Smart Contract

A decentralized lottery contract built with Solidity that allows users to participate in a transparent and fair lottery system.

## 🎯 Features

- **Entry Fee System**: Configurable minimum entry fee set during deployment
- **Fair Winner Selection**: Pseudo-random winner selection using blockchain data
- **Duplicate Prevention**: Each address can only enter once per lottery round
- **Owner Protections**: Contract owner cannot participate but receives 10% fee
- **Event Logging**: All major actions emit events for tracking
- **Lottery Reset**: Owner can start new lottery rounds

## 📋 Contract Details

- **Contract Name**: SimpleLottery
- **Solidity Version**: ^0.8.0
- **License**: MIT

## 🚀 Deployment

### Constructor Parameters
- `_entryFeeInWei`: Entry fee amount in Wei (e.g., `10000000000000000` for 0.01 ETH)

### Example Deployment Values
- 0.001 ETH: `1000000000000000`
- 0.01 ETH: `10000000000000000`
- 0.1 ETH: `100000000000000000`

## 🎮 How to Use

### For Players
1. Call `enter()` function with at least the minimum entry fee
2. Wait for owner to call `pickWinner()`
3. Winner receives 90% of total prize pool

### For Owner
1. Deploy contract with desired entry fee
2. Wait for players to enter
3. Call `pickWinner()` to select winner and distribute prizes
4. Optionally call `resetLottery()` to start a new round

## 📊 View Functions

- `getPlayers()`: Returns array of all player addresses
- `getPlayerCount()`: Returns number of current players
- `getContractBalance()`: Returns current contract balance
- `isPlayerEntered(address)`: Check if specific address has entered

## ⚠️ Important Notes

- This uses pseudo-random number generation (not truly random)
- Owner receives 10% fee from total prize pool
- Contract owner cannot participate as a player
- For production use, consider using Chainlink VRF for true randomness

## 📜 Contract Address

**[Add your deployed contract address here]**
- Network: [Add network name]
- Block Explorer: [Add block explorer link]

## 🛠️ Built With

- Solidity ^0.8.0
- Remix IDE
- [Add network used]

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Developer

Created as part of smart contract development practice.

---

*Note: This is for educational/demonstration purposes. Always audit smart contracts before using with real funds.*
