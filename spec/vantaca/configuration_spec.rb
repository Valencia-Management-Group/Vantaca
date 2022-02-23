# frozen_string_literal: true

# Copyright (c) 2022 Valencia Management Group
# All rights reserved.

require 'spec_helper'

RSpec.describe Vantaca::Configuration do
  describe '#configure' do
    let(:invalid_config_params) { ['Ü', nil, '', 'A/b/3!', 'äbcdef0123456789äbcdef0123456789'] }

    it 'creates a new client with an alphan' do
      expect { configure!(company: 'Vantaca', login: 'admin', password: 'abc123') }
        .to_not raise_exception
    end

    it 'fails when the company is not alphanumeric characters' do
      invalid_config_params.each do |param|
        expect { configure!(company: param, login: 'admin', password: 'abc123') }
          .to raise_exception ArgumentError
      end
    end

    it 'fails when the login is not alphanumeric characters' do
      invalid_config_params.each do |param|
        expect { configure!(company: 'Vantaca', login: param, password: 'abc123') }
          .to raise_exception ArgumentError
      end
    end

    it 'fails when the password is not alphanumeric characters' do
      invalid_config_params.each do |param|
        expect { configure!(company: 'Vantaca', login: 'admin', password: param) }
          .to raise_exception ArgumentError
      end
    end
  end
end
