// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "erc721a/contracts/ERC721A.sol";

contract ParallelMeerkatManorHouse is ERC721A, Ownable {
    uint256 public maxGlobalMeerkats = 555;

    constructor(uint256 maxSupply) ERC721A("ParallelMeerkatManorHouse", "PMMH") {
        maxGlobalMeerkats = maxSupply;
    }

    function mint(uint256 quantity) external payable onlyOwner {
        _mint(msg.sender, quantity);
    }

    function _baseURI() internal view virtual override(ERC721A) returns (string memory) {
        return "https://parallelmeerkats.com/m/";
    }

    function tokenURI(uint256 tokenId) public view virtual override(ERC721A) returns (string memory) {
        if (!_exists(tokenId)) revert URIQueryForNonexistentToken();

        string memory baseURI = _baseURI();
        return bytes(baseURI).length != 0 ? string(abi.encodePacked(baseURI, _toString(tokenId), '.json')) : '';
    }
}
