const NEFANFT = artifacts.require("NEFANFT");

module.exports = async function (deployer) {
  await deployer.deploy(NEFANFT);

  const deployed_nefa_nft_contract = await NEFANFT.deployed() ;

  console.log("NEFA NFT Contract Address:", deployed_nefa_nft_contract.address);
};