# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

require 'spec_helper'

RSpec.describe Vantaca::Owners do
  before { configure! }

  let(:client) { Vantaca::Client.new }

  describe '#community_owners' do
    it 'GETs a list of owners in a community', vcr: 'owners/community' do
      communities = client.community_owners(999)

      expect(communities).to be_a Array
      expect(communities[0]).to be_a Vantaca::Models::Owner
      expect(communities.length).to be 50
    end
  end

  describe '#account_owner' do
    it 'GETs a specific owner by account number', vcr: 'owners/account' do
      communities = client.account_owner('99910086')

      expect(communities).to be_a Vantaca::Models::Owner
    end

    it 'GETs a specific owner by account number with additional information', vcr: 'owners/account_next_assessment' do
      communities = client.account_owner('99910086', include: :next_assessment)

      expect(communities).to be_a Vantaca::Models::Owner
    end
  end

  # describe '#property_owners' do
  # end

  # describe '#owner' do
  # end
end
