// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script, console} from "forge-std/Script.sol";
import {BagelToken} from "../src/BagelToken.sol";
import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";
import {IERC20, SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract DeployMerkleAirdrop is Script {
    bytes32 private s_merkleRoot = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
    uint256 private s_amountToAirdrop = 25e18 * 4;

    function run() external returns (MerkleAirdrop, BagelToken) {
        return deployMerkleAirdrop();
    }

    function deployMerkleAirdrop() public returns (MerkleAirdrop, BagelToken) {
        vm.startBroadcast();
        BagelToken token = new BagelToken();
        MerkleAirdrop airdrop = new MerkleAirdrop(s_merkleRoot, IERC20(address(token)));
        token.mint(token.owner(), s_amountToAirdrop);
        token.transfer(address(airdrop), s_amountToAirdrop);
        vm.stopBroadcast();
        return (airdrop, token);
    }
}
