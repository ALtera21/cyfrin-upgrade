// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {UpgradeBox} from "../script/UpgradeBox.s.sol";
import {DeployBox} from "../script/DeployBox.s.sol";
import {Test, console} from "forge-std/Test.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";

contract DeployAndUpgradeTest is Test {
    DeployBox deployer;
    UpgradeBox upgrader;
    address public OWNER = makeAddr("owner");

    address public proxy;

    function setUp() public {
        deployer = new DeployBox();
        upgrader = new UpgradeBox();
        proxy = deployer.run(); //? right now points to BoxV1;
    }

    /**
     * =======================================================================================================================
     * ?                                                     ABOUT
     * @notice         : foundry.toml exclude_lints = ["mixed-case-variable", "screaming-snake-case-immutable", "unsafe-typecast", "mixed-case-function", "unwrapped-modifier-logic", "asm-keccak256"]
     * @notice         : user input abi.encodeWithSignature() message into proxy address => proxy calls fallback() => fallback() calls delegatecall on the implementation (BoxV1) 
     *=======================================================================================================================*
     */

    function testUpgradeAndTestSetNumberNotExistYetBeforeUpgrade() public {
        BoxV2 box2 = new BoxV2();
        assertEq(1, BoxV2(proxy).getVersion());

        console.log(BoxV2(proxy).getVersion());
        console.log(BoxV1(proxy).getVersion());

        vm.expectRevert();
        BoxV2(proxy).setNumber(8);

        address stillOldProxy = upgrader.upgradeBox(proxy, address(box2));

        assertEq(proxy, stillOldProxy);

        uint256 expectedVersion = 2;
        assertEq(expectedVersion, BoxV2(stillOldProxy).getVersion());

        console.log(BoxV2(proxy).getVersion());
        console.log(BoxV1(proxy).getVersion());

        BoxV2(stillOldProxy).setNumber(8);
        assertEq(BoxV2(stillOldProxy).getNumber(), 8);
    }
}
