require_relative 'splitup'

describe Expenses do

  before(:each) do
    @expenses = {
        :yura => 100,
        :matvey => 20,
        :grisha => 50,
        :zhenya => 30,
    }

  end

  it 'should compute balance' do
    ex = Expenses.new(@expenses)

    ex.compute_balance.should == {
      :yura => -50,
      :matvey => 30,
      :grisha => 0,
      :zhenya => 20
    }
  end

  it 'should compute payments' do

    ex = Expenses.new(@expenses)

    payments = ex.compute_payments

    payments.size.should == 2

    payments[0].sender.should == :zhenya
    payments[0].receiver.should == :yura
    payments[0].amount.should == 20

    payments[1].sender.should == :matvey
    payments[1].receiver.should == :yura
    payments[1].amount.should == 30

  end

end