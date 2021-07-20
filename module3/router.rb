require 'sinatra'
require_relative 'db-conn'

items = get_all_items

get '/' do
items = get_all_items
  erb :index, locals:{
    items: items
  }
end


get '/items/new' do
  erb :create
end

post '/items/create' do
  name=params['name']
  price=params['price']
  create_new_item(name,price)
  redirect '/'
end

get '/items/edit/:id' do

  item = get_items(params['id'])
  erb :edit, locals:{
      item: item,
      act: 'Edit',
      route: 'update',
      button: 'Edit Item',
  }

end

get '/items/show/:id' do
  num = params['id'].to_i
  item = get_categories_item(num)
  erb :show, locals:{
    item: item
  }
end

post '/items/update/:id' do
  name = params['items_name']
  price = params['items_price']
  id = params['id']
  edit_items(id, name, price)
  redirect '/'
end

get '/items/delete/:id' do
  #num = params['id'].to_i
  item = get_items(params['id'])
  erb :edit, locals:{
    item: item,
    act: 'Delete',
    route: 'delete',
    button: 'Delete this Item'
  }

end

post '/items/delete/:id' do
  delete_items(params['id'])
  redirect '/'
end
