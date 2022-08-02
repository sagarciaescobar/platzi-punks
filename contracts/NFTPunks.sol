//SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/finance/PaymentSplitter.sol";
import "./Base64.sol";
import "./NFTPunksADN.sol";

contract NFTPunks is ERC721, ERC721Enumerable, PaymentSplitter, NFTPunksADN {
    using Counters for Counters.Counter;

    Counters.Counter private _idCounter;
    uint256 public maxSupply;

    constructor(
        uint256 _maxSupply,
        address[] memory payees,
        uint256[] memory shares_
    ) ERC721("NFTPunk", "NP") PaymentSplitter(payees, shares_) {
        maxSupply = _maxSupply;
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function mint() public payable {
      require(msg.value >= 5 * (10**16),"you neet 0.05 ETH to mint the PinaPunks");
        uint256 current = _idCounter.current();
        require(current <= maxSupply, "No NTFPunks left");
        _safeMint(msg.sender, current);
        _idCounter.increment();
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory){
        require(_exists(tokenId),"ERC721 Metadata: URI query for nonexistent token");
        string memory jsonURI = Base64.encode(
            abi.encodePacked(
             '{ name: "NFTPunks #',
             tokenId,
             '" , "description": "NFT Punks are randomized Avataaars stored on chain to teach DApp development", "image": "',
             "//TODO calculate image URL",
             '"}'
            )
        );
        return string(abi.encodePacked("data:application/json;base64,", jsonURI ));
    } 
}
