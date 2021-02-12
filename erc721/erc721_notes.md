# ERC721 Tokens 
Also NFT or non-fungible tokens

Specification:
https://eips.ethereum.org/EIPS/eip-721

Implementation:
https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol

Usage: Insurance, bonds, derivatives

Data structure:
* tokenIds: int  -> owner : address


External functions:
```
// returns number of NFTs for specific address
balanceOf(address _owner) view returns (uint256)
// returns owner address of specific token id
ownerOf(uint256 _tokenId) view returns (address)
// transfer token safely (to smart contract that can handle ERC721)
safeTransferFrom
// unsafe version
transferFrom
```

Interfaces:
// Implemented by smart contract that should be able to receive ERC721 tokens
ERC721TokenReceiver
// Metatata with additional information describing asset (optional)
ERC721Metadata
// Other data, total supply, tokenByIndex, tokenOfOwnerByIndex (optional)
ERC721Enumerable

