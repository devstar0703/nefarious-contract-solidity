// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "./NEFANFT.sol" ;

contract NEFAMarketplace is Ownable {
    using Counters for Counters.Counter ;
    Counters.Counter nft_counter ;

    NEFANFT private nefa_nft_contract ;

    address marketplace_owner ;

    address[] private units ;
   
    struct owner_info {
        address owner_addr ;
        uint256 amount;
        uint256 price ;
    }

    struct nft {
        uint256 nft_id;
        uint256 total_amount ;
        uint256 royalty;
        string name ;
        string description ;
        string uri ;
        owner_info[] owners;
    }

    mapping(uint256 => nft) private nfts ;

    event NFTListed(uint256) ;

    constructor ( address _nefa_nft_contract_addr ) {
        nefa_nft_contract = NEFANFT(_nefa_nft_contract_addr) ;

        marketplace_owner = msg.sender ;

        nefa_nft_contract.setNefaMarketplaceToNFT(address(this));
    }

    function mintNFT(
        address _from,
        uint256 _amount,
        uint256 _price,
        uint256 _royalty,
        string memory name,
        string memory description,
        string memory uri
    ) 
    public {
        uint256 new_nft_id = nft_counter.current();

        nft_counter.increment() ;

        nfts[new_nft_id].nft_id = new_nft_id ;
        nfts[new_nft_id].nft_price = _price ;
        nfts[new_nft_id].name = name ;
        nfts[new_nft_id].description = description ;
        nfts[new_nft_id].uri = uri ;
        nfts[new_nft_id].royalty = _royalty;
        nfts[new_nft_id].total_amount = _amount ;
        nfts[new_nft_id].owners.push({
            owner_addr : msg.sender,
            amount : total_amount,
            price : _price
        }) ;

        nefa_nft_contract.mint(_from, new_nft_id , _amount);

        emit NFTListed(new_nft_id);
    }

    function buyNow(uint256 _nft_id, address _from, address _to, uint256 _amount) public {
        nefa_nft_contract.transfer(_nft_id, _from, _to, _amount);
    }

    function fetchAllNFTs() external view returns(nft[] memory) {
        nft[] memory _nfts = new nft[](nft_counter.current()) ;

        for(uint256 i = 0 ; i < nft_counter.current(); i++) {
            _nfts[i] = nfts[i] ;
        }
        
        return _nfts ;
    }
}
