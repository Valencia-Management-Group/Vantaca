# frozen_string_literal: true

# Copyright (c) 2022 Valencia Management Group
# All rights reserved.

module Vantaca
  # Methods which allow posting and deletion of ledger entries.
  module Ledger
    # Create a ledger entry for a specific homeowner.
    #
    # @param account [String] The 7-9 character account number for the homeowner, e.g. 'ABC12345'
    # @param type [String] Type of transaction. Possible values: Charge, Adjustment, Writeoff.
    # @param charge_id [Fixnum] The association Charge ID associated with this owners account.
    # @param date [String] The ledger date for this transaction, e.g. '2020-12-25'
    # @param amount [Float] Transaction amount. Must be greater than 0.
    # @param description [String] Description of the transaction.
    def create_ledger_entry(account, type:, charge_id:, date:, amount:, description:) # rubocop:disable Metrics/ParameterLists
      get(
        '/Write/CreateLedger',
        account:, type:, assocChgID: charge_id, ledgerDate: date, amount:, Descr: description
      )
    end

    def delete_ledger_entry(ledger_id)
      get('/Write/LedgerDelete', ownerLedgerID: ledger_id)

      true
    end
  end
end
