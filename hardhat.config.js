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
        '0xbd2d7f5b2398422fb368af034105c8642df69bae4b6ba96b57f676fc205b8ee3'
      ]
    }
  }
};