// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract FoodSharingPlatform {
    string public projectTitle = "Food-Sharing Platform with Tokens";
    string public projectDescription = "Food- A decentralized food-sharing network rewarding contributors with tokens.";

    // Token struct to store details of food tokens
    struct FoodToken {
        uint256 tokenId;
        address owner;
        string foodDescription;
        uint256 amount;
    }

    // Mapping to store food tokens with unique tokenId
    mapping(uint256 => FoodToken) public foodTokens;
    uint256 public tokenCount;

    // Event emitted when food is shared
    event FoodShared(uint256 tokenId, address indexed owner, string foodDescription, uint256 amount);

    // Modifier to check if the caller is the owner of a token
    modifier onlyOwner(uint256 tokenId) {
        require(msg.sender == foodTokens[tokenId].owner, "Only owner can perform this action");
        _;
    }

    // Function to share food and mint a food token
    function shareFood(string memory foodDescription, uint256 amount) public {
        tokenCount++;
        foodTokens[tokenCount] = FoodToken(tokenCount, msg.sender, foodDescription, amount);
        emit FoodShared(tokenCount, msg.sender, foodDescription, amount);
    }

    // Function to get food token details
    function getFoodToken(uint256 tokenId) public view returns (FoodToken memory) {
        return foodTokens[tokenId];
    }

    // Function to transfer food token to another user
    function transferFoodToken(uint256 tokenId, address newOwner) public onlyOwner(tokenId) {
        foodTokens[tokenId].owner = newOwner;
    }
}
