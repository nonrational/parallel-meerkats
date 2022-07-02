// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "erc721a/contracts/ERC721A.sol";

contract ParallelMeerkatManorHouse is ERC721, ERC721URIStorage, ERC721Enumerable, Ownable {
    event TraitUpdated(uint256 indexed tokenId, string trait, bool value);

    uint256 public maxGlobalMeerkats = 555;

    // every time we mint, increment the last meerkat id
    using Counters for Counters.Counter;
    Counters.Counter private _lastMeerkatId;

    struct Metadata {
        uint256 _mintedAt;
    }

    mapping(uint256 => Metadata) private _metas;

    // solhint-disable-next-line no-empty-blocks
    // constructor() ERC721("ParallelMeerkatManorHouse", "PMMH") {}

    constructor(uint256 maxSupply) ERC721("ParallelMeerkatManorHouse", "PMMH") {
        maxGlobalMeerkats = maxSupply;
    }

    /**
     *
     */
    function mintMeerkat(address recipient) external virtual onlyOwner returns (uint256) {
        _lastMeerkatId.increment();

        uint256 tokId = _lastMeerkatId.current();
        string memory uri = string(abi.encodePacked("https://parallelmeerkats.com/m/", Strings.toString(tokId), ".json"));
        _safeMint(recipient, tokId);
        _setTokenURI(tokId, uri);

        Metadata storage meta = _metas[tokId];
        meta._mintedAt = block.timestamp;

        return tokId;
    }

    function mintedAt(uint256 tokenId) public view virtual returns (uint256) {
        require(_exists(tokenId), "Request for nonexistent token");
        return _metas[tokenId]._mintedAt;
    }

    function tokenURI(uint256 tokenId) public view virtual override(ERC721, ERC721URIStorage) returns (string memory) {
        require(_exists(tokenId), "Request for nonexistent token");
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal virtual override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
        delete _metas[tokenId];
    }

    function burn(uint256 tokenId) public virtual {
        require(_exists(tokenId), "Cannot burn nonexistent token");

        // if the message sender is the token owner or the contract owner, allow burning
        address tokenOwner = ERC721.ownerOf(tokenId);
        require(_msgSender() == tokenOwner || _msgSender() == owner(), "Caller is not owner nor approved");

        _burn(tokenId);
    }
}
