# frozen_string_literal: true

require_relative 'coinbase/address'
require_relative 'coinbase/address/wallet_address'
require_relative 'coinbase/address/external_address'
require_relative 'coinbase/asset'
require_relative 'coinbase/authenticator'
require_relative 'coinbase/correlation'
require_relative 'coinbase/balance'
require_relative 'coinbase/balance_map'
require_relative 'coinbase/historical_balance'
require_relative 'coinbase/client'
require_relative 'coinbase/constants'
require_relative 'coinbase/contract_event'
require_relative 'coinbase/destination'
require_relative 'coinbase/errors'
require_relative 'coinbase/faucet_transaction'
require_relative 'coinbase/middleware'
require_relative 'coinbase/network'
require_relative 'coinbase/pagination'
require_relative 'coinbase/trade'
require_relative 'coinbase/transfer'
require_relative 'coinbase/transaction'
require_relative 'coinbase/wallet'
require_relative 'coinbase/server_signer'
require_relative 'coinbase/smart_contract'
require_relative 'coinbase/sponsored_send'
require_relative 'coinbase/staking_balance'
require_relative 'coinbase/staking_operation'
require_relative 'coinbase/staking_reward'
require_relative 'coinbase/validator'
require_relative 'coinbase/version'
require_relative 'coinbase/webhook'
require 'json'

# The Coinbase SDK.
module Coinbase
  class InvalidConfiguration < StandardError; end

  class << self
    # Returns the configuration object.
    # @return [Configuration] the configuration object
    def configuration
      @configuration ||= Configuration.new
    end

    # Configures the Coinbase SDK.
    # @return [String] A string indicating successful configuration
    def configure
      yield(configuration)

      raise InvalidConfiguration, 'API key private key is not set' unless configuration.api_key_private_key
      raise InvalidConfiguration, 'API key name is not set' unless configuration.api_key_name

      'Successfully configured Coinbase SDK'
    end

    # Configures the Coinbase SDK from the given CDP API Key JSON file.
    # @param file_path [String] (Optional) the path to the CDP API Key JSON file
    # file in the root directory by default.
    # @return [String] A string indicating successful configuration
    def configure_from_json(file_path = 'cdp_api_key.json')
      configuration.from_json(file_path)

      raise InvalidConfiguration, 'API key private key is not set' unless configuration.api_key_private_key
      raise InvalidConfiguration, 'API key name is not set' unless configuration.api_key_name

      'Successfully configured Coinbase SDK'
    end

    # Converts a string to a symbol, replacing hyphens with underscores.
    # @param string [String] the string to convert
    # @return [Symbol] the converted symbol
    def to_sym(value)
      value.to_s.gsub('-', '_').to_sym
    end

    # Converts a Network object or network symbol with the string representation of the network ID,
    # replacing underscores with hyphens.
    # @param network_sym [Coinbase::Network, Symbol] The network or network symbol to convert
    # @return [String] The string representation of the network ID
    def normalize_network(network)
      network_sym = network.is_a?(Coinbase::Network) ? network.id : network

      network_sym.to_s.gsub('_', '-')
    end

    # Wraps a call to the Platform API to ensure that the error is caught and
    # wrapped as an APIError.
    def call_api
      yield
    rescue Coinbase::Client::ApiError => e
      raise Coinbase::APIError.from_error(e), cause: nil
    end

    # Returns a pretty-printed object string that contains the object's class name and
    # the details of the object, filtering out nil values.
    # @param klass [Class] the class of the object
    # @param details [Hash] the details of the object
    # @return [String] the pretty-printed object string
    def pretty_print_object(klass, **details)
      filtered_details = details.filter { |_, v| !v.nil? }.map { |k, v| "#{k}: '#{v}'" }

      "#{klass}{#{filtered_details.join(', ')}}"
    end

    # Returns whether to use a server signer to manage private keys.
    # @return [bool] whether to use a server signer to manage private keys.
    def use_server_signer?
      Coinbase.configuration.use_server_signer
    end

    # Returns the default network.
    # @return [Coinbase::Network] the default network
    def default_network
      Coinbase.configuration.default_network
    end

    # Returns whether the SDK is configured.
    # @return [bool] whether the SDK is configured
    def configured?
      !Coinbase.configuration.api_key_name.nil? && !Coinbase.configuration.api_key_private_key.nil?
    end
  end

  # Configuration object for the Coinbase SDK.
  class Configuration
    attr_accessor :api_url, :api_key_name, :api_key_private_key, :debug_api, :use_server_signer, :max_network_tries

    # Initializes the configuration object.
    def initialize
      @api_url = 'https://api.cdp.coinbase.com'
      @debug_api = false
      @use_server_signer = false
      @max_network_tries = 3
      @default_network = Coinbase::Network::BASE_SEPOLIA
    end

    attr_reader :default_network

    def default_network=(network)
      unless network.is_a?(Coinbase::Network)
        raise InvalidConfiguration, 'Default network must use a network constant, e.g. Coinbase::Network::BASE_MAINNET'
      end

      @default_network = network
    end

    # Sets configuration values based on the provided CDP API Key JSON file.
    # @param file_path [String] (Optional) the path to the CDP API Key JSON file
    # file in the root directory by default.
    def from_json(file_path = 'cdp_api_key.json')
      # Expand paths to respect shortcuts like ~.
      file_path = File.expand_path(file_path)

      raise InvalidConfiguration, 'Invalid configuration file type' unless file_path.end_with?('.json')

      file = File.read(file_path)
      data = JSON.parse(file)
      @api_key_name = data['name']
      @api_key_private_key = data['privateKey']
    end

    # Returns the API client.
    # @return [Coinbase::Client::ApiClient] the API client
    def api_client
      @api_client ||= Coinbase::Client::ApiClient.new(Middleware.config)
    end
  end
end

# Initialize the Network constants.
Coinbase::Network.const_set(
  'ALL',
  Coinbase::Client::NetworkIdentifier.all_vars.each_with_object([]) do |id, list|
    next if id == Coinbase::Client::NetworkIdentifier::UNKNOWN_DEFAULT_OPEN_API

    network = Coinbase::Network.new(id)

    Coinbase::Network.const_set(id.upcase.gsub('-', '_'), network)

    list << network
  end
)

Coinbase::Network.const_set(
  'NETWORK_MAP',
  Coinbase::Network::ALL.each_with_object({}) do |network, map|
    map[network.id] = network
  end
)
