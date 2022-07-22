test:
	pnpm test

compile: clean
	pnpm exec hardhat compile

clean:
	rm -rf artifacts/*
	rm -rf cache/*

export-data-json:
	node --experimental-fetch scripts/export-data-json.js

#  _                 _
# | | ___   ___ __ _| |
# | |/ _ \ / __/ _` | |
# | | (_) | (_| (_| | |
# |_|\___/ \___\__,_|_|
#

local-node:
	source .local.env && pnpm exec hardhat node

local-deploy:
	source .local.env && pnpm exec hardhat run --network localhost scripts/deploy.js

local-upgrade:
	source .local.env && pnpm exec hardhat run --network localhost scripts/upgrade.js

local-mint:
	source .local.env && pnpm exec hardhat run --network localhost scripts/mint.js

#                        _ _
#   __ _  ___   ___ _ __| (_)
#  / _` |/ _ \ / _ \ '__| | |
# | (_| | (_) |  __/ |  | | |
#  \__, |\___/ \___|_|  |_|_|
#  |___/

goerli-deploy:
	source .goerli.env && pnpm exec hardhat run --network goerli scripts/deploy.js

goerli-upgrade:
	source .goerli.env && pnpm exec hardhat run --network goerli scripts/upgrade.js

goerli-verify:
	source .goerli.env && pnpm exec hardhat run --network goerli scripts/verify.js

goerli-mint:
	source .goerli.env && pnpm exec hardhat run --network goerli scripts/mint.js

#       _       _        _
#  _ __(_)_ __ | | _____| |__  _   _
# | '__| | '_ \| |/ / _ \ '_ \| | | |
# | |  | | | | |   <  __/ |_) | |_| |
# |_|  |_|_| |_|_|\_\___|_.__/ \__, |
#                              |___/

rinkeby-deploy:
	source .rinkeby.env && pnpm exec hardhat run --network rinkeby scripts/deploy.js

rinkeby-upgrade:
	source .rinkeby.env && pnpm exec hardhat run --network rinkeby scripts/upgrade.js

rinkeby-verify:
	source .rinkeby.env && pnpm exec hardhat run --network rinkeby scripts/verify.js

rinkeby-mint:
	source .rinkeby.env && pnpm exec hardhat run --network rinkeby scripts/mint.js

rinkeby-gift:
	source .rinkeby.env && pnpm exec hardhat run --network rinkeby scripts/gift.js

#                  _                  _
#  _ __ ___   __ _(_)_ __  _ __   ___| |_
# | '_ ` _ \ / _` | | '_ \| '_ \ / _ \ __|
# | | | | | | (_| | | | | | | | |  __/ |_
# |_| |_| |_|\__,_|_|_| |_|_| |_|\___|\__|
#

mainnet-deploy:
	source .mainnet.env && pnpm exec hardhat run --network mainnet scripts/deploy.js

mainnet-upgrade:
	source .mainnet.env && pnpm exec hardhat run --network mainnet scripts/upgrade.js

mainnet-verify:
	source .mainnet.env && pnpm exec hardhat run --network mainnet scripts/verify.js

mainnet-mint:
	source .mainnet.env && pnpm exec hardhat run --network mainnet scripts/mint.js


# echo ".PHONY: $(egrep -o '^([a-z-]*):' Makefile | tr -d ':' | xargs echo)" | pbcopy
.PHONY: test compile clean export-data-json local-node local-deploy local-upgrade local-mint goerli-deploy goerli-upgrade goerli-verify goerli-mint rinkeby-deploy rinkeby-upgrade rinkeby-verify rinkeby-mint mainnet-deploy mainnet-upgrade mainnet-verify mainnet-mint




