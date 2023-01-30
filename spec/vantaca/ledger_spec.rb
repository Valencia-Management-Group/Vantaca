# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

require 'spec_helper'

RSpec.describe Vantaca::Ledger do
  before { configure! }

  let(:client) { Vantaca::Client.new }

  describe '#create_ledger_entry' do
    it 'Creates a ledger entry' do
      stub_request_for(
        '/Write/CreateLedger?account=BC13506&type=Charge&assocChgID=667&ledgerDate=2020-10-05&amount=4.99&' \
        'Descr=test%20fine',
        with: :blank
      )

      response = client.create_ledger_entry(
        'BC13506',
        type: 'Charge',
        charge_id: 667,
        date: '2020-10-05',
        amount: 4.99,
        description: 'test fine'
      )

      expect(response).to be_nil
    end
  end
end
