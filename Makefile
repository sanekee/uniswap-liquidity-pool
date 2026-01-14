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
		--rpc-url http://localhost:8545 \
		--broadcast \
		--sender 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 \
		--account test-wallet

deploy-hook:
	forge script script/00_DeployHook.s.sol \
		--rpc-url http://localhost:8545 \
		--broadcast \
		--sender 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 \
		--account test-wallet
