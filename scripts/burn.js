const hre = require('hardhat')

async function main() {

  // We get the contract to deploy
  const ParallelMeerkatManorHouse = await hre.ethers.getContractFactory('ParallelMeerkatManorHouse')
  // parallel meerkats (aka parallel merkles)
  // the address reported by deploy()
  const pmmh = await ParallelMeerkatManorHouse.attach('0xEBe73A43Fd83A685B27893e444FC3eF3dE7c290D')

  if (!process.env.TOKEN_ID) {
    console.error("Bad TOKEN_ID")
    return
  }

  const result = await pmmh.burn(process.env.TOKEN_ID)
  console.log(result)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error)
  process.exitCode = 1
})
