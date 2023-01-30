# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

module Vantaca
  # Methods which fetch lists of documents or a document itself
  module Documents
    def documents(community:)
      response = get('/Read/Association', assocCode: community, includeDocuments: true)

      return [] unless response

      response.dig(0, 'documents').map { Vantaca::Models::Document.new(_1) }
    end

    # Download an actual file
    # TODO: Add the zip=true parameter and unzip the file using Rubyzip
    def document(community:, image_id:, &block)
      raise ArgumentError, 'Vantaca::Client#document requires a block' unless block_given?

      download('/Read/GetDocument', assocCode: community, imgID: image_id, &block)
    end
  end
end
