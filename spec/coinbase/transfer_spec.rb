# frozen_string_literal: true

describe Coinbase::Transfer do
  let(:from_key) { Eth::Key.new }
  let(:to_key) { Eth::Key.new }
  let(:network_id) { :base_sepolia }
  let(:wallet_id) { SecureRandom.uuid }
  let(:from_address_id) { from_key.address.to_s }
  let(:amount) { 500_000_000_000_000_000 }
  let(:to_address_id) { to_key.address.to_s }
  let(:client) { double('Jimson::Client') }

  subject(:transfer) do
    described_class.new(network_id, wallet_id, from_address_id, amount, :eth, to_address_id, client: client)
  end

  describe '#initialize' do
    it 'initializes a new Transfer' do
      expect(transfer).to be_a(Coinbase::Transfer)
    end

    it 'does not initialize a new transfer for an invalid asset' do
      expect do
        Coinbase::Transfer.new(network_id, wallet_id, from_address_id, amount, :uni, to_address_id, client: client)
      end.to raise_error(ArgumentError, 'Unsupported asset: uni')
    end
  end

  describe '#network_id' do
    it 'returns the network ID' do
      expect(transfer.network_id).to eq(network_id)
    end
  end

  describe '#wallet_id' do
    it 'returns the wallet ID' do
      expect(transfer.wallet_id).to eq(wallet_id)
    end
  end

  describe '#from_address_id' do
    it 'returns the source address ID' do
      expect(transfer.from_address_id).to eq(from_address_id)
    end
  end

  describe '#amount' do
    it 'returns the amount' do
      expect(transfer.amount).to eq(amount)
    end

    context 'when the amount is a float' do
      let(:float_amount) { 0.5 }
      let(:float_transfer) do
        described_class.new(network_id, wallet_id, from_address_id, float_amount, :eth, to_address_id, client: client)
      end

      it 'normalizes the amount' do
        expect(float_transfer.amount).to eq(500_000_000_000_000_000)
      end
    end

    context 'when the amount is a BigDecimal' do
      let(:big_decimal_amount) { BigDecimal('0.5') }
      let(:big_decimal_transfer) do
        described_class.new(network_id, wallet_id, from_address_id, big_decimal_amount, :eth, to_address_id,
                            client: client)
      end

      it 'normalizes the amount' do
        expect(big_decimal_transfer.amount).to eq(500_000_000_000_000_000)
      end
    end
  end

  describe '#asset_id' do
    it 'returns the asset ID' do
      expect(transfer.asset_id).to eq(:eth)
    end
  end

  describe '#to_address_id' do
    it 'returns the destination address ID' do
      expect(transfer.to_address_id).to eq(to_address_id)
    end
  end

  describe '#status' do
    it 'returns the status' do
      expect(transfer.status).to eq(Coinbase::Transfer::Status::PENDING)
    end
  end

  describe '#transaction' do
    before do
      allow(client).to receive(:eth_getTransactionCount).with(from_address_id, 'latest').and_return('0x7')
      allow(client).to receive(:eth_gasPrice).and_return('0x7b')
    end

    it 'returns the Transfer transaction' do
      expect(transfer.transaction).to be_a(Eth::Tx::Eip1559)
      expect(transfer.transaction.amount).to eq(amount)
    end
  end

  describe '#transaction_hash' do
    before do
      allow(client).to receive(:eth_getTransactionCount).with(from_address_id, 'latest').and_return('0x7')
      allow(client).to receive(:eth_gasPrice).and_return('0x7b')
    end

    context 'when the transaction has been signed' do
      it 'returns the transaction hash' do
        transfer.transaction.sign(from_key)
        expect(transfer.transaction_hash).to eq(transfer.transaction.hash)
      end
    end

    context 'when the transaction has been created but not signed' do
      it 'returns nil' do
        transfer.transaction
        expect(transfer.transaction_hash).to be_nil
      end
    end

    context 'when thet transaction has not been created' do
      it 'returns nil' do
        expect(transfer.transaction_hash).to be_nil
      end
    end
  end
end
