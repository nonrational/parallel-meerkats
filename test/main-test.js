const { expect } = require('chai')
const { ethers } = require('hardhat')

const deploy = async function () {
  const ParallelMeerkatManorHouse = await ethers.getContractFactory('ParallelMeerkatManorHouse')
  const pmmh = await ParallelMeerkatManorHouse.deploy()
  await pmmh.deployed()
  return pmmh
}

describe('mintMeerkat', function () {
  it('should work', async function () {
    const pmmh = await deploy()

    // mint a token
    const [owner, rando] = await ethers.getSigners()
    const mintTx = await pmmh.mintMeerkat(rando.address)
    await mintTx.wait()

    // the owner should have nothing
    expect(await pmmh.balanceOf(owner.address)).to.equal(0)
    const tokenId = await pmmh.tokenOfOwnerByIndex(rando.address, 0)
    expect(await pmmh.balanceOf(rando.address)).to.equal(1)

    const now = Math.round(new Date().getTime() / 1000)
    expect(await pmmh.mintedAt(tokenId)).to.be.within(now - 15, now + 15)
    expect(await pmmh.tokenURI(tokenId)).to.equal('https://parallelmeerkats.com/m/1.json')
    expect(await pmmh.unexpired(tokenId)).to.be.true
  })
})
