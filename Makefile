deploy-testnet:
	source .env && pnpm exec hardhat run --network rinkeby scripts/deploy.js

mint-meerkat:
	source .env && pnpm exec hardhat run --network rinkeby scripts/mint.js

verify-testnet:
	source .env && npx hardhat verify --network rinkeby 0xEBe73A43Fd83A685B27893e444FC3eF3dE7c290D
