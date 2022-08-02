const deploy = async () =>{
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contract with account:", deployer.address);

  const NFTPunks = await ethers.getContractFactory("NFTPunks");
  const deployed = await NFTPunks.deploy(10,
    ['0x8847925D2887629D18Dc7BE69880635FFF4CF01b'],[20]);

  console.log("NFTPunks is deployed at:", deployed.address);
}

deploy().then(()=> process.exit(0)).catch(err => {
  console.log(err);
  process.exit(1);
});