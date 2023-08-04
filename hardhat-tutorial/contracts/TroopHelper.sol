//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "./TroopAttack.sol";

contract TroopHelper is TroopAttack{

    modifier canLevelUp(uint _troopId) {
        require(troops[_troopId].isLevelable == true);
        require(troops[_troopId].troopLevel >= 1);

        Troop storage troop = troops[_troopId];
        _;
    }//aboveLevel

    //function increaseStats(uint _troopId) external canLevelUp(_troopId) {
    //    troops[_troopId].troopStrength++;
    //    troops[_troopId].troopHealth++;
    //    troops[_troopId].troopLevel++;
    //    troops[_troopId].isLevelable = false;
    //}//increaseStrength

    function getTroopsByOwner (address _owner) external view returns (uint[] memory)  {
        uint[] memory result = troopCount[_owner];

        uint counter = 0;
        for (uint i = 1; i < troops.length; i++) {
            if (troopToOwner[i] == _owner) {
                result[counter] = i;
            }//if
        }//For

        return result;
    }//getTroopsByOwner

}//TroopHelper