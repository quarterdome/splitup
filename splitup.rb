
class Payment

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
  end

  def human_readable
    "#{@sender} pays #{@receiver} $%.2f" % @amount
  end

  attr_reader :sender
  attr_reader :receiver
  attr_reader :amount

end


class Expenses

  def initialize(expenses)
    @expenses = expenses
  end

  def compute_balance

    total = @expenses.values.inject(:+)
    per_person = total.to_f / @expenses.count

    balance = {}
    @expenses.each_pair do |name, amount|
      balance[name] = per_person - amount
    end

    balance
  end


  def compute_payments

    balance = compute_balance


    debtors = balance.select {|name,amount| amount > 0}.to_a
    creditors = balance.select {|name,amount| amount < 0}.to_a

    payments = []

    while !debtors.empty? && !creditors.empty?

      debtor = debtors.last
      debtor_name = debtor.first
      debtor_amount = debtor.last

      creditor = creditors.last
      creditor_name = creditor.first
      creditor_amount = creditor.last.abs

      if creditor_amount > debtor_amount
        payments << Payment.new(debtor_name, creditor_name, debtor_amount)
        debtors.pop
        creditor[-1] += debtor_amount
      elsif creditor_amount < debtor_amount
        payments << Payment.new(debtor_name, creditor_name, creditor_amount)
        creditors.pop
        debtor[-1] -= creditor_amount
      else
        payments << Payment.new(debtor_name, creditor_name, creditor_amount)
        creditors.pop
        debtors.pop
      end


    end

    payments
  end

  def print_payments
    self.compute_payments.each do |payment|
      puts payment.human_readable
    end
  end

end

