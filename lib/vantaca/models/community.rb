# frozen_string_literal: true

# Copyright (c) 2022 Valencia Management Group
# All rights reserved.

module Vantaca
  module Models
    # Information about a community, received from the Vantaca API
    class Community < Base
      def id
        data['assocCode']
      end

      def name
        data['assocName']
      end

      def tax_id
        data['taxID']
      end
    end
  end
end
