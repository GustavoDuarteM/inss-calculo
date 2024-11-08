# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Employees::CreateEmployee do
  describe '#call' do
    subject { described_class.new(params) }
    let(:params) do
      {
        name: 'John Doe',
        birth_date: '1990-01-01',
        id_document: '123456789',
        salary: 1000,
        inss_discount: 100
      }
    end

    context 'when employee is valid' do
      it 'creates a new employee' do
        expect { subject.call }.to change { Employee.count }.by(1)
      end

      it 'returns the employee and true' do
        employee, valid = subject.call

        expect(employee).to be_a(Employee)
        expect(valid).to be_truthy
      end
    end

    context 'when employee is invalid' do
      it 'raises an error' do
        params[:name] = nil

        expect { subject.call }.to raise_error(ActiveRecord::NotNullViolation)
      end
    end
  end
end
