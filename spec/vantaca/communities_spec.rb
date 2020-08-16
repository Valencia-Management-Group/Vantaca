# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Vantaca::Communities do
  before { configure! }

  let(:client) { Vantaca::Client.new }

  describe '#communities' do
    it 'GETs a list of communities' do
      communities = client.communities

      expect(communities).to be_a Array
      expect(communities.length).to be 2
    end
  end
end
