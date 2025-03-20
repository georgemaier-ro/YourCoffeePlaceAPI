require 'rails_helper'

RSpec.describe ErrorsHelper, type: :helper do
  context 'when providing an error ' do
    it 'raises the error' do
      expect(api_error(1)).to eq({ error_code: 1, error_description: "The URL provided is invalid.", error_message: "Invalid URL" })
    end
  end
end
