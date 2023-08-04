//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "./TroopHelper.sol";

contract TroopAttack is TroopHelper {
    function attack(Troop storage _troop) internal {
        require(_isReady(_troop));
        //require(troopToOwner[id] = msg.sender);

        _triggerCooldown(_troop);
    }//attack

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
    
}//TroopAttack