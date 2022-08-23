class Bank
  def initialize
    @balance = 0
    @entries = {}
    'When depositing or withdrawing, please enter the amount in the format XXX.XX and the date in the format DD/MM/YYYY'
  end

  def deposit(amount, date)
    if valid_amount_and_date?(amount, date)
      @balance += amount
      @entries.store(date, [amount, @balance])
    else
      'When depositing or withdrawing, please enter the amount in the format XXX.XX and the date in the format DD/MM/YYYY'
    end
  end

  def withdraw(amount, date)
    if amount > @balance
      'Cannot withdraw an amount greater than available balance'
    elsif valid_amount_and_date?(amount, date)
      @balance -= amount
      @entries.store(date, [amount * -1, @balance])
    else
      'When depositing or withdrawing, please enter the amount in the format XXX.XX and the date in the format DD/MM/YYYY'
    end
  end

  def print_statement
    records = []
    @entries.each do |date, account|
        amount = account[0]
        balance = account[1]
      records << "#{date} || deposit/withdrawal: #{amount} || balance: #{balance.round(2)}"
    end
    if records.empty?
      '0 balance'
    else
      records.reverse.join("\n")
    end
  end

  private

  def valid_amount_and_date?(amount, date)
    validity = true
    if !amount.to_s.match(/^\d+\.\d{0,2}$/)
      validity = false
    elsif !date.match(%r{^([0-2][0-9]|(3)[0-1])(/)(((0)[0-9])|((1)[0-2]))(/)\d{4}$})
      validity = false
    end
    validity
  end
end

