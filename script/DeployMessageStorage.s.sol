//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/src/Script.sol";
import { MessageStorage } from "src/MessageStorage.sol";

contract DeployMessageStorage is Script {
    function run() external {
        vm.startBroadcast();
        new MessageStorage();
        vm.stopBroadcast();
    }
}
