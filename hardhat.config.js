require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

const projectId = process.env.INFURA_PROJECT_ID
const deployer = process.env.DEPLOYER_SIGNER_KEY

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.9",
  networks: {
    rinkeby:{
      url: `https://rinkeby.infura.io/v3/${projectId}`,
      accounts: [
        deployer
      ]
    },
    ropsten:{
      url: `https://rinkeby.infura.io/v3/${projectId}`,
      accounts: [
        deployer
      ]
    },
    local:{
      url: 'HTTP://127.0.0.1:8545',
      accounts: [
        '0xa7853ae1e7e3916e66196a6012065958b010aa40dffb03cb1f545c0cc4ed2d30'
      ]
    }
  }
};