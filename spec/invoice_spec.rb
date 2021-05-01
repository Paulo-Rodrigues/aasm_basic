describe Invoice do
  let(:name) { 'Test invoice' }
  let(:invoice) { described_class.new(name) }

  context 'initial state' do
    subject { invoice }

    it { is_expected.to have_state(:draft) }
  end

  context 'archive' do
    subject { invoice.archive }
    before { invoice.aasm.current_state = :paid }

    it 'calls all needed methods' do
      expect(invoice).to receive(:archive_data)
      expect(invoice).to receive(:log_state_change)
      subject
    end
  end

  context 'sent' do
    subject { invoice.sent }
    before { invoice.aasm.current_state = :unpaid }

    it 'calls all methods' do
      expect(invoice).to receive(:send_invoice)
      expect(invoice).to receive(:log_state_change)
      subject
    end
  end
end
