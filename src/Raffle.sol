/*
Order of Layout:
    1. Pragma statements
    2. Import statements
    3. Events
    4. Errors
    5. Interfaces
    6. Libraries
    7. Contracts:
        - Type declarations
        - State variables
        - Events
        - Errors
        - Modifiers
        - Functions:
            i.   constructor
            ii.  receive function (if exists)
            iii. fallback function (if exists)
            iv.  external
            v.   public
            vi.  internal
            vii. private
*/

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;



/**
 * @title Raffle contract
 * @author Umar Ndungo - umarndungo, thechiefumar
 * @notice This contract creates a sample raffle
 * @dev implements Chainlink VRF v2.5 
 */
contract Raffle {

    /** Errors */
    error Raffle__SendMoreToEnterRaffle();

    uint256 private immutable i_entranceFee;
    // @dev duration of lottery in seconds
    uint256 private immutable i_interval;
    uint256 private s_lastTimeStamp;
    address payable[] private s_players;

    /** Events */
    event RaffleEntered(address indexed player);

    constructor(uint256 entranceFee, uint256 interval){
        i_entranceFee = entranceFee;
        i_interval = interval;
        s_lastTimeStamp = block.timestamp;
    }

    function enterRaffle() external payable {
        //require(msg.value >= i_entranceFee, "Not enough ETH sent!");
        //require(msg.value >= i_entranceFee, Raffle__SendMoreToEnterRaffle());
        if (msg.value < i_entranceFee){
            revert Raffle__SendMoreToEnterRaffle();
        }
        s_players.push(payable(msg.sender));

        emit RaffleEntered(msg.sender);
    }

    // 1. Get's a random number
    // 2. Use a randoma number to pick a player
    // 3. Be automatically called
    function pickWinner() external {
        if (block.timestamp - s_lastTimeStamp < i_interval) {
            revert();
        }

    }

    /** Getter Functions */
    function getEntranceFee() external view returns(uint256){
        return i_entranceFee;
    }
}

