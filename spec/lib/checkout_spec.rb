require_relative '../../lib/checkout'

describe Checkout do
  let(:items) do
    [
      Item.new('001', 'Lavender heart', 9.25),
      Item.new('002', 'Personalised cufflinks', 45.00),
      Item.new('003', 'Kids T-shirt', 19.95)
    ]
  end
  let(:item_promotion) { Promotions::ItemPromotion.new(items[0], 2, 8.50) }
  let(:total_promotion) { Promotions::TotalPromotion.new(60, 10) }

  describe '#total' do
    subject { Checkout.new([item_promotion, total_promotion]) }
    it 'applies total promotion' do
      subject.scan(items[0])
      subject.scan(items[1])
      subject.scan(items[2])
      expect(subject.total).to eq 66.78
    end

    it 'applies item promotion' do
      subject.scan(items[0])
      subject.scan(items[2])
      subject.scan(items[0])
      expect(subject.total).to eq 36.95
    end

    it 'applies all promotions' do
      subject.scan(items[0])
      subject.scan(items[1])
      subject.scan(items[0])
      subject.scan(items[2])
      expect(subject.total).to eq 73.76
    end
  end
end
