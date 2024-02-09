# frozen_string_literal: true

RSpec.describe RubyMagicLink do
  describe '.setup' do
    let(:secret_key) { 'super_secret_key' }

    it 'sets the secret_key' do
      described_class.setup do |config|
        config.secret_key = secret_key
      end

      expect(described_class.config.secret_key).to eq(secret_key)
    end
  end
end
