# Plutus Nexus: Bridging Wealth and Governance

Plutus Nexus is the connection point between stablecoins like USDT and decentralized governance. It brings the power of stablecoins to OpenGav, allowing users to participate in referenda without worrying about DOT price fluctuations.

Vote safely and confidently with stablecoins — all for just a small fee!

## There are two main user flows:
Voting:
Users lock their stablecoins (e.g., USDT) to cast a vote on the OpenGav referendum of their choice.

Claiming:
After the referendum ends, users can claim back their stablecoins along with any rewards (if applicable).

### VOTE
![vote](/imgs/vote.png)
### Select Referendum
The user chooses the ReferendaID they wish to vote on. He uses our UI that we build with PAPI that fetches list of active referendas.

### Approve Spending
The user sends an approve transaction to the USDT (ERC20) contract, allowing the Plutus Voter Contract to spend a specified amount of USDT.

### Cast Vote
The user submits a vote transaction to the Plutus Nexus Contract, specifying:
- The ReferendaID
- The amount of USDT to vote with

### Verification & Execution
**The contract:**
- Verifies that the selected referendum is currently active via the governance pallet
- Converts the USDT to DOT
- Casts the vote on-chain using the equivalent amount of DOT



### CLAIM
![vote](/imgs/claim.png)

### Referendum Finalized
Once the referendum has concluded and the voting period has ended, the Plutus Nexus contract reclaims the DOT that was used to vote.

### User Claims Funds
The user can then call the claim function to:
Retrieve their original USDT (minus a small service fee)


## Platform Fee
A small fee is deducted from the user's USDT claim to cover platform usage and transaction costs.


## FUTURE
This can be easly expandable in future to involve MarketMakers to provide their DOT liquidity in exhange of fee.