# frozen_string_literal: true

# Copyright (c) 2020 Valencia Management Group
# All rights reserved.

module Vantaca
  class Configuration
    attr_reader :login, :password, :company

    def company=(input)
      raise ArgumentError, 'Invalid Vantaca company name' unless input&.match?(/\A\w+\z/)

      @company = input
    end

    def login=(input)
      raise ArgumentError, 'Invalid Vantaca login' unless input&.match?(/\A\w+\z/)

      @login = input
    end

    def password=(input)
      raise ArgumentError, 'Invalid Vantaca password' unless input&.match?(/\A\w+\z/)

      @password = input
    end
  end
end
