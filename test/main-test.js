const { expect } = require('chai')
const { ethers, upgrades } = require('hardhat')

const deploy = async () => {
  const ParallelMeerkatManorHouse = await ethers.getContractFactory('ParallelMeerkatManorHouse')
  const proxy = await upgrades.deployProxy(ParallelMeerkatManorHouse, [], { initializer: 'initialize' })

  return await proxy.deployed()
}

describe('ownerMint', () => {
  it('should allow minting multiple tokens', async () => {
    const pmmh = await deploy()

    // mint 3 tokens in a single transaction

    const mintTx = await pmmh.ownerMint(3)
    await mintTx.wait()

    const [owner] = await ethers.getSigners()
    expect(await pmmh.balanceOf(owner.address)).to.equal(3)

    const [tok1, tok2, tok3] = await pmmh.tokensOfOwner(owner.address)

    expect(await pmmh.tokenURI(tok1)).to.equal(`https://parallelmeerkats.com/data/0.json`)
    expect(await pmmh.tokenURI(tok2)).to.equal(`https://parallelmeerkats.com/data/1.json`)
    expect(await pmmh.tokenURI(tok3)).to.equal(`https://parallelmeerkats.com/data/2.json`)
  })
})

describe('ownerGift', function () {
  it('should transfer tokens owned by the contract to a recipient', async () => {
    const pmmh = await deploy()
    const mintTx = await pmmh.ownerMint(3)
    await mintTx.wait()

    const [_, acct1, acct2] = await ethers.getSigners()

    // owner can gift
    await pmmh.ownerGift(acct1.address, 0)
    expect(await pmmh.ownerOf(0)).to.equal(acct1.address)

    // owner can't gift a token that someone else owns
    await expect(pmmh.ownerGift(acct2.address, 0)).to.be.reverted
  })
})
