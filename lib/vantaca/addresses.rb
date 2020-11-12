# frozen_string_literal: true

# Copyright (c) 2020 Valencia Management Group
# All rights reserved.

module Vantaca
  module Addresses
    def create_address(homeowner_id, address_attributes)
      post('/Write/AddressCreate', address_attributes.merge(hoid: homeowner_id))

      true
    end

    def update_address(address_id, address_attributes)
      post('/Write/AddressUpdate', address_attributes.merge(addrID: address_id))

      true
    end

    def delete_address(address_id)
      post('/Write/AddressDestroy', addrID: address_id)

      true
    end
  end
end
