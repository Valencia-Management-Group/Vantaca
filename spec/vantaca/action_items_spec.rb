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
end
