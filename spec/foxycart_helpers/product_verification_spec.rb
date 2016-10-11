require 'spec_helper'

module FoxycartHelpers
  describe ProductVerification, '.encode' do
    before do
      FoxycartHelpers.configure do |config|
        config.api_key = 'foobarbat'
      end
    end

    after do
      FoxycartHelpers.configure do |config|
        config.api_key = nil
      end
    end

    context 'with a normal name value' do
      it 'encodes code, name value with api key' do
        code = 'SKU123'
        name = 'name'
        value = 'My product'

        result = FoxycartHelpers::ProductVerification.encode(code, name, value)

        expect(result).to eq '75962bb014c9afce78224d30ed349cc0a34e6f1a304f94695d5192daebb3d560'
      end
    end

    context 'with a numeric prefix' do
      it 'removes prefix before encoding' do
        code = 'SKU123'
        name = '2:name'
        value = 'My product'

        result = FoxycartHelpers::ProductVerification.encode(code, name, value)

        # expect result to be identical to previous test
        expect(result).to eq '75962bb014c9afce78224d30ed349cc0a34e6f1a304f94695d5192daebb3d560'
      end
    end
  end

  describe ProductVerification, '.encoded_name' do
    before do
      FoxycartHelpers.configure do |config|
        config.api_key = 'foobarbat'
      end
    end

    after do
      FoxycartHelpers.configure do |config|
        config.api_key = nil
      end
    end

    it 'generates an encoded name' do
      code = 'SKU123'
      name = 'name'
      value = 'My product'

      result = FoxycartHelpers::ProductVerification.encoded_name(code, name, value)

      expect(result).to eq 'name||75962bb014c9afce78224d30ed349cc0a34e6f1a304f94695d5192daebb3d560'
    end

    it 'generates an encoded value' do
      code = 'SKU123'
      name = 'name'
      value = 'My product'

      result = FoxycartHelpers::ProductVerification.encoded_value(code, name, value)

      expect(result).to eq 'My product||75962bb014c9afce78224d30ed349cc0a34e6f1a304f94695d5192daebb3d560'
    end

    it 'generates an "--OPEN--" name' do
      code = 'SKU123'
      name = 'quantity'
      value = '--OPEN--'

      result = FoxycartHelpers::ProductVerification.encoded_name(code, name, value)

      expect(result).to eq 'quantity||1782f0f0c213887709d71af1788c270eb91bc231e0461e95c062bfa5a083a90b||open'
    end
  end
end
