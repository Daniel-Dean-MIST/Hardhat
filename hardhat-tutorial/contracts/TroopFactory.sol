//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "./Ownable.sol";
//import "@chainlink/contracts/src/v0.8/interfaces/VRFConsumerBaseV2.sol";

contract TroopFactory is Ownable{
    
    event newTroop(uint _troopLevel, string _troopName, uint _troopHealth, uint _troopStrength, bool);
    
    string troopName;
    uint troopLevel;
    uint troopHealth;
    uint troopStrength;
    uint cooldownTime = 1 days;
    bool isLevelable;

    struct Troop {
        string troopType;
        uint troopHealth;
        uint troopStrength;
        uint32 troopLevel;
        uint32 readyTime;
        bool isLevelable; //if our zombie is eligible to be leveled
    }//Troop

    Troop[] public troops;

    mapping (uint => address) public troopToOwner;

    mapping (address => uint) troopCount;

    function _createTroop(string memory _troopType, uint _troopHealth, uint _troopStrength, uint32 _troopLevel, bool _isLevelable) private {
        
        //uint id = troops.length();

        troops.push(Troop(_troopType, _troopHealth, _troopStrength, _troopLevel, uint32(block.timestamp + cooldownTime), _isLevelable));
        
        uint id = troops.length - 1; 

        troopToOwner[id] = msg.sender;
        troopCount[msg.sender]++; 
    }//createTroop

    function _generateRngHit(Troop memory t) private view returns(uint) {

       uint256 timestamp = block.timestamp;
       uint256 difficulty = block.prevrandao;
       uint256 random = uint256(keccak256(abi.encodePacked(timestamp, difficulty, msg.sender)));
       
       console.log(
        "Random Number Genrated: ",
        random % 100 * t.troopStrength
        );

       return random % 100 * t.troopStrength;
    }//genrateRngHit

    function createInitialTroop() public {
        require(troopCount[msg.sender] == 0);
        _createTroop('Swordsman', 10, 10, 1, true);
    }//createInitialTroop

}//TroopFactory