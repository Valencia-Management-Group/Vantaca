# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

module Vantaca
  # Methods which load or modify one or more violations.
  module Violations
    # Retrieves a list of all violations
    #
    # @param assoc_code [String] unique identifer for an association
    # @param account [String, nil] unique identifier for a single homeowner account
    # @param xn_number [String, nil] unique identifier for a violation
    # @param include_messages [Boolean] if true, response will include message array, else false, messages field will
    #   display as null.
    # @return [Array<Vantaca::Models::Violation>] a list of all current violations in this community.
    def violation_list(assoc_code, account: nil, xn_number: nil, include_messages: false)
      params = {
        assocCode: assoc_code,
        accountNo: account,
        xnNumber: xn_number,
        includeMessages: include_messages
      }.compact

      response = get('/read/violationList', **params)

      raise Vantaca::Errors::NotFoundError unless response

      response.map { Vantaca::Models::Violation.new(it) }
    end
  end
end
