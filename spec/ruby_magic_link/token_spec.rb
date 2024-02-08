# frozen_string_literal: true

RSpec.describe RubyMagicLink::Token do
  let(:payload) do
    {
      'key' => 'value'
    }
  end
  let(:token) { 'SjRNTzRUc3dmMTQ4RFAtRXF4LXV1QT09fG5A3gvd4CNcy8ZTb7Gcy1ykSIVJM2wvShvuxF8yg8Zx' }

  before do
    config_stub = instance_double(RubyMagicLink::Configuration)
    allow(RubyMagicLink).to receive(:config).and_return(config_stub)
    allow(config_stub).to receive(:secret_key).and_return('12345678123456781234567812345678')
  end

  describe '.create' do
    let(:vector) { "'\x83\x0E\xE1;0\x7F^<\f\xFF\x84\xAB\x1F\xAE\xB8" }

    before { allow(OpenSSL::Random).to receive(:random_bytes).with(16).and_return(vector) }

    it { expect(described_class.create(payload)).to eq token }
  end

  describe '.decode' do
    let(:token) { described_class.create(payload, expires_in: 100) }

    before do
      vector = "'\x83\x0E\xE1;0\x7F^<\f\xFF\x84\xAB\x1F\xAE\xB8"
      allow(OpenSSL::Random).to receive(:random_bytes).with(16).and_return(vector)
    end

    it 'decodes token' do
      token_object = described_class.decode(token)
      expect(token_object).not_to be_expired
      expect(token_object.payload).to eq payload
    end

    context 'with expired token' do
      let(:token) { described_class.create(payload, expires_in: expires_in) }
      let(:expires_in) { 10000 }

      it 'decodes token' do
        token_object = described_class.decode(token)
        expect(token_object).not_to be_expired
        Timecop.travel(Time.now + expires_in + 1) do
          expect(token_object).to be_expired
        end
      end
    end
  end
end