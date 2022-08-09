const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("NFTPunks Contract", () => {
  const setup = async ({ maxSupply = 10000 }) => {
    const [owner,second] = await ethers.getSigners();
    const NFTPunks = await ethers.getContractFactory("NFTPunks");
    const address = await second.getAddress();
    const deployed = await NFTPunks.deploy(maxSupply,[address],[1]);

    return {
      owner,
      deployed,
    };
  };

  describe("Deployment", () => {
    it("Set max supply to passed params", async () => {
      const maxSupply = 4000;
      const { deployed } = await setup({ maxSupply });
      const returnedMaxSupply = await deployed.maxSupply();
      expect(maxSupply).to.equal(returnedMaxSupply);
    });
  });
});
