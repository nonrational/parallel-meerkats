// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@parallelmarkets/token/contracts/IParallelID.sol";
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
        if (!hasAnySanctionsSafeIdentityToken(from) || !hasAnySanctionsSafeIdentityToken(to)) revert("Transfer forbidden");

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

    address PID_CONTRACT_RINKEBY = "0x0F2255E8aD232c5740879e3B495EA858D93C3016";
    // address PID_CONTRACT_MAINNET = "0x9ec6232742b6068ce733645AF16BA277Fa412B0A";

    function hasAnySanctionsSafeIdentityToken(address subject) internal returns (bool) {
        IParallelID pid = IParallelID(PID_CONTRACT_RINKEBY);

        for (uint256 i = 0; i < pid.balanceOf(subject); i++) {
            uint256 tokenId = pid.tokenOfOwnerByIndex(subject, i);
            if (pid.isSanctionsSafe(tokenId)) return true;
        }
        return false;
    }
}
