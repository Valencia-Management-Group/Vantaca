# frozen_string_literal: true

# Copyright (c) 2019 Valencia Management Group
# All rights reserved.

require 'spec_helper'

RSpec.describe Vantaca::Configuration do
  describe '#configure' do
    it 'creates a new client with an alphan' do
      expect do
        configure!(company: 'Vantaca', login: 'admin', password: 'abc123')
      end.to_not raise_exception
    end

    it 'fails when the company is not alphanumeric characters' do
      keys = ['Ü', nil, '', 'A/b/3!', 'äbcdef0123456789äbcdef0123456789']

      keys.each do |key|
        expect do
          configure!(company: key, login: 'admin', password: 'abc123')
        end.to raise_exception ArgumentError
      end
    end

    it 'fails when the login is not alphanumeric characters' do
      keys = ['Ü', nil, '', 'A/b/3!', 'äbcdef0123456789äbcdef0123456789']

      keys.each do |key|
        expect do
          configure!(company: 'Vantaca', login: key, password: 'abc123')
        end.to raise_exception ArgumentError
      end
    end

    it 'fails when the password is not alphanumeric characters' do
      keys = ['Ü', nil, '', 'A/b/3!', 'äbcdef0123456789äbcdef0123456789']

      keys.each do |key|
        expect do
          configure!(company: 'Vantaca', login: 'admin', password: key)
        end.to raise_exception ArgumentError
      end
    end
  end
end
