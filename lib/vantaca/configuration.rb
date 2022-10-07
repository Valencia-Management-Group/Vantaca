# frozen_string_literal: true

# Copyright (c) 2022 Valencia Management Group
# All rights reserved.

module Vantaca
  # The basic configuration object for the Vantaca client. I wish these weren't passed in the URL...
  class Configuration
    attr_reader :login, :password, :company, :logger

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

    def logger=(new_logger)
      raise ArgumentError, 'Logger must be an instance of the Logger class' unless new_logger.is_a?(::Logger)

      @logger = new_logger
    end

    def to_params
      {
        company: @company,
        login: @login,
        pwd: @password
      }
    end
  end
end
