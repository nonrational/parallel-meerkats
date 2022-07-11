// scripts/deploy.js
const { ethers, upgrades } = require('hardhat')
const fs = require('fs')

async function main() {
  if (!process.env.DEPLOY_ADDRESSES_PATH) {
    throw 'Missing DEPLOY_ADDRESSES_PATH'
  }

  const ParallelMeerkatManorHouse = await ethers.getContractFactory('ParallelMeerkatManorHouse')
  console.log('Deploying...')
  const pmm = await upgrades.deployProxy(ParallelMeerkatManorHouse, [], { initializer: 'initialize' })
  await pmm.deployed()

  const addresses = {
    proxy: pmm.address,
    admin: await upgrades.erc1967.getAdminAddress(pmm.address),
    implementation: await upgrades.erc1967.getImplementationAddress(pmm.address),
  }
  console.log('Addresses:', addresses)

  try {
    await run('verify', { address: addresses.implementation })
  } catch (e) {
    console.warn('verification failed:', e.message)
  }

  fs.writeFileSync(process.env.DEPLOY_ADDRESSES_PATH, JSON.stringify(addresses))
}

main().catch((error) => {
  console.error(error)
  process.exitCode = 1
})
