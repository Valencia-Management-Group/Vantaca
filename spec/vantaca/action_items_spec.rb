# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

require 'spec_helper'

RSpec.describe Vantaca::ActionItems do
  before { configure! }

  let(:client) { Vantaca::Client.new }

  describe '#action_categories' do
    it 'GETs a list of action categories', vcr: 'action_categories/all' do
      action_categories = client.action_categories

      expect(action_categories).to be_a Array
      expect(action_categories.first).to be_a Vantaca::Models::ActionCategory
      expect(action_categories.length).to be 3
      expect(action_categories.first.id).to eq 0
      expect(action_categories.first.description).to eq 'Standard'
    end
  end

  describe '#action_types' do
    it 'GETs a list of action types', vcr: 'action_types/all' do
      action_types = client.action_types

      expect(action_types).to be_a Array
      expect(action_types.first).to be_a Vantaca::Models::ActionType
      expect(action_types.length).to be 11
      expect(action_types.first.id).to eq(-2)
      expect(action_types.first.description).to eq 'Software Support'
    end
  end

  describe '#arc_requests' do
    it 'GETs ARC requests for an association', vcr: false do
      stub_request(
        :get,
        'https://service-e.vantaca.net/read/ARCList?assocCode=ABC&company=Vantaca&includeMessage=false&login=admin&pwd=abc123'
      ).to_return(
        status: 200,
        body: [{
          arcType: 'Mailbox',
          xnNumber: '123456',
          assocCode: 'ABC',
          accountNo: '100253647',
          propertyID: '10212',
          closed: false,
          description: 'Mailbox replacement request',
          subject: 'Mailbox inquiry',
          createdDate: '2021-08-05T15:44:14.85',
          lastModified: '2021-08-06T09:00:00'
        }].to_json,
        headers: { 'Content-Type' => 'application/json' }
      )

      arc_requests = client.arc_requests('ABC')

      expect(arc_requests).to all(be_a(Vantaca::Models::ArcRequest))
      expect(arc_requests.first.xn_number).to eq '123456'
      expect(arc_requests.first.assoc_code).to eq 'ABC'
      expect(arc_requests.first.closed?).to be false
    end
  end
end
