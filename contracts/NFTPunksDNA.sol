//SPDX-License-Identifier: GLP-3.0

pragma solidity ^0.8.0;

contract NFTPunksDNA {
  string[] private _accessoriesType = [
        "Blank",
        "Kurt",
        "Prescription01",
        "Prescription02",
        "Round",
        "Sunglasses",
        "Wayfarers"
    ];

    string[] private _clotheColor = [
        "Black",
        "Blue01",
        "Blue02",
        "Blue03",
        "Gray01",
        "Gray02",
        "Heather",
        "PastelBlue",
        "PastelGreen",
        "PastelOrange",
        "PastelRed",
        "PastelYellow",
        "Pink",
        "Red",
        "White"
    ];

    string[] private _clotheType = [
        "BlazerShirt",
        "BlazerSweater",
        "CollarSweater",
        "GraphicShirt",
        "Hoodie",
        "Overall",
        "ShirtCrewNeck",
        "ShirtScoopNeck",
        "ShirtVNeck"
    ];

    string[] private _eyeType = [
        "Close",
        "Cry",
        "Default",
        "Dizzy",
        "EyeRoll",
        "Happy",
        "Hearts",
        "Side",
        "Squint",
        "Surprised",
        "Wink",
        "WinkWacky"
    ];

    string[] private _eyebrowType = [
        "Angry",
        "AngryNatural",
        "Default",
        "DefaultNatural",
        "FlatNatural",
        "RaisedExcited",
        "RaisedExcitedNatural",
        "SadConcerned",
        "SadConcernedNatural",
        "UnibrowNatural",
        "UpDown",
        "UpDownNatural"
    ];

    string[] private _facialHairColor = [
        "Auburn",
        "Black",
        "Blonde",
        "BlondeGolden",
        "Brown",
        "BrownDark",
        "Platinum",
        "Red"
    ];

    string[] private _facialHairType = [
        "Blank",
        "BeardMedium",
        "BeardLight",
        "BeardMagestic",
        "MoustacheFancy",
        "MoustacheMagnum"
    ];

    string[] private _hairColor = [
        "Auburn",
        "Black",
        "Blonde",
        "BlondeGolden",
        "Brown",
        "BrownDark",
        "PastelPink",
        "Platinum",
        "Red",
        "SilverGray"
    ];

    string[] private _hatColor = [
        "Black",
        "Blue01",
        "Blue02",
        "Blue03",
        "Gray01",
        "Gray02",
        "Heather",
        "PastelBlue",
        "PastelGreen",
        "PastelOrange",
        "PastelRed",
        "PastelYellow",
        "Pink",
        "Red",
        "White"
    ];

    string[] private _graphicType = [
        "Bat",
        "Cumbia",
        "Deer",
        "Diamond",
        "Hola",
        "Pizza",
        "Resist",
        "Selena",
        "Bear",
        "SkullOutline",
        "Skull"
    ];

    string[] private _mouthType = [
        "Concerned",
        "Default",
        "Disbelief",
        "Eating",
        "Grimace",
        "Sad",
        "ScreamOpen",
        "Serious",
        "Smile",
        "Tongue",
        "Twinkle",
        "Vomit"
    ];

    string[] private _skinColor = [
        "Tanned",
        "Yellow",
        "Pale",
        "Light",
        "Brown",
        "DarkBrown",
        "Black"
    ];

    string[] private _topType = [
        "NoHair",
        "Eyepatch",
        "Hat",
        "Hijab",
        "Turban",
        "WinterHat1",
        "WinterHat2",
        "WinterHat3",
        "WinterHat4",
        "LongHairBigHair",
        "LongHairBob",
        "LongHairBun",
        "LongHairCurly",
        "LongHairCurvy",
        "LongHairDreads",
        "LongHairFrida",
        "LongHairFro",
        "LongHairFroBand",
        "LongHairNotTooLong",
        "LongHairShavedSides",
        "LongHairMiaWallace",
        "LongHairStraight",
        "LongHairStraight2",
        "LongHairStraightStrand",
        "ShortHairDreads01",
        "ShortHairDreads02",
        "ShortHairFrizzle",
        "ShortHairShaggyMullet",
        "ShortHairShortCurly",
        "ShortHairShortFlat",
        "ShortHairShortRound",
        "ShortHairShortWaved",
        "ShortHairSides",
        "ShortHairTheCaesar",
        "ShortHairTheCaesarSidePart"
    ];

    // TODO: Calculate DNA
    function deterministicPseudoRandomDNA(uint256 _tokenId, address _minter)
        public
        pure
        returns (uint256)
    {
        uint256 combinedParams = _tokenId + uint160(_minter);
        bytes memory encodedParams = abi.encodePacked(combinedParams);

        return uint256( keccak256(encodedParams));
    }



    // Get attributes
    uint8 constant ADN_SECTION_SIZE = 2;


     function _getDNASection(uint256 _dna, uint8 _rightDiscard)
        internal
        pure
        returns (uint8)
    {
        return
            uint8(
                (_dna % (1 * 10**(_rightDiscard + ADN_SECTION_SIZE))) /
                    (1 * 10**_rightDiscard)
            );
    }

    function getAccessoriesType(uint256 _dna)
        public
        view
        returns (string memory)
    {
        return _accessoriesType[_getDNASection(_dna, 0) % _accessoriesType.length];
    }

    function getClotheColor(uint256 _dna) public view returns (string memory) {
        return _clotheColor[_getDNASection(_dna, 2) % _clotheColor.length];
    }

    function getClotheType(uint256 _dna) public view returns (string memory) {
        return _clotheType[_getDNASection(_dna, 4) % _clotheType.length];
    }

    function getEyeType(uint256 _dna) public view returns (string memory) {
        return _eyeType[_getDNASection(_dna, 6) % _eyeType.length];
    }

    function getEyeBrowType(uint256 _dna) public view returns (string memory) {
        return _eyebrowType[_getDNASection(_dna, 8) % _eyebrowType.length];
    }

    function getFacialHairColor(uint256 _dna)
        public
        view
        returns (string memory)
    {
        return _facialHairColor[_getDNASection(_dna, 10) % _facialHairColor.length];
    }

    function getFacialHairType(uint256 _dna)
        public
        view
        returns (string memory)
    {
        return _facialHairType[_getDNASection(_dna, 12) % _facialHairType.length];
    }

    function getHairColor(uint256 _dna) public view returns (string memory) {
        return _hairColor[_getDNASection(_dna, 14) % _hairColor.length];
    }

    function getHatColor(uint256 _dna) public view returns (string memory) {
        return _hatColor[_getDNASection(_dna, 16) % _hatColor.length];
    }

    function getGraphicType(uint256 _dna) public view returns (string memory) {
        return _graphicType[_getDNASection(_dna, 18) % _graphicType.length];
    }

    function getMouthType(uint256 _dna) public view returns (string memory) {
        return _mouthType[_getDNASection(_dna, 20) % _mouthType.length];
    }

    function getSkinColor(uint256 _dna) public view returns (string memory) {
        return _skinColor[_getDNASection(_dna, 22) % _skinColor.length];
    }

    function getTopType(uint256 _dna) public view returns (string memory) {
        return _topType[_getDNASection(_dna, 24) % _topType.length];
    }
}