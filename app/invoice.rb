class Invoice
  include AASM

  attr_reader :name

  def initialize(name)
    @name = name
  end

  aasm do
    state :draft, initial: true
    state :unpaid
    state :sent
    state :paid
    state :archived

    after_all_transitions :log_state_change

    event :draft do
      transitions from: :unpaid, to: :draft
    end

    event :confirm do
      transitions from: :draft, to: :unpaid
    end

    event :sent, after: :send_invoice do
      transitions from: :unpaid, to: :sent
    end

    event :pay do
      transitions from: :sent, to: :paid
    end

    event :archive, after: :archive_data do
      transitions from: [:unpaid, :paid], to: :archived
    end
  end

  def log_state_change
    puts "Changed from #{aasm.from_state} to #{aasm.to_state} (event: #{aasm.current_event})"
  end

  def send_invoice
    puts 'Sending invoice'
  end

  def archive_data
    puts 'Archived data'
  end
end
