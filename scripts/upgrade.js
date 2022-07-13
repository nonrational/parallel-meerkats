// scripts/upgrade.js
const { ethers, upgrades } = require('hardhat')
const fs = require('fs')

async function main() {
  if (!fs.existsSync(process.env.DEPLOY_ADDRESSES_PATH)) {
    throw `Missing ${process.env.DEPLOY_ADDRESSES_PATH}`
  }

  const deployment = JSON.parse(fs.readFileSync(process.env.DEPLOY_ADDRESSES_PATH))

  const ParallelMeerkatManorHouse = await ethers.getContractFactory('ParallelMeerkatManorHouse')
  const upgrade = await upgrades.upgradeProxy(deployment.proxy, ParallelMeerkatManorHouse)

  console.log('Upgrading...')
  await upgrade.deployed()

  const addresses = {
    proxy: upgrade.address,
    admin: await upgrades.erc1967.getAdminAddress(upgrade.address),
    implementation: await upgrades.erc1967.getImplementationAddress(upgrade.address),
  }
  console.log('Addresses:', addresses)

  fs.writeFileSync(process.env.DEPLOY_ADDRESSES_PATH, JSON.stringify(addresses))
}

main().catch((error) => {
  console.error(error)
  process.exitCode = 1
})
