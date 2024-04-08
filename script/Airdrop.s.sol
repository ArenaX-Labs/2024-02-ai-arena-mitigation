// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/Neuron.sol";

contract AirdropScript is Script {
    address public immutable contributorAddress = 0xE046ed5552d20381F9F8d448D2C20085b22Ffb35;
    address public immutable treasuryAddress = 0xE046ed5552d20381F9F8d448D2C20085b22Ffb35;
    address public immutable gameServerAddress = 0x7C0a2BAd62C664076eFE14b7f2d90BF6Fd3a6F6C;
    address public immutable backendAddress = 0x22F4441ad6DbD602dFdE5Cd8A38F6CAdE68860b0;
    address[2] public adminAddresses = [
        0xb2B2d81CD161c198C81072091EEae09b7bBcCb40,
        0xe22eCde9e8Cfa57d2623C909237Ae30118428B0D
    ];

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey); 
        console.log("deployerAddress", deployerAddress);
        uint256 airdrop_claim_amount = 1000000000000000000; // 1 ETH unit of $N
        bytes32 merkle_tree_root = 0xa754c4d79d2e605f10c5bcff6fb8b2308518e84d24ce2f5d98f115e1494ad40d; // Placeholder for the Merkle tree root
        // Assuming this is the uint256 value you wish to convert and store in a bytes32[] array
        // replace this with your proof
        uint256[1] memory uintArray = [uint256(0xaf3ddfeb29b678bfe7a84286105b3b6dde13f0e646a2fd96fbe2ac1a60085ed2)];
        console.log(uintArray.length);

        // Initialize a new bytes32[] array with the same length as the uint256 array
        bytes32[] memory deployer_address_proof = new bytes32[](uintArray.length);
        // console.log(deployer_address_proof);

        // Convert each uint256 element to bytes32 and store it in the bytes32[] array
        for (uint i = 0; i < uintArray.length; i++) {
            deployer_address_proof[i] = bytes32(uintArray[i]);
        }

        // Now deployer_address_proof is a bytes32[] array and can be used as such

        vm.startBroadcast(deployerPrivateKey);

        // Deploying Contracts -------------------
        Neuron neuron = new Neuron(
            deployerAddress, 
            treasuryAddress, 
            contributorAddress,
            merkle_tree_root
        );

        // After Deployment ------------------------
        for (uint256 i = 0; i < adminAddresses.length; i++) {
            address admin = adminAddresses[i];
            neuron.adjustAdminAccess(admin, true);
        }


        neuron.claim("TGE", deployer_address_proof, airdrop_claim_amount);
        require(neuron.balanceOf(deployerAddress) == airdrop_claim_amount, "Claimed 1");

        vm.stopBroadcast();
    }
}
