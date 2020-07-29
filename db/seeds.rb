user = User.first

1_000.times do |month|
  30.times do |n|
    account = user.accounts.sample
    category = user.categories.sample
    random_amount = rand(1..1000)
    print '.'

    CreateRecordService.new({account: account, category: category, amount: random_amount, created_at: n.months.ago}, user).call
  end
end
