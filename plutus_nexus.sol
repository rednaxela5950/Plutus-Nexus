// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract OpenGovVotingNativeDOT {
    IERC20 public usdt;
    address public owner;
    uint256 public usdtToDotRate; // Scaled by 1e18 (DOT per 1 USDT)
    uint256 public commissionPercent; // basis points (1% = 100)

    struct VoteInfo {
        address voter;
        uint256 usdtDeposited;
        uint256 dotEquivalent;
        bool claimed;
    }

    mapping(uint256 => mapping(address => VoteInfo)) public votes; // referendumId => voter => VoteInfo
    mapping(uint256 => bool) public referendumStatus; // true = passed, false = failed
    uint256 public collectedFees; // in USDT

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }

    constructor(address _usdt, uint256 _initialRate, uint256 _commissionPercent) {
        require(_initialRate > 0, "Rate cannot be zero");
        require(_commissionPercent <= 1000, "Max commission is 10%");
        owner = msg.sender;
        usdt = IERC20(_usdt);
        usdtToDotRate = _initialRate;
        commissionPercent = _commissionPercent;
    }

    // Owner updates exchange rate
    function updateExchangeRate(uint256 _newRate) external onlyOwner {
        require(_newRate > 0, "Rate must be positive");
        usdtToDotRate = _newRate;
    }

    // Owner updates commission percent
    function updateCommission(uint256 _newCommissionPercent) external onlyOwner {
        require(_newCommissionPercent <= 1000, "Max commission is 10%");
        commissionPercent = _newCommissionPercent;
    }

    // User deposits USDT, contract votes using native DOT balance
    function depositAndVote(uint256 _referendumId, uint256 _usdtAmount) external returns (bool) {
        require(_usdtAmount > 0, "Deposit must be > 0");
        require(votes[_referendumId][msg.sender].usdtDeposited == 0, "Already voted");

        // Transfer USDT from user to contract
        require(usdt.transferFrom(msg.sender, address(this), _usdtAmount), "USDT transfer failed");

        // Calculate equivalent DOT amount based on rate
        uint256 dotAmount = (_usdtAmount * usdtToDotRate) / 1e18;

        // Ensure contract has sufficient native DOT balance
        require(address(this).balance >= dotAmount, "Insufficient DOT in contract");

        // Calculate the commission fee
        uint256 fee = (vote.usdtAmount * commissionPercent) / 10000;
        uint256 refundAmount = vote.usdtDeposited - fee;

        // Record vote details
        votes[_referendumId][msg.sender] = VoteInfo({
            voter: msg.sender,
            usdtDeposited: _usdtAmount - fee,
            dotEquivalent: dotAmount,
            claimed: false
        });

        bool active = referendumActive(referendumID).
        require(active, "Referendum is not active");
        

        // Simulate voting on OpenGov (would require off-chain integration in reality)
        bool voteSuccess = voteOnOpenGov(_referendumId, dotAmount);

        // Make the fee available for collection by the owner
        collectedFees += fee;

        return voteSuccess;
    }

    // Simulated voting function (abstracted)
    function voteOnOpenGov(uint256 _referendumId, uint256 _dotAmount) internal returns (bool) {
        // In reality, this function should integrate with off-chain services or bridges.
        // For this mock, we assume voting always succeeds.
        return true;
    }

    // Owner sets final status of a referendum (from off-chain results)
    function setreferendumResult(uint256 _referendumId, bool _passed) external onlyOwner {
        referendumStatus[_referendumId] = _passed;
    }

    // User claims their USDT back minus fees after referendum finalizes
    function claim(uint256 _referendumId) external {
        VoteInfo storage vote = votes[_referendumId][msg.sender];
        require(vote.usdtDeposited > 0, "No vote found");
        require(!vote.claimed, "Already claimed");
        require(referendumStatus[_referendumId] == true || referendumStatus[_referendumId] == false, "referendum pending");

        vote.claimed = true;

        require(usdt.transfer(msg.sender, refundAmount), "USDT refund failed");
    }

    // Owner claims collected fees in USDT
    function claimFees(address _to) external onlyOwner {
        require(collectedFees > 0, "No fees available");
        uint256 fees = collectedFees;
        collectedFees = 0;
        require(usdt.transfer(_to, fees), "USDT fee transfer failed");
    }

    // Owner can withdraw native DOT from contract if needed
    function withdrawDOT(address payable _to, uint256 _amount) external onlyOwner {
        require(address(this).balance >= _amount, "Insufficient DOT balance");
        _to.transfer(_amount);
    }

    // Allow contract to receive DOT tokens
    receive() external payable {}
}