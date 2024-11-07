# frozen_string_literal: true

class Employee < ApplicationRecord
  enum discount_status: {
    pending: 'pending',
    applied: 'applied'
  }
end
