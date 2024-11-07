# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Employees::UpdateDiscountSalary do
  describe '#call' do
    subject { described_class.new(employee) }

    context 'when employee is not applied' do
      let(:employee) { create(:employee, discount_status: 'pending', inss_discount: 0) }
      it 'updates the employee discount salary' do
        expect { subject.call }.to change { employee.reload.discount_status }.from('pending').to('applied')
      end

      it 'updates the employee inss discount' do
        allow_any_instance_of(INSS::DiscountCalculation).to receive(:call).and_return(1000)

        expect { subject.call }.to change { employee.reload.inss_discount }.from(0).to(1000)
      end
    end

    context 'when employee is already applied' do
      let(:employee) { create(:employee, discount_status: 'applied', inss_discount: 0) }

      it 'does not update the employee discount salary' do
        expect { subject.call }.not_to(change { employee.reload.discount_status })
      end

      it 'does not update the employee inss discount' do
        expect { subject.call }.not_to(change { employee.reload.inss_discount })
      end
    end
  end
end
