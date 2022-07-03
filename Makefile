local-node:
	pnpm exec hardhat node

local-deploy:
	pnpm exec hardhat run --network localhost scripts/deploy.js

local-run:
	source .env && pnpm exec hardhat run --network localhost scripts/deployAndMint.js

deploy-testnet:
	source .env && pnpm exec hardhat run --network goerli scripts/deploy.js

mint-meerkat:
	source .env && pnpm exec hardhat run --network goerli scripts/mint.js

burn:
	source .env && pnpm exec hardhat run --network goerli scripts/burn.js

verify-testnet:
	source .env && npx hardhat verify --network goerli 0xEBe73A43Fd83A685B27893e444FC3eF3dE7c290D

