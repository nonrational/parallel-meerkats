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

rinkeby-deploy:
	source .rinkeby.env && pnpm exec hardhat run --network rinkeby scripts/deploy.js

rinkeby-upgrade:
	source .rinkeby.env && pnpm exec hardhat run --network rinkeby scripts/upgrade.js

rinkeby-mint:
	source .rinkeby.env && pnpm exec hardhat run --network rinkeby scripts/mint.js



# echo ".PHONY: $(egrep -o '^([a-z-]*):' Makefile | tr -d ':' | xargs echo)"
.PHONY: test compile clean local-node local-deploy local-upgrade local-mint goerli-deploy goerli-mint goerli-verify

