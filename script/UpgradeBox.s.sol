// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {Script, console} from "forge-std/Script.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";

/**=======================================================================================================================
 * ?                                                     ABOUT
 * @notice         : foundry.toml exclude_lints = ["mixed-case-variable", "screaming-snake-case-immutable", "unsafe-typecast", "mixed-case-function", "unwrapped-modifier-logic", "asm-keccak256"]
 * @notice         : Deploy BoxV2 => Wrap the proxy address with BoxV1/V2 to access the ABI => call upgradeTo and point to BoxV2 address
 *=======================================================================================================================**/

contract UpgradeBox is Script {
    function run() public returns(address){
        address oldProxy = DevOpsTools.get_most_recent_deployment("ERC1967Proxy", block.chainid);

        vm.startBroadcast();
        BoxV2 newBox = new BoxV2();
        vm.stopBroadcast();
        address stillOldProxy = upgradeBox(oldProxy, address(newBox));
        return stillOldProxy;
    }

    function upgradeBox(address _oldProxyAddress, address _newImplementation) public returns(address) {
        BoxV1 stillOldProxy = BoxV1(_oldProxyAddress); //? how can we wrap the proxy address into BoxV1 (implementation contract) ???
        // BoxV2 stillOldProxy = BoxV2(_oldProxyAddress); //? we can wrap these in V2 or do a direct function call 
        stillOldProxy.upgradeTo(_newImplementation);
        // console.log(_oldProxyAddress);
        // console.log(address(stillOldProxy));
        return address(stillOldProxy);

    }
}


