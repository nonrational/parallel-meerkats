clean:
	rm -rf artifacts/*
	rm -rf cache/*

local-node:
	source .local.env && pnpm exec hardhat node

local-run:
	source .local.env && pnpm exec hardhat run --network localhost scripts/deployAndMint.js

goerli-deploy:
	source .goerli.env && pnpm exec hardhat run --network goerli scripts/deploy.js

goerli-mint:
	source .goerli.env && pnpm exec hardhat run --network goerli scripts/mint.js

goerli-verify:
	source .goerli.env && npx hardhat verify --network goerli $$GOERLI_ADDRESS


