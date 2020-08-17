# frozen_string_literal: true

# Copyright (c) 2020 Valencia Management Group
# All rights reserved.

require 'spec_helper'

RSpec.describe Vantaca::Owners do
  before { configure! }

  let(:client) { Vantaca::Client.new }

  describe '#community_owners' do
    it 'GETs a list of owners in a community' do
      stub_request_for '/Read/Association?assocCode=999&includeOwners=true',
                       with: 'owners/community.json'

      communities = client.community_owners(999)

      expect(communities).to be_a Array
      expect(communities[0]).to be_a Vantaca::Models::Owner
      expect(communities.length).to be 50
    end
  end

  describe '#account_owner' do
    it 'GETs a list of owners in a community' do
      stub_request_for '/Read/Association?account=99910086&includeOwners=true',
                       with: 'owners/account.json'

      communities = client.account_owner('99910086')

      expect(communities).to be_a Vantaca::Models::Owner
    end
  end

  describe '#property_owners' do
  end

  describe '#owner' do
  end

  # describe '#community' do
  #   it 'GETs a single community' do
  #     stub_request_for '/Read/Association?assocCode=TEST', with: 'communities/single.json'

  #     community = client.community('TEST')

  #     expect(community).to be_a Vantaca::Models::Community
  #     expect(community.name).to eq 'VMG Testing Sandbox'
  #   end

  #   it 'raises an exception when a community does not exist' do
  #     stub_request_for '/Read/Association?assocCode=HEY', with: :error

  #     expect { client.community('HEY') }
  #       .to raise_exception Vantaca::NotFoundError
  #   end
  # end
end
