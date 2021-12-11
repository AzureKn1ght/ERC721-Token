// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

// Import dependencies from the OpenZeppelin library 
import "@openzeppelin/contracts@4.4.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.4.0/security/Pausable.sol";
import "@openzeppelin/contracts@4.4.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.4.0/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts@4.4.0/utils/Counters.sol";


// https://github.com/AzureKn1ght/ERC721-Token
contract PhilsonNFT is ERC721, Pausable, Ownable, ERC721Burnable {
    
    // Inherits Burn function from ERC721Burnable
    // Basically transfers ownership to address(0)
    

    // Declare a Counter for incremental ID
    // Counter values starts from 0 by default
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    // Constructor function to define token Name and Symbol
    constructor() ERC721("Philson NFT", "PHILSON") {}


    // Functions to pause/unpause Token Transfers
    // Basically just sets "paused" to true/false
    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }


    // Function to Mint new NFT tokens to an address
    // Reverts if token ID already exists (safeMint)
    function mint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }


    // Function to check whether "paused" before token transfers
    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }
}

