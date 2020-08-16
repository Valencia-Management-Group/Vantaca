# frozen_string_literal: true

# Copyright (c) 2020 Valencia Management Group
# All rights reserved.

module Vantaca
  module Owners
    # Load a list of all owners in a specific community
    def community_owners(assoc_code, **options)
      params = owner_parameters(assoc_code, options)

      response = get('/Read/Association', **params)

      raise Vantaca::NotFoundError unless response

      response.dig(0, 'owners').map do |owner_data|
        Vantaca::Models::Owner.new(owner_data)
      end
    end

    def account_owner(account, **options)
      params = owner_parameters(nil, options).merge(account: account)

      response = get('/Read/Association', **params)

      raise Vantaca::NotFoundError unless response

      Vantaca::Models::Owner.new response.dig(0, 'owners', 0)
    end

    def property_owners(assoc_code, property_id, **options)
      params = owner_parameters(assoc_code, options)
        .merge(propertyID: property_id)

      response = get('/Read/Association', **params)

      raise Vantaca::NotFoundError unless response

      response.dig(0, 'owners').map do |owner_data|
        Vantaca::Models::Owner.new(owner_data)
      end
    end

    def owner(assoc_code, owner_id, **options)
      params = owner_parameters(assoc_code, options)
        .merge(Hoid: owner_id)

      response = get('/Read/Association', **params)

      raise Vantaca::NotFoundError unless response

      Vantaca::Models::Owner.new response.dig(0, 'owners', 0)
    end

    protected

    def owner_parameters(community, input)
      output = {
        assocCode: community,
        includeOwners: true
      }

      output[:includeOwnerTransactions] = true if input[:transactions]
      output[:includeOwnerChargeTransactions] = true if input[:charges]
      output[:includeOwnerBKList] = true if input[:bk_list]

      output
    end
  end
end
