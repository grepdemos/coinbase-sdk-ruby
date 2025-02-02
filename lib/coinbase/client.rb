=begin
#Coinbase Platform API

#This is the OpenAPI 3.0 specification for the Coinbase Platform APIs, used in conjunction with the Coinbase Platform SDKs.

The version of the OpenAPI document: 0.0.1-alpha

Generated by: https://openapi-generator.tech
Generator version: 7.8.0

=end

# Common files
require 'coinbase/client/api_client'
require 'coinbase/client/api_error'
require 'coinbase/client/version'
require 'coinbase/client/configuration'

# Models
Coinbase::Client.autoload :Address, 'coinbase/client/models/address'
Coinbase::Client.autoload :AddressBalanceList, 'coinbase/client/models/address_balance_list'
Coinbase::Client.autoload :AddressHistoricalBalanceList, 'coinbase/client/models/address_historical_balance_list'
Coinbase::Client.autoload :AddressList, 'coinbase/client/models/address_list'
Coinbase::Client.autoload :AddressTransactionList, 'coinbase/client/models/address_transaction_list'
Coinbase::Client.autoload :Asset, 'coinbase/client/models/asset'
Coinbase::Client.autoload :Balance, 'coinbase/client/models/balance'
Coinbase::Client.autoload :BroadcastContractInvocationRequest, 'coinbase/client/models/broadcast_contract_invocation_request'
Coinbase::Client.autoload :BroadcastStakingOperationRequest, 'coinbase/client/models/broadcast_staking_operation_request'
Coinbase::Client.autoload :BroadcastTradeRequest, 'coinbase/client/models/broadcast_trade_request'
Coinbase::Client.autoload :BroadcastTransferRequest, 'coinbase/client/models/broadcast_transfer_request'
Coinbase::Client.autoload :BuildStakingOperationRequest, 'coinbase/client/models/build_staking_operation_request'
Coinbase::Client.autoload :ContractEvent, 'coinbase/client/models/contract_event'
Coinbase::Client.autoload :ContractEventList, 'coinbase/client/models/contract_event_list'
Coinbase::Client.autoload :ContractInvocation, 'coinbase/client/models/contract_invocation'
Coinbase::Client.autoload :ContractInvocationList, 'coinbase/client/models/contract_invocation_list'
Coinbase::Client.autoload :CreateAddressRequest, 'coinbase/client/models/create_address_request'
Coinbase::Client.autoload :CreateContractInvocationRequest, 'coinbase/client/models/create_contract_invocation_request'
Coinbase::Client.autoload :CreatePayloadSignatureRequest, 'coinbase/client/models/create_payload_signature_request'
Coinbase::Client.autoload :CreateServerSignerRequest, 'coinbase/client/models/create_server_signer_request'
Coinbase::Client.autoload :CreateStakingOperationRequest, 'coinbase/client/models/create_staking_operation_request'
Coinbase::Client.autoload :CreateTradeRequest, 'coinbase/client/models/create_trade_request'
Coinbase::Client.autoload :CreateTransferRequest, 'coinbase/client/models/create_transfer_request'
Coinbase::Client.autoload :CreateWalletRequest, 'coinbase/client/models/create_wallet_request'
Coinbase::Client.autoload :CreateWalletRequestWallet, 'coinbase/client/models/create_wallet_request_wallet'
Coinbase::Client.autoload :CreateWebhookRequest, 'coinbase/client/models/create_webhook_request'
Coinbase::Client.autoload :ERC20TransferEvent, 'coinbase/client/models/erc20_transfer_event'
Coinbase::Client.autoload :ERC721TransferEvent, 'coinbase/client/models/erc721_transfer_event'
Coinbase::Client.autoload :Error, 'coinbase/client/models/error'
Coinbase::Client.autoload :EthereumTransaction, 'coinbase/client/models/ethereum_transaction'
Coinbase::Client.autoload :EthereumTransactionAccess, 'coinbase/client/models/ethereum_transaction_access'
Coinbase::Client.autoload :EthereumTransactionAccessList, 'coinbase/client/models/ethereum_transaction_access_list'
Coinbase::Client.autoload :EthereumTransactionFlattenedTrace, 'coinbase/client/models/ethereum_transaction_flattened_trace'
Coinbase::Client.autoload :EthereumValidatorMetadata, 'coinbase/client/models/ethereum_validator_metadata'
Coinbase::Client.autoload :FaucetTransaction, 'coinbase/client/models/faucet_transaction'
Coinbase::Client.autoload :FeatureSet, 'coinbase/client/models/feature_set'
Coinbase::Client.autoload :FetchHistoricalStakingBalances200Response, 'coinbase/client/models/fetch_historical_staking_balances200_response'
Coinbase::Client.autoload :FetchStakingRewards200Response, 'coinbase/client/models/fetch_staking_rewards200_response'
Coinbase::Client.autoload :FetchStakingRewardsRequest, 'coinbase/client/models/fetch_staking_rewards_request'
Coinbase::Client.autoload :GetStakingContextRequest, 'coinbase/client/models/get_staking_context_request'
Coinbase::Client.autoload :HistoricalBalance, 'coinbase/client/models/historical_balance'
Coinbase::Client.autoload :Network, 'coinbase/client/models/network'
Coinbase::Client.autoload :NetworkIdentifier, 'coinbase/client/models/network_identifier'
Coinbase::Client.autoload :PayloadSignature, 'coinbase/client/models/payload_signature'
Coinbase::Client.autoload :PayloadSignatureList, 'coinbase/client/models/payload_signature_list'
Coinbase::Client.autoload :SeedCreationEvent, 'coinbase/client/models/seed_creation_event'
Coinbase::Client.autoload :SeedCreationEventResult, 'coinbase/client/models/seed_creation_event_result'
Coinbase::Client.autoload :ServerSigner, 'coinbase/client/models/server_signer'
Coinbase::Client.autoload :ServerSignerEvent, 'coinbase/client/models/server_signer_event'
Coinbase::Client.autoload :ServerSignerEventEvent, 'coinbase/client/models/server_signer_event_event'
Coinbase::Client.autoload :ServerSignerEventList, 'coinbase/client/models/server_signer_event_list'
Coinbase::Client.autoload :ServerSignerList, 'coinbase/client/models/server_signer_list'
Coinbase::Client.autoload :SignatureCreationEvent, 'coinbase/client/models/signature_creation_event'
Coinbase::Client.autoload :SignatureCreationEventResult, 'coinbase/client/models/signature_creation_event_result'
Coinbase::Client.autoload :SignedVoluntaryExitMessageMetadata, 'coinbase/client/models/signed_voluntary_exit_message_metadata'
Coinbase::Client.autoload :SponsoredSend, 'coinbase/client/models/sponsored_send'
Coinbase::Client.autoload :StakingBalance, 'coinbase/client/models/staking_balance'
Coinbase::Client.autoload :StakingContext, 'coinbase/client/models/staking_context'
Coinbase::Client.autoload :StakingContextContext, 'coinbase/client/models/staking_context_context'
Coinbase::Client.autoload :StakingOperation, 'coinbase/client/models/staking_operation'
Coinbase::Client.autoload :StakingOperationMetadata, 'coinbase/client/models/staking_operation_metadata'
Coinbase::Client.autoload :StakingReward, 'coinbase/client/models/staking_reward'
Coinbase::Client.autoload :StakingRewardFormat, 'coinbase/client/models/staking_reward_format'
Coinbase::Client.autoload :StakingRewardUSDValue, 'coinbase/client/models/staking_reward_usd_value'
Coinbase::Client.autoload :Trade, 'coinbase/client/models/trade'
Coinbase::Client.autoload :TradeList, 'coinbase/client/models/trade_list'
Coinbase::Client.autoload :Transaction, 'coinbase/client/models/transaction'
Coinbase::Client.autoload :TransactionContent, 'coinbase/client/models/transaction_content'
Coinbase::Client.autoload :TransactionType, 'coinbase/client/models/transaction_type'
Coinbase::Client.autoload :Transfer, 'coinbase/client/models/transfer'
Coinbase::Client.autoload :TransferList, 'coinbase/client/models/transfer_list'
Coinbase::Client.autoload :UpdateWebhookRequest, 'coinbase/client/models/update_webhook_request'
Coinbase::Client.autoload :Validator, 'coinbase/client/models/validator'
Coinbase::Client.autoload :ValidatorDetails, 'coinbase/client/models/validator_details'
Coinbase::Client.autoload :ValidatorList, 'coinbase/client/models/validator_list'
Coinbase::Client.autoload :ValidatorStatus, 'coinbase/client/models/validator_status'
Coinbase::Client.autoload :Wallet, 'coinbase/client/models/wallet'
Coinbase::Client.autoload :WalletList, 'coinbase/client/models/wallet_list'
Coinbase::Client.autoload :Webhook, 'coinbase/client/models/webhook'
Coinbase::Client.autoload :WebhookEventFilter, 'coinbase/client/models/webhook_event_filter'
Coinbase::Client.autoload :WebhookEventType, 'coinbase/client/models/webhook_event_type'
Coinbase::Client.autoload :WebhookList, 'coinbase/client/models/webhook_list'

