test:
	pnpm test

compile: clean
	pnpm exec hardhat compile

clean:
	rm -rf artifacts/*
	rm -rf cache/*

local-node:
	source .local.env && pnpm exec hardhat node

local-deploy:
	source .local.env && pnpm exec hardhat run --network localhost scripts/deploy.js

local-upgrade:
	source .local.env && pnpm exec hardhat run --network localhost scripts/upgrade.js

local-mint:
	source .local.env && pnpm exec hardhat run --network localhost scripts/mint.js

goerli-deploy:
	source .goerli.env && pnpm exec hardhat run --network goerli scripts/deploy.js

goerli-mint:
	source .goerli.env && pnpm exec hardhat run --network goerli scripts/mint.js

goerli-verify:
	source .goerli.env && npx hardhat verify --network goerli $$GOERLI_ADDRESS


.PHONY: test compile clean local-node local-run local-deploy goerli-deploy goerli-mint goerli-verify
