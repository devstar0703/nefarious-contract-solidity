const ethers = require('ethers') ;

const NEFAMarketplace = artifacts.require('./NEFAMarketplace.sol') ;
const NEFANFT = artifacts.require('./NEFANFT.sol') ;

require('chai')
    .use(require('chai-as-promised'))
    .should() ;

contract('Marketplace Contract', async () => {
    let nftMarketplace ;
    let nefaNFT ;

    before(async () => {
        nefaNFT = await NEFANFT.deployed() ;

        nftMarketplace = await NEFAMarketplace.deployed([
            nefaNFT.address
        ]);
    });

    it('NEFA Marketplace' , async() => {
        // return;
        let creator = '0x76cCAc6F31B1528538079017dCDb2420e3c452d0';
        let nft_price = 10; 

        let amount = 10 ;
        let royalty = 10 ;
        let nft_uri = 'aPm1szRiIGvK28sCZhr8' ;

        nft_price = ethers.utils.parseUnits(nft_price.toString(), '6') ;
        royalty = ethers.utils.parseUnits(royalty.toString(), 'ether') ;

        let new_nft_id = await nftMarketplace.mintNFT(
                creator,
                amount,
                nft_price,
                royalty,
                "Boat",
                "This is created by Misuka",
                nft_uri
        ) ;

        new_nft_id = await nftMarketplace.mintNFT(
            creator,
            amount,
            nft_price,
            royalty,
            "Boat",
            "This is created by Misuka",
            nft_uri
        ) ;

        console.log(new_nft_id.receipt.logs.filter(log => log.event === 'NFTListed')[0].args[0].toString()) ;
    })
});