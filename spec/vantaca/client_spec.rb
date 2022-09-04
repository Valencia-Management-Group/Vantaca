# frozen_string_literal: true

# Copyright (c) 2022 Valencia Management Group
# All rights reserved.

require 'spec_helper'

RSpec.describe Vantaca::Client do
  before { Vantaca.configure }

  describe '#new' do
    it 'creates a new client' do
      expect(described_class.new).to be_a described_class
    end
  end
end
