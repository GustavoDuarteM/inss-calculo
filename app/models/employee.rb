# frozen_string_literal: true

class Employee < ApplicationRecord
  enum discount_status: {
    pending: 0,
    applied: 1
  }
end
