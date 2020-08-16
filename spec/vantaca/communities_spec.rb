# frozen_string_literal: true

# Copyright (c) 2020 Valencia Management Group
# All rights reserved.

require 'spec_helper'

RSpec.describe Vantaca::Communities do
  before { configure! }

  let(:client) { Vantaca::Client.new }

  describe '#communities' do
    it 'GETs a list of communities' do
      communities = client.communities

      expect(communities).to be_a Array
      expect(communities[0]).to be_a Vantaca::Models::Community
      expect(communities.length).to be 2
    end
  end

  describe '#community' do
    it 'GETs a single community' do
      community = client.community('TEST')

      expect(community).to be_a Vantaca::Models::Community
      expect(community.name).to eq 'VMG Testing Sandbox'
    end

    it 'raises an exception when a community does not exist' do
      expect { client.community('HEY') }
        .to raise_exception Vantaca::NotFoundError
    end
  end
end
