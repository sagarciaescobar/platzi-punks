//SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/finance/PaymentSplitter.sol";
import "./Base64.sol";
import "./NFTPunksDNA.sol";

contract NFTPunks is ERC721, ERC721Enumerable, PaymentSplitter, NFTPunksDNA {
    using Counters for Counters.Counter;

    Counters.Counter private _idCounter;
    uint256 public maxSupply;
    mapping(uint256 => uint256) public tokenDNA;

    constructor(
        uint256 _maxSupply,
        address[] memory payees,
        uint256[] memory shares_
    ) payable ERC721("NFTPunk", "NP") PaymentSplitter(payees, shares_) {
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

    function _baseURI() internal pure override returns (string memory) {
        return "https://avataaars.io/";
    }

    function _paramsURI(uint256 _dna) internal view returns (string memory) {
        string memory params = string(
            abi.encodePacked(
                "accessoriesType=",
                getAccessoriesType(_dna),
                "&clotheColor=",
                getClotheColor(_dna),
                "&clotheType=",
                getClotheType(_dna),
                "&eyeType=",
                getEyeType(_dna),
                "&eyebrowType=",
                getEyeBrowType(_dna)
            )
        );
        return
            string(
                abi.encodePacked(
                    params,
                    "&facialHairColor=",
                    getFacialHairColor(_dna),
                    "&facialHairType=",
                    getFacialHairType(_dna),
                    "&hairColor=",
                    getHairColor(_dna),
                    "&hatColor=",
                    getHatColor(_dna),
                    "&graphicType=",
                    getGraphicType(_dna),
                    "&mouthType=",
                    getMouthType(_dna),
                    "&skinColor=",
                    getSkinColor(_dna),
                    "&topType=",
                    getTopType(_dna)
                )
            );
    }

    function imageByDNA(uint256 _dna) public view returns (string memory) {
        return string(abi.encodePacked(_baseURI(), "?", _paramsURI(_dna)));
    }

    function mint() public payable {
        require(msg.value >= 5 * (10**16), "you need 0.05 ETH to mint");
        uint256 current = _idCounter.current();
        tokenDNA[current] = deterministicPseudoRandomDNA(current, msg.sender);
        require(current < maxSupply, "No NTFPunks left");
        _safeMint(msg.sender, current);
        _idCounter.increment();
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        require(_exists(tokenId), "URI query for nonexistent token");
        string memory json = Base64.encode(
            abi.encodePacked(
                '{ name: "NFTPunks #',
                tokenId,
                '" , "description": "NFT Punks are randomized Avataaars stored on chain", "image": "',
                imageByDNA(tokenDNA[tokenId]),
                '"}'
            )
        );
        return string(abi.encodePacked("data:application/json;base64,", json));
    }
}
