# Plutus nexus
Is the connection point (nexus) betwenn wealth (USDT, stable coin) and governance.
Plutus nexus makes brings stablecoins to OpenGav!
Plutus nexus is a safe way for user to vote for OpenGav referenda of his choice without risking DOT price fluctuation. 
*This will cost just a small fee though!*

## User Flow
There are two main user flows. First is when user want to vote and second is when user wants to claim back his tokens.

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