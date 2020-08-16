# frozen_string_literal: true

# Copyright (c) 2020 Valencia Management Group
# All rights reserved.

require 'spec_helper'

RSpec.describe Vantaca::Client do
  describe '#new' do
    it 'creates a new client with an alphan' do
      expect(Vantaca::Client.new).to be_a Vantaca::Client
    end
  end
end
