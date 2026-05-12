// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
// import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/**=======================================================================================================================
 * ?                                                     ABOUT
 * @author         : Altera21
 * @title          : BoxV2
 * @notice         : foundry.toml exclude_lints = ["mixed-case-variable", "screaming-snake-case-immutable", "unsafe-typecast", "mixed-case-function", "unwrapped-modifier-logic", "asm-keccak256"]
 *=======================================================================================================================**/

contract BoxV2 is /* Initializable, OwnableUpgradeable, */ UUPSUpgradeable{
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

    // @custom:oz-upgrades-unsafe-allow constructor
    // constructor() {
    //     _disableInitializers();
    // }

    /**
     * =======================================================================================================================
     *                                                    EXTERNAL
     *=======================================================================================================================*
     */

    function setNumber(uint256 _newNumber) external {
        number = _newNumber;
    }

    /**
     * =======================================================================================================================
     *                                                    PUBLIC
     *=======================================================================================================================*
     */

    // // https://docs.openzeppelin.com/upgrades-plugins/writing-upgradeable#initializers
    // function initialize() public initializer {
    //     __Ownable_init();
    //     __UUPSUpgradeable_init();
    // }

    /**
     * =======================================================================================================================
     *                                                    INTERNAL
     *=======================================================================================================================*
     */

    function _authorizeUpgrade(address newImplementation) internal override {}

    /**
     * =======================================================================================================================
     *                                                    EXTERNAL AND/OR PUBLIC GETTERS
     *=======================================================================================================================*
     */
    
    function getNumber() external view returns(uint256) {
        return number;
    }

    function getVersion() external pure returns(uint256) {
        return 2;
    }
}
