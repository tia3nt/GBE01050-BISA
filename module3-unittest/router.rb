require 'sinatra'
require 'mysql2'

require "./db/database"

require "./models/item"
require "./models/categories"
require "./models/connector"

require "./controllers/control_item"
require "./controllers/control_category"
require 'dotenv/load'

PUBLIC_DIR = File.join(File.dirname(__FILE__), 'static')

get '/' do
  Control_item.get_all
end

get '/category/main' do
  Control_category.get_all
end



get '/item/new' do
  Control_item.get_create
end

get '/category/new' do
    Control_category.get_create
end


post '/item/create' do
Control_item.create(params)
redirect '/'
end

post '/category/create' do
Control_category.create(params)
redirect '/category/main'
end

put '/item/edit/:id?:add_counterpart?' do
  Control_item.addCounterPartSelection(params)
  redirect "/items/edit/#{params["id"]}"
end

put '/category/edit/:id?:add_counterpart?' do
  Control_item.addCounterPartSelection(params)
  redirect "/items/edit/#{params["id"]}"
end

get '/item/edit/:id' do
  Control_item.get_edit(params)
end

get '/category/edit/:id' do
  Control_category.get_edit(params)
end

get '/item/show/:id' do
  Control_item.get_show(params)
end

get '/category/show/:id' do
  Control_category.get_show(params)
end

get '/item/update/:id' do
  Control_item.get_update(params)
end

get '/category/update/:id' do
  Control_category.get_update(params)
end

put '/item/update/:id' do
  button =params["button_press"].downcase
  case button
  when button["add"] == "add"
    Control_item.get_update(params)
  when button["edit"]
    Control_item.update(params)
    redirect '/'
  when button["delete"] == "delete"
    Control_item.delete(params)
    redirect '/'
  end
end

put '/category/update/:id' do
  button =params["button_press"].downcase
  case button
  when button["add"] == "add"
    Control_category.get_update(params)
  when button["edit"]
    Control_category.update(params)
    redirect '/category/main'
  when button["delete"] == "delete"
    Control_category.delete(params)
    redirect '/category/main'
  end
end


get '/item/delete/:id' do
  Control_item.get_delete(params)

end

get '/category/delete/:id' do
  Control_category.get_delete(params)
end

delete '/item/delete/:id' do
  Control_item.delete(params)
  redirect '/'
end


delete '/category/delete/:id' do
  Control_category.delete(params)
  redirect '/category/main'
end
