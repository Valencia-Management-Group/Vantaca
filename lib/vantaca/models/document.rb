# frozen_string_literal: true

# Copyright (c) 2022 Valencia Management Group
# All rights reserved.

module Vantaca
  module Models
    # Information about a document, received from the Vantaca API
    class Document < Base
      SECURITY_LEVELS = %w[Public Homeowners Board Staff].freeze

      def id
        data['imgID']
      end

      def name
        data['docName']
      end

      def folder_path
        data['folderPath']
      end

      def security_id
        data['securityID']
      end
    end
  end
end
