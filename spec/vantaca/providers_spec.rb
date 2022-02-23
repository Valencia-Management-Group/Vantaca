# frozen_string_literal: true

# Copyright (c) 2022 Valencia Management Group
# All rights reserved.

require 'spec_helper'

RSpec.describe Vantaca::Providers do
  before { configure! }

  let(:client) { Vantaca::Client.new }

  describe '#providers' do
    it 'GETs a list of providers' do
      stub_request_for '/Read/Provider', with: 'providers/all_providers'

      providers = client.providers

      expect(providers).to be_a Array
      expect(providers[0]).to be_a Vantaca::Models::Provider
      expect(providers.length).to be 3
    end
  end

  describe '#provider' do
    it 'GETs a specific provider' do
      stub_request_for '/Read/ProviderSingle?providerID=123', with: 'providers/single'

      provider = client.provider('123')

      expect(provider).to be_a Vantaca::Models::Provider
      expect(provider.name).to eq "Joe's Plumbing"
      expect(provider.insurance).to be nil
    end

    it 'GETs a specific provider with additional insurance' do
      stub_request_for '/Read/ProviderSingle?providerID=123&includeInsurance=true',
                       with: 'providers/single_with_insurance'

      provider = client.provider('123', include: :insurance)

      expect(provider).to be_a Vantaca::Models::Provider
      expect(provider.insurance).to be_a Array
    end
  end

  # describe '#property_owners' do
  # end

  # describe '#owner' do
  # end
end
