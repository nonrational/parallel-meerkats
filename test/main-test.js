const { expect } = require('chai')
const { ethers } = require('hardhat')

const deployContract = async function () {
  const ParallelMeerkatManorHouse = await ethers.getContractFactory('ParallelMeerkatManorHouse')
  const pmmh = await ParallelMeerkatManorHouse.deploy()
  await pmmh.deployed()
  return pmmh
}

describe('mintMeerkat', function () {
  it('should work', async function () {
    const pmmh = await deployContract()

    // mint a token
    const [owner, reciever] = await ethers.getSigners()
    const mintTx = await pmmh.mintMeerkat(reciever.address)
    await mintTx.wait()

    // owner should have no meerkats
    expect(await pmmh.balanceOf(owner.address)).to.equal(0)

    // reciver should have one meerkats
    expect(await pmmh.balanceOf(reciever.address)).to.equal(1)

    // fetch the first tokId of the receiver
    const tokenId = await pmmh.tokenOfOwnerByIndex(reciever.address, 0)
    const now = Math.round(new Date().getTime() / 1000)

    // check that we minted this token recently
    expect(await pmmh.mintedAt(tokenId)).to.be.within(now - 15, now)

    // verify that the metadata uri is expected
    expect(await pmmh.tokenURI(tokenId)).to.equal('https://parallelmeerkats.com/m/1.json')
  })
})
