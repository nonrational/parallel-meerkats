// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require('hardhat')
const fs = require('fs')

const keypress = async () => {
  process.stdin.setRawMode(true)
  return new Promise((resolve) =>
    process.stdin.once('data', (data) => {
      const byteArray = [...data]
      if (byteArray.length > 0 && byteArray[0] === 3) {
        console.log('^C')
        process.exit(1)
      }
      process.stdin.setRawMode(false)
      resolve()
    })
  )
}

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

  const toAddress = process.env.TO_ADDRESS
  const meerkatId = process.env.MEERKAT_ID

  if (!toAddress || !meerkatId) {
    throw 'Please specify TO_ADDRESS and MEERKAT_ID'
  }

  console.log(`Gifting #${meerkatId} to ${toAddress}`)
  console.log(`Press enter to continue...`)
  await keypress()

  console.log('Gifting...')

  const ParallelMeerkatManorHouse = await hre.ethers.getContractFactory('ParallelMeerkatManorHouse')
  const deployment = JSON.parse(fs.readFileSync(process.env.DEPLOY_ADDRESSES_PATH))
  const contract = ParallelMeerkatManorHouse.attach(deployment.proxy)
  const result = await contract.ownerGift(toAddress, meerkatId)
  console.log(result)

  console.log('Done.')
  process.exit(0)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error)
  process.exitCode = 1
})
