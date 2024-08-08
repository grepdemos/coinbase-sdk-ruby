# frozen_string_literal: true

describe Coinbase::ServerSigner do
  subject(:server_signer) { described_class.new(model) }

  let(:server_signer_id) { SecureRandom.uuid }
  let(:wallets) { [SecureRandom.uuid, SecureRandom.uuid, SecureRandom.uuid] }
  let(:model) { Coinbase::Client::ServerSigner.new('server_signer_id' => server_signer_id, 'wallets' => wallets) }
  let(:server_signer_list_model) do
    Coinbase::Client::ServerSignerList.new(
      'data' => [model],
      'total_count' => 1
    )
  end
  let(:empty_server_signer_list_model) do
    Coinbase::Client::ServerSignerList.new(
      'data' => [],
      'total_count' => 0
    )
  end
  let(:server_signers_api) { double('Coinbase::Client::ServerSignersApi') }

  before do
    allow(Coinbase::Client::ServerSignersApi).to receive(:new).and_return(server_signers_api)
  end

  describe '.default' do
    before do
      allow(server_signers_api).to receive(:list_server_signers).and_return(server_signer_list_model)
    end

    context 'when a default Server-Signer exists' do
      it 'returns the default Server-Signer' do
        default_server_signer = described_class.default
        expect(default_server_signer.id).to eq(server_signer_id)
        expect(default_server_signer.wallets).to eq(wallets)
      end
    end

    context 'when a default Server-Signer does not exist' do
      before do
        allow(server_signers_api).to receive(:list_server_signers).and_return(empty_server_signer_list_model)
      end

      it 'throws an error' do
        expect { described_class.default }.to raise_error('No Server-Signer is associated with the project')
      end
    end
  end

  describe '#initialize' do
    it 'initializes a new Server-Signer' do
      expect(server_signer).to be_a(described_class)
    end
  end

  describe '#id' do
    it 'returns the Server-Signer ID' do
      expect(server_signer.id).to eq(server_signer_id)
    end
  end

  describe '#wallets' do
    it 'returns the wallets' do
      expect(server_signer.wallets).to eq(wallets)
    end
  end

  describe '#inspect' do
    it 'includes the Server-Signer ID' do
      expect(server_signer.inspect).to include(server_signer_id)
    end

    it 'includes wallets' do
      expect(server_signer.inspect).to include(wallets.join(', '))
    end

    it 'returns the same value as #to_s' do
      expect(server_signer.inspect).to eq(server_signer.to_s)
    end
  end
end
