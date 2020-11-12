# frozen_string_literal: true

# Copyright (c) 2020 Valencia Management Group
# All rights reserved.

module Vantaca
  # Methods which allow posting and deletion of ledger entries.
  module Ledger
    def create_ledger_entry(account, ledger_attributes)
      post('/Write/CreateLedger', ledger_attributes.merge(account: account))
    end

    def delete_ledger_entry(ledger_id)
      post('/Write/LedgerDelete', ownerLedgerID: ledger_id)

      true
    end
  end
end
