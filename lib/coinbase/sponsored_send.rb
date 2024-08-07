# frozen_string_literal: true

require_relative 'constants'
require 'bigdecimal'
require 'eth'
require 'json'

module Coinbase
  # A representation of an onchain Sponsored Send.
  # Sponsored Sends should be constructed via higher level abstractions like Transfer.
  class SponsoredSend
    # A representation of a SponsoredSend status.
    module Status
      # The SponsoredSend is awaiting being broadcast to the Network.
      # At this point, transaction hashes may not yet be assigned.
      PENDING = 'pending'

      # The SponsoredSend has been signed, but has not been successfully broadcast yet.
      SIGNED = 'signed'

      # The SponsoredSend has been broadcast to the Network.
      # At this point, at least the transaction hash should be assigned.
      BROADCAST = 'broadcast'

      # The SponsoredSend is complete and has confirmed on the Network.
      COMPLETE = 'complete'

      # The SponsoredSend has failed for some reason.
      FAILED = 'failed'

      # The states that are considered terminal on-chain.
      TERMINAL_STATES = [COMPLETE, FAILED].freeze
    end

    # Returns a new SponsoredSend object. Do not use this method directly.
    # @param model [Coinbase::Client::SponsoredSend] The underlying SponsoredSend object
    def initialize(model)
      raise unless model.is_a?(Coinbase::Client::SponsoredSend)

      @model = model
    end

    # Returns the Transaction Hash of the Transaction.
    # @return [String] The Transaction Hash
    def transaction_hash
      @model.transaction_hash
    end

    # Returns the status of the Transaction.
    # @return [Symbol] The status
    def status
      @model.status
    end

    # Returns the from address for the Transaction.
    # @return [String] The from address
    def from_address_id
      @model.from_address_id
    end

    # Returns whether the Transaction is in a terminal state.
    # @return [Boolean] Whether the Transaction is in a terminal state
    def terminal_state?
      Status::TERMINAL_STATES.include?(status)
    end

    # Returns the link to the transaction on the blockchain explorer.
    # @return [String] The link to the transaction on the blockchain explorer
    def transaction_link
      @model.transaction_link
    end

    def raw_typed_data
      @model.raw_typed_Data
    end

    def typed_data_hash
      @model.typed_data_hash
    end
    
    def signature
      @signature ||= @model.signature
    end

    # Signs the Transaction with the provided key and returns the hex signing payload.
    # @return [String] The hex-encoded signed payload
    def sign(key)
      raise unless key.is_a?(Eth::Key)
      raise if signed?

      @signature = Eth::Util.prefix_hex(key.sign(Eth::Util.hex_to_bin(typed_data_hash)))
    end

    # Returns whether the Transaction has been signed.
    # @return [Boolean] Whether the Transaction has been signed
    def signed?
      !@signature.nil?
    end

    # Returns a String representation of the SponsoredSend.
    # @return [String] a String representation of the SponsoredSend
    def to_s
      "Coinbase::SponsoredSend{transaction_hash: '#{transaction_hash}', status: '#{status}'}"
    end

    # Same as to_s.
    # @return [String] a String representation of the SponsoredSend
    def inspect
      to_s
    end
  end
end
