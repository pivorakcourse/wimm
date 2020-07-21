user = User.first

2_000.times do |day|
  10.times do |n|
    account = user.accounts.sample
    category = user.categories.sample
    random_amount = rand(1..1000)
    print '.'

    RecordCreateService.new({account: account, category: category, amount: random_amount, created_at: n.days.ago}, user).call
  end
end
