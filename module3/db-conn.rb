require 'mysql2'
require_relative "item"
require_relative 'categories'

def create_db_client
  client = Mysql2::Client.new(
    :host => 'localhost',
    :username => 'root',
    :password => '',
    :database => 'food_oms_db',
  )
  client
end


$client = create_db_client

def get_all_items
  rawData = $client.query('select * from items')
  items = Array.new
  rawData.each do |data|
   item = Item.new(data["id"], data["name"], data["price"])
   items.push(item)
  end

  items

end

def get_items(id)
  rawData = $client.query("
    SELECT * FROM items
    WHERE id= '#{id}'
    ")
    data = rawData.each
    data = data[0]
    item = Item.new(data["id"], data["name"], data["price"])
  return item

end

def get_all_categories
  rawData= $client.query('select * from categories')
  categories = Array.new
  rawData.each do |data|
    category = Categories.new(data["id"], data["name"])
    categories.push(category)
  end
  categories
end

def get_all_items_with_categories

  rawData= $client.query("
    select items.id, items.name, items.price, categories.name as category_name, categories.id as category_id
    from items
    left join item_categories on items.id = item_categories.item_id
    left join categories on item_categories.category_id = categories.id
    ")
    items = Array.new

  rawData.each do |data|
    category =Categories.new(data["category_id"], data["category_name"])
    item = Item.new(data["id"],data["name"], data["price"], category.name)
    items.push(item)
  end
  items

end

def create_new_item(name,price)

   $client.query("
       insert into items(name, price)
       values ('#{name}','#{price}')
     ")

end

def get_categories_item(id)

  items = get_all_items_with_categories
  items.each do |item|
    if item.id == id
      return item
    end
  end
end


def edit_items(id, name, price)
  $client.query("
    UPDATE items
    SET name = '#{name}',
    price ='#{price}'
    WHERE id = '#{id}'
    ")
  end

def delete_items(id)
  $client.query("
    DELETE FROM items WHERE id = '#{id}'
    ")
end

def items_cheaper_than(price)
  item_categories = $client.query(
    '
    select *
    from items
    where items.price < #{price}
    '
  )
end


 # cat = get_items(5)


 #

# category = get_all_categories
# puts (category.each)
#
# item_with_category = get_categories_item(5)
# puts (item_with_category)
