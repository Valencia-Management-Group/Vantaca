# frozen_string_literal: true

# Copyright (c) 2022 Valencia Management Group
# All rights reserved.

require 'spec_helper'

RSpec.describe Vantaca::Documents do
  before { configure! }

  let(:client) { Vantaca::Client.new }

  describe '#documents' do
    it 'GETs a list of documents' do
      stub_request_for '/Read/Association?assocCode=999&includeDocuments=true', with: 'documents/all_documents'

      documents = client.documents(community: 999)

      expect(documents).to be_a Array
      expect(documents.length).to be 2

      document = documents.first

      expect(document).to be_a Vantaca::Models::Document
      expect(document.id).to eq 3537
      expect(document.name).to eq 'Community Information.pdf'
      expect(document.folder_path).to eq 'Documents/Welcome Packet/'
      expect(document.security_id).to eq 1
    end
  end

  describe '#document' do
    it 'GETs a single document' do
      stub_request_for '/Read/GetDocument?assocCode=999&imgID=3537', with: 'documents/3537.pdf'

      client.document(community: 999, image_id: 3537) do |file|
        expect(file.size).to eq 204_523
      end
    end
  end
end
