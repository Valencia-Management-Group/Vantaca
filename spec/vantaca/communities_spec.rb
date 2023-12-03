# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

require 'spec_helper'

RSpec.describe Vantaca::Communities do
  before { configure! }

  let(:client) { Vantaca::Client.new }

  describe '#communities' do
    it 'GETs a list of communities', vcr: 'communities/all' do
      communities = client.communities

      expect(communities).to be_a Array
      expect(communities.first).to be_a Vantaca::Models::Community
      expect(communities.length).to be 2
    end
  end

  describe '#community' do
    it 'GETs a single community', vcr: 'communities/single' do
      community = client.community('TEST')

      expect(community).to be_a Vantaca::Models::Community
      expect(community.name).to eq 'VMG Testing Sandbox'
    end

    it 'raises an exception when a community does not exist', vcr: 'communities/not_found' do
      expect { client.community('HEY') }
        .to raise_exception Vantaca::Errors::NotFoundError
    end
  end
end
