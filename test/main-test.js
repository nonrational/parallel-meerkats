const { expect } = require('chai')
const { ethers } = require('hardhat')

const deployContract = async function () {
  const ParallelMeerkatManorHouse = await ethers.getContractFactory('ParallelMeerkatManorHouse')
  const pmmh = await ParallelMeerkatManorHouse.deploy()
  await pmmh.deployed()
  return pmmh
}

describe('mintMany', function () {
  it('should allow minting multiple tokens', async function () {
    const pmmh = await deployContract()

    // mint 3 tokens in a single transaction
    const [owner] = await ethers.getSigners()
    const mintTx = await pmmh.mintMany(3)
    await mintTx.wait()

    // owner should have two meerkats
    expect(await pmmh.balanceOf(owner.address)).to.equal(3)

    // fetch the first tokenId of the receiver
    const [tok1, tok2, tok3] = await pmmh.tokensOfOwner(owner.address)

    expect(await pmmh.tokenURI(tok1)).to.equal(`https://parallelmeerkats.com/data/0.json`)
    expect(await pmmh.tokenURI(tok2)).to.equal(`https://parallelmeerkats.com/data/1.json`)
    expect(await pmmh.tokenURI(tok3)).to.equal(`https://parallelmeerkats.com/data/2.json`)
  })
})
