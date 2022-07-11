// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require('hardhat')
const fs = require('fs')

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  if (!fs.existsSync(process.env.DEPLOY_ADDRESSES_PATH)) {
    throw `Missing ${process.env.DEPLOY_ADDRESSES_PATH}`
  }

  const ParallelMeerkatManorHouse = await hre.ethers.getContractFactory('ParallelMeerkatManorHouse')

  const deployment = JSON.parse(fs.readFileSync(process.env.DEPLOY_ADDRESSES_PATH))
  const contract = ParallelMeerkatManorHouse.attach(deployment.proxy)

  const result = await contract.adminMint(50)
  console.log(result)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error)
  process.exitCode = 1
})
