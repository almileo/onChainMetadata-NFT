//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract ChainBattles is ERC721URIStorage {
    using Strings for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    uint randomSpeed = 15;
    uint randomStamina = 10;
    uint randomDefence = 5;
    uint randomAttack = 8;

    struct Character {
        uint levels;
        uint stamina;
        uint speed;
        uint defence;
        uint attack;
    }

    mapping(uint256 => Character) public tokenIdtoCharacters;

    constructor() ERC721("Chain Battles", "CBT") {

    }
        
    function generateCharacter(uint256 tokenId) public returns (string memory) {
        bytes memory svg = abi.encodePacked(
            '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350">',
            '<style>.base { fill: white; font-family: serif; font-size: 14px; }</style>',
            '<rect width="100%" height="100%" fill="#448eb3" />',
            '<text x="50%" y="20%" class="base" dominant-baseline="middle" text-anchor="middle">',"Warrior - ",tokenId.toString(),'</text>',
            '<text x="50%" y="30%" class="base" dominant-baseline="middle" text-anchor="middle">', "Level: ",getLevels(tokenId),'</text>',
            '<text x="50%" y="40%" class="base" dominant-baseline="middle" text-anchor="middle">', "Stamina: ",getStamina(tokenId),'</text>',
            '<text x="50%" y="50%" class="base" dominant-baseline="middle" text-anchor="middle">', "Speed: ",getSpeed(tokenId),'</text>',
            '<text x="50%" y="60%" class="base" dominant-baseline="middle" text-anchor="middle">', "Defence: ",getDefence(tokenId),'</text>',
            '<text x="50%" y="70%" class="base" dominant-baseline="middle" text-anchor="middle">', "Attack: ",getAttack(tokenId),'</text>',
            '</svg>'
        );
        
        return string (
            abi.encodePacked(
                "data:image/svg+xml;base64,",
                Base64.encode(svg)
            )
        );
    }

    function random(uint _mod) private view returns (uint) {
      return uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, msg.sender))) % _mod;
    }

    function getLevels(uint256 tokenId) public view returns (string memory) {
        Character memory character = tokenIdtoCharacters[tokenId];
        uint levels = character.levels;
        return levels.toString();
    }

    function getStamina(uint256 tokenId) public view returns (string memory) {
        Character memory character = tokenIdtoCharacters[tokenId];
        uint stamina = character.stamina;
        return stamina.toString();
    }

    function getSpeed(uint256 tokenId) public view returns (string memory) {
        Character memory character = tokenIdtoCharacters[tokenId];
        uint speed = character.speed;
        return speed.toString();
    }

    function getDefence(uint256 tokenId) public view returns (string memory) {
        Character memory character = tokenIdtoCharacters[tokenId];
        uint defence = character.defence;
        return defence.toString();
    }

    function getAttack(uint256 tokenId) public view returns (string memory) {
        Character memory character = tokenIdtoCharacters[tokenId];
        uint attack = character.attack;
        return attack.toString();
    }

    function getTokenURI(uint256 tokenId) public returns (string memory){
        bytes memory dataURI = abi.encodePacked(
            '{',
                '"name": "Chain Battles upg #', tokenId.toString(), '",',
                '"description": "Battles on chain",',
                '"image": "', generateCharacter(tokenId), '"'
            '}'
        );
        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(dataURI)
            )
        );
    }

    function mint() public {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _safeMint(msg.sender, newItemId);
        Character storage character = tokenIdtoCharacters[newItemId];
        character.levels = 0;
        character.stamina = random(randomStamina);
        character.speed = random(randomSpeed);
        character.defence = random(randomDefence);
        character.attack = random(randomAttack);
        _setTokenURI(newItemId, getTokenURI(newItemId));
    }

    function train(uint256 tokenId) public {
        require(_exists(tokenId));
        require(ownerOf(tokenId) == msg.sender, "You must own this NFT to train it!");
        Character storage character = tokenIdtoCharacters[tokenId];
        character.levels = character.levels + 1;
        character.stamina = character.stamina + random(randomStamina);
        character.speed = character.speed + random(randomSpeed);
        character.defence = character.defence + random(randomDefence);
        character.attack = character.attack + random(randomAttack);
        _setTokenURI(tokenId, getTokenURI(tokenId));
    }
}
