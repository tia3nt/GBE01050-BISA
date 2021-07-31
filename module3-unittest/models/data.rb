require 'mysql2'
require '../db/db-conn'


class Data
 @@category = nil
 @@flag = ""

     def default_new_id(PK, table)
       last_id = Database.db_query_only("
                  SELECT MAX(#{PK})
                  FROM #{table}
                  ")
        last_id = last_id.each
        last_id = last_id[0]["MAX(#{PK})"] + 1
        self.set_id(last_id)
     end


     def create_new

       self.set_price(0) if @price.nil?
       @id = self.default_new_id if @id.nil?


       check = Database.db_query_only("
              select * from items
              where id = '#{@id}' or name ='#{@name}'")
        checker = check.each.empty?

          if checker == false
              puts('This Product name/ id has already been taken, please create
                another one or press edit button instead')
              @@flag = "duplicate"
          end

        return false unless valid?
        Database.db_query_only("
            insert into items(id, name, price)
            values ('#{@id}', '#{@name}', '#{@price}')
          ")

        #   unless @category.nil?
        #     category = get_category_of(@category)
        #     cek = @client.query("
        #           select * from item_categories
        #           where
        #           item_id = '#{@id}' and category_id ='#{category.get_id}'
        #           ")
        #     if cek.empty?
        #           @client.query("
        #             INSERT INTO item_categories
        #             (item_id, category_id)
        #             VALUES
        #             ('#{@id}', '#{category.get_id}')
        #             ")
        #     end
        #   end
     end

     def edit
       self.set_price(0) if @price.nil?
       check = Item.get_by_id(@id)
       @@flag = "not exist" if check == false
      return false unless valid?
       Database.db_query_only("
         UPDATE items
         SET name = '#{@name}',
         price ='#{@price}'
         WHERE id = '#{@id}'
         ")
       end

     def self.delete(id)
        data = self.get_by_id(id)
        check = (data == false)
        return false if check
          Database.db_query_only("
           DELETE FROM items WHERE id = '#{id}'
            ")
     end
     #
       def valid?
         return false if @@flag == "not exist"
         return false if @@flag == "duplicate"
         return false if @name.nil?
         true
       end

       def self.get_all
         datas = Database.db_query("
                  SELECT * FROM items", Item)

       end

       def self.get_by_id(id)
         data = Database.db_query("
           SELECT * FROM items
           WHERE id= '#{id}'
           ", self)

           check = (data[0].nil?)
           @@flag = "not exist" if check
           puts("This product ID doesn't exist, please press create button instead") if check
           return false if check
           return data[0]
       end
     #
     #   def self.get_all_items_with_categories
     #
     #     rawData= $client.query("
     #       select items.id, items.name, items.price, categories.name as category_name, categories.id as category_id
     #       from items
     #       left join item_categories on items.id = item_categories.item_id
     #       left join categories on item_categories.category_id = categories.id
     #       ")
     #       items = Array.new
     #
     #     rawData.each do |data|
     #       category =Categories.new(data["category_id"], data["category_name"])
     #       item = Item.new({data["id"],data["name"], data["price"], category.name})
     #       items.push(item)
     #     end
     #     items
     #
     #   end
     #
     #
     #    def self.get_categories_item(id)
     #
     #     items = get_all_items_with_categories
     #     items.each do |item|
     #       if item.id == id
     #         return item
     #       end
     #     end
     #   end
     #
     #
     #    def self.items_cheaper_than(price)
     #      item_categories = $client.query(
     #        '
     #        select *
     #        from items
     #        where items.price < #{price}
     #        '
     #      )
     #    end
     #

end
