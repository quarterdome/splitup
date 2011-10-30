require_relative 'splitup'



puts "ski trip:"

ex = Expenses.new(
    :yura => 62.37 + 95,
    :matvey =>20,
    :grisha => 50,
    :zhenya => 59 + 10
)

ex.print_payments


puts "sequoia trip:"

ex = Expenses.new(
    :yura => 50 + 50 + 14,
    :grisha => 25 + 18,
    :max => 0,
    :matvey => 20 + 54
)

ex.print_payments