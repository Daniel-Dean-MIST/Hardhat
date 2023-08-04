//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "./TroopFactory.sol";

contract TroopCD is TroopFactory {

    function _triggerCooldown (Troop storage _troop) internal {
        _troop.readyTime = uint32(block.timestamp + cooldownTime);
    }//_triggerCooldown

    function _isReady (Troop storage _troop) internal view returns(bool) {
        return _troop.readyTime <= block.timestamp;
    }//_isReady

}//TroopFactory