

class Categories
@@flag = ""
     def initialize(param)
       @id = param["id"]
       @name = param["name"]
       @items = Connector.get_all_list_of("name", {'category'=> @name})
       @flag = ""
     end

     def get_id
       @id
     end

     def set_id(id)
       @id = id
     end

     def get_name
       @name
     end

     def set_name(name)
       @name = name
     end

     def get_items
       @items
     end

     def set_items(item_list: [])
       @items << item_list
     end

     def getter(num)
       lister = [@id, @name, @items]
       return lister[num]
     end

    def self.default_new_id
       last_id = Database.db_query_only("
                  SELECT MAX(id)
                  FROM categories
                  ")
        last_id = last_id.each
        last_id = last_id[0]['MAX(id)'] + 1
        @id = last_id
     end


     def create_new

       @id = self.class.default_new_id if @id.nil?

       check = Database.db_query_only("
              select * from categories
              where id = '#{@id}' or name ='#{@name}'")
        checker = check.each.empty?

          if checker == false
              puts('This Product Categories/ id has already been taken, please create
                another one or press edit button instead')
              @@flag = "duplicate"
          end

        return false unless valid?
        Database.db_query_only("
            insert into categories(id, name)
            values ('#{@id}', '#{@name}')
          ")

     end

     def edit
       self.set_price(0) if @price.nil?
       check = Categories.get_by_id(@id)
       @@flag = "not exist" if check == false
      return false unless valid?
       Database.db_query_only("
         UPDATE categories
         SET name = '#{@name}',
         WHERE id = '#{@id}'
         ")
       end

     def self.delete(id)
        data = self.get_by_id(id)
        check = (data == false)
        return false if check
          Database.db_query_only("
           DELETE FROM categories WHERE id = '#{id}'
            ")
            Database.db_query_only("
              DELETE FROM item_categories
              WHERE category_id = '#{id}'")
     end

       def valid?
         return false if @@flag == "not exist"
         return false if @@flag == "duplicate"
         return false if @name.nil?
         true
       end

       def self.get_all
         datas = Database.db_query(
                  "SELECT * FROM categories",
                  self)

       end

       def self.get_by_id(id)
         data = Database.db_query("
           SELECT * FROM categories
           WHERE id= '#{id}'
           ", self)

           check = (data[0].nil?)
           @@flag = "not exist" if check
           puts("This product ID doesn't exist, please press create button instead") if check
           return false if check
           return data[0]
       end

       def self.get_id_of(name)
         data = Database.db_query("
                SELECT * FROM Categories
                WHERE name = '#{name}'", self)
                check = (data[0].nil?)
                if check
                  @@flag = "not exist"
                  puts("This Categories doesn't exist, please press create button instead")
                  return false
                end
                return data[0]
       end
  end
