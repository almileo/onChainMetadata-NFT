const hre = require("hardhat");

//Contract deploy 0x0eBe746f7e4F92b5b055d38D31938DEC568D4959 sample poject
//Contract deploy 0xFc7ECCB885b934Bdd35578f2CB30dC26b20fFea0 my poject introducing struct best approach without random()
//Contract deploy 0xb93f88D08bcf863377810a85762709eaeBEF9A1B my poject with random()

async function main() {
  try {
    const nftContractFactory = await hre.ethers.getContractFactory("ChainBattles");
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();

    console.log('Contract deployed to: ', nftContract.address);
    process.exit(0);
  } catch (error) {
    console.log('error: ', error);
    process.exit(1);
  }
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
