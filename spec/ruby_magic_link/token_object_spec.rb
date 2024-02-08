# frozen_string_literal: true

require 'timecop'

RSpec.describe RubyMagicLink::TokenObject do
  let(:payload) { { 'key' => 'value' } }

  before do
    config_stub = instance_double(RubyMagicLink::Configuration)
    allow(RubyMagicLink).to receive(:config).and_return(config_stub)
    allow(config_stub).to receive(:secret_key).and_return('12345678123456781234567812345678')
  end

  describe '.valid?' do
    context 'with non-expiring token' do
      let(:token) { RubyMagicLink::Token.create(payload) }

      it 'creates valid token' do
        Timecop.travel(Time.local(30_000)) do
          token_object = described_class.new(token)
          expect(token_object).to be_valid
        end
      end
    end

    context 'with expired token' do
      let(:token) { RubyMagicLink::Token.create(payload, expires_in: expires_in) }
      let(:expires_in) { 10_000 }

      it 'expires after the specified time' do
        token_object = RubyMagicLink::Token.decode(token)
        Timecop.travel(Time.now + expires_in - 1) do
          expect(token_object).to be_valid
        end
        Timecop.travel(Time.now + expires_in + 1) do
          expect(token_object).not_to be_valid
        end
      end
    end
  end

  describe '.expired?' do
    context 'with non-expiring token' do
      let(:token) { RubyMagicLink::Token.create(payload) }

      it 'creates valid token' do
        Timecop.travel(Time.local(30_000)) do
          token_object = described_class.new(token)
          expect(token_object).not_to be_expired
        end
      end
    end

    context 'with expired token' do
      let(:token) { RubyMagicLink::Token.create(payload, expires_in: expires_in) }
      let(:expires_in) { 10_000 }

      it 'expires after the specified time' do
        token_object = RubyMagicLink::Token.decode(token)
        Timecop.travel(Time.now + expires_in - 1) do
          expect(token_object).not_to be_expired
        end
        Timecop.travel(Time.now + expires_in + 1) do
          expect(token_object).to be_expired
        end
      end
    end
  end

  describe '.payload' do
    let(:token) { RubyMagicLink::Token.create(payload) }

    it { expect(described_class.new(token).payload).to eq payload }
  end
end
