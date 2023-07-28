# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

require 'spec_helper'

RSpec.describe Vantaca::Errors do
  before { configure! }

  let(:client) { Vantaca::Client.new }

  it 'properly parses 4xx errors', vcr: 'errors/400' do
    expect { client.get('/Read/Error') }
      .to raise_exception Vantaca::Errors::ClientError, /400: INVALID DATE - The Posting Date MUST be in a valid period/
  end

  it 'properly parses 5xx errors', vcr: 'errors/500' do
    expect { client.get('/Read/Error') }
      .to raise_exception Vantaca::Errors::InternalError, /500: Something terrible happened/
  end

  it 'properly parses timeout errors', vcr: 'errors/503' do
    expect { client.get('/Read/Timeout') }
      .to raise_exception Vantaca::Errors::TimeoutError
  end
end
