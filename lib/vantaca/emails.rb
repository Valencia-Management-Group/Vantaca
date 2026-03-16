# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

module Vantaca
  # Methods which allow creation, modification, and deletion of homeowner email addresses.
  module Emails
    # @param homeowner_id [Integer] The ID of the homeowner
    # @param email_attrs [Hash] The email address details
    # @option email_attrs [String] :email (required) The email address
    # @option email_attrs [Boolean] :isPrimary Whether this is the primary email address
    # @option email_attrs [String] :label Optional label for the email address (e.g., 'Work', 'Personal')
    # @return [nil] The API response from the email creation endpoint
    def create_email_address(homeowner_id, email_attrs)
      post('/write/emailCreate', email_attrs.merge(hoid: homeowner_id))
    end

    # @param email_address_id [Integer] The ID of the email address to update
    # @param email_attrs [Hash] The updated email address details
    # @option email_attrs [String] :email (required) The email address
    # @option email_attrs [Boolean] :isPrimary Whether this is the primary email address
    # @option email_attrs [String] :label Optional label for the email address (e.g., 'Work', 'Personal')
    # @return [nil] The API response from the email update endpoint
    def update_email_address(email_address_id, email_attrs)
      post('/write/emailUpdate', email_attrs.merge(emailID: email_address_id))
    end

    # @param email_address_id [Integer] The ID of the email address to delete
    # @return [nil] The API response from the email deletion endpoint
    def delete_email_address(email_address_id)
      post('/write/emailDestroy', { emailID: email_address_id })
    end
  end
end
