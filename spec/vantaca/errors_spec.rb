# frozen_string_literal: true

# Copyright (c) 2022 Valencia Management Group
# All rights reserved.

require 'spec_helper'

RSpec.describe Vantaca::ApiError do
  before { configure! }

  let(:client) { Vantaca::Client.new }

  it 'properly parses 4xx errors' do
    stub_error_request_for '/Read/Error', with: '400 Unable to create charge.'

    expect { client.get('/Read/Error') }
      .to raise_exception Vantaca::ClientError, /400: Unable to create charge/
  end

  it 'properly parses 5xx errors' do
    stub_error_request_for '/Read/Error', with: '503 Something terrible happened.'

    expect { client.get('/Read/Error') }
      .to raise_exception Vantaca::InternalError, /503: Something terrible happened/
  end

  it 'properly parses timeout errors' do
    stub_error_request_for '/Read/Error', with: '503 Timeout expired.'

    expect { client.get('/Read/Error') }
      .to raise_exception Vantaca::TimeoutError
  end
end
