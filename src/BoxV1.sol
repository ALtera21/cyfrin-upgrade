// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/**=======================================================================================================================
 * ?                                                     ABOUT
 * @author         : Altera21
 * @title          : BoxV1
 * @notice         : foundry.toml exclude_lints = ["mixed-case-variable", "screaming-snake-case-immutable", "unsafe-typecast", "mixed-case-function", "unwrapped-modifier-logic", "asm-keccak256"]
 *=======================================================================================================================**/

contract BoxV1 is Initializable, UUPSUpgradeable, OwnableUpgradeable {

    /**
     * =======================================================================================================================
     *                                                    STATE VARIABLES
     *=======================================================================================================================*
     */

    uint256 internal number;

    /**
     * =======================================================================================================================
     *                                                    FUNCTIONS
     *=======================================================================================================================*
     */

    //? we could just not include these constructor don't do initialize anything. but this way is more robust

    //? The below comment is used for linters that disallow or gave a warning that we shouldn't have a constructor in upgradeable contracts
    // @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers(); //? <== meaning : Don't let initialization happened
    }

    /**
     * =======================================================================================================================
     *                                                    PUBLIC
     *=======================================================================================================================*
     */

    // https://docs.openzeppelin.com/upgrades-plugins/writing-upgradeable#initializers
    function initialize() public initializer {
        __Ownable_init(); //? <== sets the owner to msg.sender // prepended with double underscore means that this is a initializer function
        __UUPSUpgradeable_init(); //? <== sometimes we see these function which doesn't do anything but it is best practice to have this in here, to say hey this is UUPSUpgradeable contract
    }

    /**
     * =======================================================================================================================
     *                                                    INTERNAL
     *=======================================================================================================================*
     */

    function _authorizeUpgrade(address newImplementation) internal override { //? we can add onlyOwner modifier s only the owner can upgrade the contract
        // if(msg.sender != owner) revert();
    }

    /**
     * =======================================================================================================================
     *                                                    EXTERNAL AND/OR PUBLIC GETTERS
     *=======================================================================================================================*
     */
    
    function getNumber() external view returns(uint256) {
        return number;
    }

    function getVersion() external pure returns(uint256) {
        return 1;
    }
}
