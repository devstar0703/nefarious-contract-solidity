const NEFAMarketplace = artifacts.require("NEFAMarketplace");
const NEFANFT = artifacts.require("NEFANFT") ;

module.exports = async function (deployer) {
  await deployer.deploy(NEFANFT) ;

  const deployed_nefa_nft_contract = await NEFANFT.deployed() ;

  console.log(deployed_nefa_nft_contract.address) ;

  await deployer.deploy(
    NEFAMarketplace,
    deployed_nefa_nft_contract.address
  );

  const deployed_nefa_marketplace_contract =  await NEFAMarketplace.deployed() ;

  console.log("NEFA Marketplace Address:", deployed_nefa_marketplace_contract.address);
};