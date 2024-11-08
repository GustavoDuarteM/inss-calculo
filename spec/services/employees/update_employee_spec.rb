# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Employees::UpdateEmployee do
  let(:employee) { create(:employee, salary: 1000, inss_discount: 100) }
  let(:params) do
    {
      name: 'John Doe',
      birth_date: '1990-01-01',
      id_document: '123456789',
      salary: 2000
    }
  end

  subject { described_class.new(employee.id, params) }

  describe '#call' do
    context 'when employee is valid' do
      it 'updates the employee' do
        expect { subject.call }.to change { employee.reload.salary }.from(1000).to(2000)
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
