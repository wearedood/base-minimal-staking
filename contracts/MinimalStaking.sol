contracts/MinimalStaking.sol// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title MinimalStaking - Simple ETH Staking for Base Network
 * @author ddtrvlr.base
 */
contract MinimalStaking {
    
    mapping(address => uint256) public stakes;
    mapping(address => uint256) public stakeTime;
    
    address public owner;
    uint256 public totalStaked;
    
    event Staked(address indexed user, uint256 amount);
    event Unstaked(address indexed user, uint256 amount);
    
    constructor() {
        owner = msg.sender;
    }
    
    function stake() external payable {
        require(msg.value > 0, "Must stake more than 0");
        stakes[msg.sender] += msg.value;
        stakeTime[msg.sender] = block.timestamp;
        totalStaked += msg.value;
        emit Staked(msg.sender, msg.value);
    }
    
    function unstake() external {
        require(stakes[msg.sender] > 0, "No stake found");
        uint256 amount = stakes[msg.sender];
        stakes[msg.sender] = 0;
        stakeTime[msg.sender] = 0;
        totalStaked -= amount;
        payable(msg.sender).transfer(amount);
        emit Unstaked(msg.sender, amount);
    }
    
    function getStake(address user) external view returns (uint256) {
        return stakes[user];
    }
    
    receive() external payable {}
}
