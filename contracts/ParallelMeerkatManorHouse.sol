// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "erc721a-upgradeable/contracts/extensions/ERC721AQueryableUpgradeable.sol";
import "erc721a-upgradeable/contracts/ERC721AUpgradeable.sol";

contract ParallelMeerkatManorHouse is ERC721AQueryableUpgradeable, OwnableUpgradeable {
    // Take note of the initializer modifiers.
    // - `initializerERC721A` for `ERC721AUpgradeable`.
    // - `initializer` for OpenZeppelin's `OwnableUpgradeable`.
    function initialize() public initializerERC721A initializer {
        __ERC721A_init("ParallelMeerkatManorHouse", "PMMH");
        __Ownable_init();
    }

    function ownerMint(uint256 quantity) external onlyOwner {
        _mint(msg.sender, quantity);
    }

    function ownerGift(address to, uint256 tokenId) external onlyOwner {
        super.transferFrom(msg.sender, to, tokenId);
    }

    function transferFrom(address from,  address to,  uint256 tokenId) public virtual override {
        revert("MISSING KYC");
        super.transferFrom(from, to, tokenId);
    }

    function _baseURI() internal view virtual override(ERC721AUpgradeable) returns (string memory) {
        return "https://parallelmeerkats.com/data/";
    }

    function tokenURI(uint256 tokenId) public view virtual override(ERC721AUpgradeable) returns (string memory) {
        if (!_exists(tokenId)) revert URIQueryForNonexistentToken();

        string memory baseURI = _baseURI();
        return bytes(baseURI).length != 0 ? string(abi.encodePacked(baseURI, _toString(tokenId), ".json")) : "";
    }
}
