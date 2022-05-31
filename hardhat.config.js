require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-etherscan");
require("dotenv").config();

const POLYGON_TESTNET_URL = process.env.POLYGON_TESTNET_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;
const POLYGONSCAN_API_KEY = process.env.POLYGONSCAN_API_KEY;

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.4",
  networks: {
    mumbai: {
      url: POLYGON_TESTNET_URL,
      accounts: [PRIVATE_KEY]
    }
  },
  etherscan: {
    // Your API key for Polygonscan
    // Obtain one at https://polygonscan.com/
    apiKey: POLYGONSCAN_API_KEY
  }
};
