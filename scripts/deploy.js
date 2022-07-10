// scripts/deploy.js
const { ethers, upgrades, network } = require('hardhat')
const fs = require('fs')

async function main() {
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
    console.log('chain id', network.config.chainId)
    await run('verify', { address: addresses.implementation })
  } catch (e) {
    console.warn('verification failed:', e.message)
  }

  fs.writeFileSync('deploy-addresses.json', JSON.stringify(addresses))
}

main().catch((error) => {
  console.error(error)
  process.exitCode = 1
})
