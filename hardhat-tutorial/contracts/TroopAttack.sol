//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "./TroopFactory.sol";

contract TroopAttack is TroopFactory {

    function _triggerCooldown (Troop storage _troop) internal {
        _troop.readyTime = uint32(block.timestamp + cooldownTime);
    }//_triggerCooldown

    function _isReady (Troop storage _troop) internal view returns(bool) {
        return _troop.readyTime <= block.timestamp;
    }//_isReady

    function attack(Troop storage _troop) internal {
        require(_isReady(_troop));
        //require(troopToOwner[id] = msg.sender);

        _triggerCooldown(_troop);
    }//attack
}//TroopFactory