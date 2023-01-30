# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

module Vantaca
  module Models
    # Information about a community, received from the Vantaca API
    class Community < Base
      def id = data['assocCode']

      def name = data['assocName']

      def tax_id = data['taxID']
    end
  end
end
