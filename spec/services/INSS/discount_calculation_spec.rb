require 'rails_helper'

RSpec.describe INSS::DiscountCalculation do
  let(:discount_table_item1) { double('DiscountTableItem', min_range: 0, max_range: 1000, discount_percentage: 0.1) }
  let(:discount_table_item2) do
    double('DiscountTableItem', min_range: 1000.01, max_range: 2000, discount_percentage: 0.1)
  end
  let(:discount_table_item3) do
    double('DiscountTableItem', min_range: 2000.01, max_range: 3000, discount_percentage: 0.1)
  end
  let(:discount_table) { [discount_table_item1, discount_table_item2, discount_table_item3] }
  let(:discount_table_provider) { double('DiscountTable', call: discount_table) }

  before do
    allow(INSS::DiscountTable).to receive(:new).and_return(discount_table_provider)
  end

  describe '#call' do
    subject { described_class.new(base_salary).call }

    context 'when base salary is within the first range' do
      let(:base_salary) { 1000 }

      it 'calculates the correct discount' do
        expect(subject).to eq(100.0)
      end
    end

    context 'when base salary is within the second range' do
      let(:base_salary) { 2000 }

      it 'calculates the correct discount' do
        expect(subject).to eq(199.99)
      end
    end

    context 'when base salary is within the third range' do
      let(:base_salary) { 3000 }

      it 'calculates the correct discount' do
        expect(subject).to eq(299.98)
      end
    end

    context 'when base salary exceeds all ranges' do
      let(:base_salary) { 4000 }

      it 'calculates the correct discount' do
        expect(subject).to eq(299.98)
      end
    end
  end
end
