# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

module Vantaca
  # Methods which fetch lists of documents or a document itself
  module Documents
    # Load messages and attachments for an action item.
    #
    # @param xn_number [String] the unique identifier of an action item
    # @param message_id [String, nil] limit results to a single message
    # @param attachment_id [String, nil] limit results to a single attachment
    # @param include_file [Boolean] whether to include attachment file data
    # @return [Array<Hash>] messages and attachments for the action item
    def attachment_list(xn_number:, message_id: nil, attachment_id: nil, include_file: false)
      params = {
        xnNumber: xn_number,
        messageID: message_id,
        attachmentID: attachment_id,
        includeFile: include_file
      }.compact

      get('/read/AttachmentList', **params)
    end

    def documents(community:)
      response = get('/read/Association', assocCode: community, includeDocuments: true)

      return [] unless response

      response.dig(0, 'documents').map { Vantaca::Models::Document.new(it) }
    end

    # Download an actual file
    # TODO: Add the zip=true parameter and unzip the file using Rubyzip
    def document(community:, image_id:, &)
      raise ArgumentError, 'Vantaca::Client#document requires a block' unless block_given?

      download('/read/getDocument', assocCode: community, imgID: image_id, &)
    end
  end
end
