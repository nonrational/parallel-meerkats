// scripts/verify.js
const { ethers, upgrades } = require('hardhat')
const fs = require('fs')

async function main() {
  if (!fs.existsSync(process.env.DEPLOY_ADDRESSES_PATH)) {
    throw `Missing ${process.env.DEPLOY_ADDRESSES_PATH}`
  }

  console.log('Verifying...')

  const addresses = JSON.parse(fs.readFileSync(process.env.DEPLOY_ADDRESSES_PATH))
  await run('verify', { address: addresses.implementation })
}

main().catch((error) => {
  console.error(error)
  process.exitCode = 1
})
