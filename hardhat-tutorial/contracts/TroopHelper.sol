//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "./TroopAttack.sol";

contract TroopHelper is TroopAttack{

    uint levelUpFee = 0.001 ether;

    modifier canLevelUp(uint _troopId) {
        require(troops[_troopId].isLevelable == true);
        require(troops[_troopId].troopLevel >= 1);

        Troop storage troop = troops[_troopId];
        _;
    }//aboveLevel

    function withdraw() external onlyOwner {
        address payable _owner = payable(owner());
        _owner.transfer(address(this).balance);
    }//withdraw

    function levelUp(uint _troopId) external payable {
        require(msg.value == levelUpFee);
        troops[_troopId].troopLevel++;
    }//levelUp

    function setLevelUpFee(uint _fee) external onlyOwner {
        levelUpFee = _fee;
    }//setLevelUpFee

    //function increaseStats(uint _troopId) external canLevelUp(_troopId) {
    //    troops[_troopId].troopStrength++;
    //    troops[_troopId].troopHealth++;
    //    troops[_troopId].troopLevel++;
    //    troops[_troopId].isLevelable = false;
    //}//increaseStrength

    function getTroopsByOwner (address _owner) external view returns (uint[] memory)  {
        uint[] memory result = new uint[](troopCount[_owner]);

        uint counter = 0;
        for (uint i = 1; i < troops.length; i++) {
            if (troopToOwner[i] == _owner) {
                result[counter] = i;
            }//if
        }//For

        return result;
    }//getTroopsByOwner

}//TroopHelper