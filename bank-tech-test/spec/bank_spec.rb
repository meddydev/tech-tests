require 'bank'

describe 'Bank' do
  it 'initially shows a balance of 0' do
    bank = Bank.new
    expect(bank.print_statement).to eq('0 balance')
  end

  it 'shows correct print_statement after a valid deposit' do
    bank = Bank.new
    bank.deposit(1000.00, '22/06/2022')
    expect(bank.print_statement).to eq '22/06/2022 || deposit/withdrawal: 1000.0 || balance: 1000.0'
  end

  it 'shows correct statement after two valid deposits and a withdrawal' do
    bank = Bank.new
    bank.deposit(1000.00, '22/06/2022')
    bank.deposit(2000.00, '23/06/2022')
    bank.withdraw(500.00, '30/06/2022')
    expect(bank.print_statement).to eq("30/06/2022 || deposit/withdrawal: -500.0 || balance: 2500.0\n23/06/2022 || deposit/withdrawal: 2000.0 || balance: 3000.0\n22/06/2022 || deposit/withdrawal: 1000.0 || balance: 1000.0")
  end

  it "doesn't allow incorrect amount format" do
    bank = Bank.new
    bank.deposit(100, '22/06/2022')
    bank.deposit(0, '22/06/2022')
    bank.deposit(100.101, '22/06/2022')
    bank.deposit(99.9999, '22/06/2022')
    expect(bank.print_statement).to eq('0 balance')
  end

  it "doesn't allow incorrect date format" do
    bank = Bank.new
    bank.deposit(100.00, '22/16/2022')
    bank.deposit(100.00, '16th June 2022')
    bank.deposit(100.00, '40/06/2022')
    bank.deposit(100.00, '05/05/5')
    expect(bank.print_statement).to eq('0 balance')
  end

  it "doesn't let you withdraw initially (i.e. with 0 balance)" do
    bank = Bank.new
    expect(bank.withdraw(50.00, '22/06/2022')).to eq('Cannot withdraw an amount greater than available balance')
  end

  it "doesn't let you withdraw more than is available in the balance" do
    bank = Bank.new
    bank.deposit(1000.00, '21/06/2022')
    expect(bank.withdraw(1050.00, '22/06/2022')).to eq('Cannot withdraw an amount greater than available balance')
  end
end
