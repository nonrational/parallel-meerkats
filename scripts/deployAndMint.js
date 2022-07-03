const hre = require('hardhat')

async function main() {
  // await hre.run('compile');

  const ParallelMeerkatManorHouse = await hre.ethers.getContractFactory('ParallelMeerkatManorHouse')
  const factory = await ParallelMeerkatManorHouse.deploy(10)
  await factory.deployed()

  console.log('ParallelMeerkatManorHouse deployed to:', factory.address)

  const contract = await ParallelMeerkatManorHouse.attach(factory.address)
  const result = await contract.mint(3)

  console.log('ParallelMeerkatManorHouse.mint result:', result)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error)
  process.exitCode = 1
})
