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

deploy-uniswap-v4:
	forge script script/testing/00_DeployV4.s.sol \
		--rpc-url ${RPC_URL} \
		--broadcast \
		--sender ${TEST_ADDRESS_0} \
		--account test-wallet-0 \
		--password ""

deploy-tokens:
	forge script script/00_DeployTestToken.s.sol \
		--rpc-url ${RPC_URL} \
		--broadcast \
		--sender ${TEST_ADDRESS_0} \
		--account test-wallet-0 \
		--password ""

deploy-hook:
	forge script script/00_DeployHook.s.sol \
		--rpc-url ${RPC_URL} \
		--broadcast \
		--sender ${TEST_ADDRESS_0} \
		--account test-wallet-0 \
		--password ""

create-pool:
	forge script script/01_CreatePoolAndAddLiquidity.s.sol \
		--rpc-url ${RPC_URL} \
		--broadcast \
		--sender ${TEST_ADDRESS_0} \
		--account test-wallet-0 \
		--password ""

add-liquidity:
	forge script script/02_AddLiquidity.s.sol \
		--rpc-url ${RPC_URL} \
		--broadcast \
		--sender ${TEST_ADDRESS_0} \
		--account test-wallet-0 \
		--password "" \
		-vvvv

fund-address1:
	forge script script/03_FundAddress1.s.sol \
		--rpc-url ${RPC_URL} \
		--broadcast \
		--sender ${TEST_ADDRESS_0} \
		--account test-wallet-0 \
		--password "" \
		-vvvv
swap:
	forge script script/03_Swap.s.sol \
		--rpc-url ${RPC_URL} \
		--broadcast \
		--skip-simulation \
		--sender ${TEST_ADDRESS_1} \
		--account test-wallet-1 \
		--password "" \
		-vvvv
