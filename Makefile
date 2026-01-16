# Makefile for Uniswap v4 Development

.PHONY: all build test clean anvil deploy-v4 deploy-hook

all: build

install:
	forge install

build:
	forge build

test:
	forge test

clean:
	forge clean

anvil:
	anvil

deploy-v4:
	forge script script/testing/00_DeployV4.s.sol \
		--rpc-url ${RPC_URL} \
		--broadcast \
		--sender ${TEST_ADDRESS_0} \
		--account test-wallet-0

deploy-hook:
	forge script script/00_DeployHook.s.sol \
		--rpc-url ${RPC_URL} \
		--broadcast \
		--sender ${TEST_ADDRESS_0} \
		--account test-wallet-0


create-pool:
	forge script script/01_CreatePoolAndAddLiquidity.s.sol \
		--rpc-url ${RPC_URL} \
		--broadcast \
		--sender ${TEST_ADDRESS_0} \
		--account test-wallet-0
