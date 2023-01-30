# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

module Vantaca
  # Methods which load or modify one or more owners.
  module Owners
    OWNER_PARAMETERS = {
      bk_list: :includeOwnerBKList,
      charges: :includeOwnerChargeTransactions,
      next_assessment: :includeNextAssessment,
      transactions: :includeOwnerTransactions,
      breakdown: :includebalanceByChargeType
    }.freeze

    # Load a list of all owners in a specific community
    #
    # @param assoc_code [String] the 3-4 character association code for a community
    # @option opts [Symbol, Array<Symbol>] :include Include additional information, using keys from OWNER_PARAMETERS
    # @return [Array<Vantaca::Models::Owner>] a list of all current and former owners in this community.
    def community_owners(assoc_code, **options)
      params = owner_parameters(assoc_code, options)

      response = get('/Read/Association', **params)

      raise Vantaca::Errors::NotFoundError unless response

      response.dig(0, 'owners').map { Vantaca::Models::Owner.new(_1) }
    end

    # Loading an owner by their account number doesn't need a community code, since the account numbers are unique.
    #
    # @param account [String] the 7-9 character account number for a property's homeowner
    # @option opts [Symbol, Array<Symbol>] :include Include additional information, using keys from OWNER_PARAMETERS
    # @return [Vantaca::Models::Owner] a list of all current and former owners in this community.
    def account_owner(account, **options)
      params = owner_parameters(nil, options).merge(account:)

      response = get('/Read/Association', **params)

      raise Vantaca::Errors::NotFoundError unless response

      Vantaca::Models::Owner.new response.dig(0, 'owners', 0)
    end

    # Load a list of all owners for a specific property
    #
    # @param assoc_code [String] the 3-4 character association code for a community
    # @param property_id [Fixnum] the internal Vantaca property ID
    # @option opts [Symbol, Array<Symbol>] :include Include additional information, using keys from OWNER_PARAMETERS
    # @return [Array<Vantaca::Models::Owner>] a list of all current and former owners for this property.
    def property_owners(assoc_code, property_id, **options)
      params = owner_parameters(assoc_code, options).merge(propertyID: property_id)

      response = get('/Read/Association', **params)

      raise Vantaca::Errors::NotFoundError unless response

      response.dig(0, 'owners').map { Vantaca::Models::Owner.new(_1) }
    end

    # Load a specific homeowner - this currently loads only the first owner record, even if the owner has multiple
    # properties in this community.
    #
    # @param assoc_code [String] the 3-4 character association code for a community
    # @param owner_id [Fixnum] the internal Vantaca homeowner ID
    # @option opts [Symbol, Array<Symbol>] :include Include additional information, using keys from OWNER_PARAMETERS
    # @return [Vantaca::Models::Owner] the owner record for this homeowner
    def owner(assoc_code, owner_id, **options)
      params = owner_parameters(assoc_code, options).merge(Hoid: owner_id)

      response = get('/Read/Association', **params)

      raise Vantaca::Errors::NotFoundError unless response

      Vantaca::Models::Owner.new response.dig(0, 'owners', 0)
    end

    # This data is already included in the basic owner data - this endpoint isn't very useful.
    def communication_preferences(owner_id)
      response = get('/Read/GetCommPreference', hoID: owner_id)

      raise Vantaca::Errors::NotFoundError unless response

      {
        communication: response['commpref'],
        billing: response['billingpref']
      }
    end

    # Update the communication preferences for a homeowner.
    #
    # @param owner_id [Fixnum] the internal Vantaca homeowner ID
    # @param communication [Fixnum] the new general communication preference, accepted values: Paper, Email, App, Text
    # @param billing [Fixnum] the internal the new billing communication preference, accepted values: Paper, Text, Email
    # @return [true]
    def update_communication_preferences(owner_id, communication: nil, billing: nil)
      raise ArgumentError, 'At least communication or billing must be passed.' unless communication || billing

      params = { hoid: owner_id }
      params[:commpref] = communication if communication
      params[:billingpref] = billing if billing

      post('/Write/commPrefUpdate', params)

      true
    end

    protected

    def owner_parameters(community, options)
      params = { includeOwners: true }

      params[:assocCode] = community if community

      OWNER_PARAMETERS.values_at(*Array(options[:include])).compact.each do |vantaca_parameter|
        params[vantaca_parameter] = true
      end

      params
    end
  end
end
