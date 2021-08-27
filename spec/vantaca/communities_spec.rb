# frozen_string_literal: true

# Copyright (c) 2020 Valencia Management Group
# All rights reserved.

require 'spec_helper'

RSpec.describe Vantaca::Communities do
  before { configure! }

  let(:client) { Vantaca::Client.new }

  describe '#communities' do
    it 'GETs a list of communities' do
      stub_request_for '/Read/Association', with: 'communities/all_communities'

      communities = client.communities

      expect(communities).to be_a Array
      expect(communities[0]).to be_a Vantaca::Models::Community
      expect(communities.length).to be 2
    end
  end

  describe '#community' do
    it 'GETs a single community' do
      stub_request_for '/Read/Association?assocCode=TEST', with: 'communities/single'

      community = client.community('TEST')

      expect(community).to be_a Vantaca::Models::Community
      expect(community.name).to eq 'VMG Testing Sandbox'
    end

    it 'raises an exception when a community does not exist' do
      stub_error_request_for '/Read/Association?assocCode=HEY', with: '204 No Content'

      expect { client.community('HEY') }
        .to raise_exception Vantaca::NotFoundError
    end
  end
end
