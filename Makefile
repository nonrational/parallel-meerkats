clean:
	rm -rf artifacts/*
	rm -rf cache/*

local-node:
	pnpm exec hardhat node

local-deploy:
	pnpm exec hardhat run --network localhost scripts/deploy.js

local-run:
	source .env && pnpm exec hardhat run --network localhost scripts/deployAndMint.js

goerli-deploy:
	source .env && pnpm exec hardhat run --network goerli scripts/deploy.js

goerli-mint:
	source .env && pnpm exec hardhat run --network goerli scripts/mint.js

goerli-verify:
	source .env && npx hardhat verify --network goerli $$GOERLI_ADDRESS

burn:
	source .env && pnpm exec hardhat run --network goerli scripts/burn.js



