# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

require 'spec_helper'

RSpec.describe Vantaca::Providers do
  before { configure! }

  let(:client) { Vantaca::Client.new }

  describe '#providers' do
    it 'GETs a list of providers', vcr: 'providers/all' do
      providers = client.providers

      expect(providers).to be_a Array
      expect(providers.first).to be_a Vantaca::Models::Provider
      expect(providers.length).to be 3
    end
  end

  describe '#provider' do
    it 'GETs a specific provider', vcr: 'providers/single' do
      provider = client.provider('123')

      expect(provider).to be_a Vantaca::Models::Provider
      expect(provider.name).to eq "Joe's Plumbing"
      expect(provider.insurance).to be_nil
    end

    it 'GETs a specific provider with additional insurance', vcr: 'providers/single_with_insurance' do
      provider = client.provider('123', include: :insurance)

      expect(provider).to be_a Vantaca::Models::Provider
      expect(provider.insurance).to be_a Array
    end
  end
end
