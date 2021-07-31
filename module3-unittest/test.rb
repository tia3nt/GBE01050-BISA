#require 'sinatra'
require 'mysql2'

require "./db/db-conn"

require "./models/item"
require "./models/categories"
require "./models/connector"

require "./controllers/control_item"
require "./controllers/control_category"
require "./controllers/Control"

require 'dotenv/load'


PUBLIC_DIR = File.join(File.dirname(__FILE__), 'static')


params="{http://localhost:4567/item/delete/20?name=Nasi+goreng+teri+medan&price=25000&button_press=Delete+this+Item&hist=%7B%7D&counterpart_add=&cp_add=%5B%5D}///"

puts(params["button_press"])
