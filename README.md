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

- User wants to vote on referendaID
- User send Approve transaction to ERC20 contract to allow Voter to spend this amount
- User sends Vote transaction to our contract with *ReferendaID* and *amount* of USDT he wants to vote
- Contract checks using *governance pallet* for referenda to be active, and if so converts USDT to DOT and votes with corresponding amount of DOT


### CLAIM

- When referenda passed user is able to claim his USDT back, as well as contract receives hist DOTs back.
- We are claiming small fee for usage of our platform

![vote](/imgs/claim.png)



## FUTURE
This can be easly expandable in future to involve MarketMakers to provide their DOT liquidity in exhange of fee.