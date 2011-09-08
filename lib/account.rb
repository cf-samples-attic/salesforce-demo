get '/accounts' do
  @controller = 'accounts'
  @object_type = 'account'
  @data = show_all 'account'
  @title = "Accounts"
  haml :show_all
end

get '/accounts.json' do
  response = show_all 'account', {:raw => true}
  response
end

get '/account/:account_id' do |account_id|
  @object_type = 'account'
  @item_id = account_id
  @item_data = show_one 'account', account_id

  haml :show_one
end

get '/account/raw/:account_id.json' do |account_id|
  response = show_one 'account', account_id, {:raw => true}
  response
end

get '/accounts/create' do
  @title = "Account Creation"
  @messages = []
  @cart.each do |company|
    account = {'Name' => "#{company['name']}"}
    id = create 'account', account.to_json
    @messages << "Created account <a href='/account/#{id}'>#{id}</a>"
  end

  haml :info
end

get '/account/edit/:account_id' do |account_id|
  @messages = []
   if (params.has_key? 'name' && params['name'] )
     account = {'Name' => params['name']}
     @messages << update('account', account_id, account.to_json)
     @messages << "Updated account <a href='/account/#{account_id}'>#{account_id}</a>"
  end
  haml :info
end

get '/account/delete/:account_id' do |account_id|
  @messages = []
  if (account_id)
     @messages << "Deleting #{account_id}"
     @messages << delete('account', account_id)
  else
    @messages << request.inspect
  end
  haml :info
end


