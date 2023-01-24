/// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NEFANFT is ERC1155 {

    address private _nef_marketplace = address(0);

    constructor() ERC1155("") {
      
    }

    function setNefaMarketplaceToNFT(address nef_marketplace) external {
        require(_nef_marketplace ==  address(0), "NEFANFT Contract: Don't attemp to change marketplace address!") ;

        _nef_marketplace = nef_marketplace ;
    }

    function mint(address _from , uint256 _id, uint256 _amount) external isCalledMarketplace {
        _mint(_from, _id, _amount, '');
    }
    function transfer(uint256 nft_id, address from, address to, uint256 amount) external isCalledMarketplace {
        _setApprovalForAll(from, msg.sender , true); // allow that <msg.sender> can transfer <from>'s nft. 
        // msg.sender is marketplace contract
        safeTransferFrom(from, to, nft_id, amount, '');
    }

    function _balanceOf(address _owner, uint256 nft_id ) external view returns(uint256) {
        return balanceOf(_owner, nft_id);
    }

    modifier isCalledMarketplace() {
        require(_nef_marketplace == msg.sender, "isCalledMarketplace: you can't call this function") ;
        _;
    }
}