# APIs
Coinbase::Client.autoload :AddressesApi, 'coinbase/client/api/addresses_api'
Coinbase::Client.autoload :AssetsApi, 'coinbase/client/api/assets_api'
Coinbase::Client.autoload :BalanceHistoryApi, 'coinbase/client/api/balance_history_api'
Coinbase::Client.autoload :ContractEventsApi, 'coinbase/client/api/contract_events_api'
Coinbase::Client.autoload :ContractInvocationsApi, 'coinbase/client/api/contract_invocations_api'
Coinbase::Client.autoload :ExternalAddressesApi, 'coinbase/client/api/external_addresses_api'
Coinbase::Client.autoload :NetworksApi, 'coinbase/client/api/networks_api'
Coinbase::Client.autoload :ServerSignersApi, 'coinbase/client/api/server_signers_api'
Coinbase::Client.autoload :StakeApi, 'coinbase/client/api/stake_api'
Coinbase::Client.autoload :TradesApi, 'coinbase/client/api/trades_api'
Coinbase::Client.autoload :TransfersApi, 'coinbase/client/api/transfers_api'
Coinbase::Client.autoload :ValidatorsApi, 'coinbase/client/api/validators_api'
Coinbase::Client.autoload :WalletStakeApi, 'coinbase/client/api/wallet_stake_api'
Coinbase::Client.autoload :WalletsApi, 'coinbase/client/api/wallets_api'
Coinbase::Client.autoload :WebhooksApi, 'coinbase/client/api/webhooks_api'

module Coinbase::Client
  class << self
    # Customize default settings for the SDK using block.
    #   Coinbase::Client.configure do |config|
    #     config.username = "xxx"
    #     config.password = "xxx"
    #   end
    # If no block given, return the default Configuration object.
    def configure
      if block_given?
        yield(Configuration.default)
      else
        Configuration.default
      end
    end
  end
end
