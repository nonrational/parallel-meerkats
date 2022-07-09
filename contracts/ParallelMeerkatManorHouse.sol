// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "erc721a/contracts/extensions/ERC721AQueryable.sol";
import "erc721a/contracts/ERC721A.sol";

contract ParallelMeerkatManorHouse is ERC721AQueryable, Ownable {
    constructor() ERC721A("ParallelMeerkatManorHouse", "PMMH") {}

    function mintMany(uint256 quantity) external payable onlyOwner {
        _mint(msg.sender, quantity);
    }

    function _baseURI() internal view virtual override(ERC721A) returns (string memory) {
        return "https://parallelmeerkats.com/data/";
    }

    function tokenURI(uint256 tokenId) public view virtual override(ERC721A) returns (string memory) {
        if (!_exists(tokenId)) revert URIQueryForNonexistentToken();

        string memory baseURI = _baseURI();
        return bytes(baseURI).length != 0 ? string(abi.encodePacked(baseURI, _toString(tokenId), ".json")) : "";
    }
}
