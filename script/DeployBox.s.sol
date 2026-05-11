// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

/**=======================================================================================================================
 * ?                                                     ABOUT
 * @notice         : foundry.toml exclude_lints = ["mixed-case-variable", "screaming-snake-case-immutable", "unsafe-typecast", "mixed-case-function", "unwrapped-modifier-logic", "asm-keccak256"]
 * @notice         : Deploy boxV1,, deploy proxy that has an implementation of BoxV1
 *=======================================================================================================================**/

contract DeployBox is Script {
    function run() external returns (address) {
        vm.startBroadcast();
        BoxV1 box = new BoxV1();
        ERC1967Proxy proxy = new ERC1967Proxy(address(box), "");
        // BoxV1(address(proxy)).initialize(); //? i am so lost starting from here, why is the BoxV1 (implementation) can be used as an ABI for proxy contract????
        vm.stopBroadcast();
        return address(proxy);
    }
}