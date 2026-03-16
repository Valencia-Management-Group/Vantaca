# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

module Vantaca
  # Methods which allow creation, modification, and deletion of homeowner addresses.
  module Addresses
    def create_address(homeowner_id, address_attributes)
      post('/write/addressCreate', address_attributes.merge(hoid: homeowner_id))
    end

    def update_address(address_id, address_attributes)
      post('/write/addressUpdate', address_attributes.merge(addrID: address_id))
    end

    def delete_address(address_id)
      post('/write/addressDestroy', { addrID: address_id })
    end
  end
end
