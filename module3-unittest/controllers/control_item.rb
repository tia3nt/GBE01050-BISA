
class Control_item

@@cp_mode = "category"
@@this_mode = "item"
@@wd = ['3%', '40%', '10%', '35%']
@@header = ["ID", "Name", "Price", "Categories"]
@@cp_db = Categories.get_all
@@getter_number = 3
@@newId = Item.default_new_id
@@hist = Hash.new
@@cp_add =Array.new


      def self.get_all

        datas = Item.get_all
        model = "Item"
        route = "item"
        cp_route = '/category/main'
        renderer = ERB.new(File.read("./views/main.erb"))
        renderer.result(binding)
      end

      def self.get_create

          data = "Item"
          route = "item"
          names = ["name", "price"]
          renderer= ERB.new(File.read("./views/create.erb"))
          renderer.result(binding)
      end

      def self.get_edit(params)
        methode_used = 'put'
        data = Item.get_by_id(params["id"])
        title = data.get_name
        counterpart = data.get_category
        notneeded = false
        @@hist = {}
        @@cp_add = []
        prev_data=Hash.new
        prev_data.store("name", data.get_name)
        prev_data.store("price", data.get_price)
        header = ["name", "price"]
        model = 'item'
        act = 'Edit'
        route = 'update'
        button = 'Edit Item'
        renderer = ERB.new(File.read("./views/edit.erb"))
        renderer.result(binding)
      end

      def self.get_update(params)
        methode_used = 'put'
        data = Item.get_by_id(params["id"])
        title = data.get_name
        notneeded = false
        counterpart = data.get_category
        @@hist.store("name", params["name"])
        @@hist.store("price", params["price"])
        @@hist.store("counterpart", params["counterpart"])
        @@cp_add << params["counterpart_add"] unless @@cp_add.include? params["counterpart_add"]
        prev_data = @@hist
        header = ["name", "price"]
        model = 'item'
        act = 'Edit'
        route = 'update'
        button = 'Edit Item'

          renderer = ERB.new(File.read("./views/edit.erb"))
          renderer.result(binding)
        end


      def self.get_show(params)

        data = Item.get_by_id(params["id"])
        renderer = ERB.new(File.read("./views/show.erb"))
        renderer.result(binding)
      end

      def self.get_delete(params)
        methode_used = 'delete'
        data = Item.get_by_id(params["id"])
        title = data.get_name
        prev_data=Hash.new
        prev_data.store("name", data.get_name)
        prev_data.store("price", data.get_price)
        counterpart = data.get_category
        @@hist = {}
        notneeded = true
        header = ["name", "price"]
        model = 'item'
        data = Item.get_by_id(params["id"])
        act = "Delete"
        route = "delete"
        button = "Delete this Item"
        renderer = ERB.new(File.read("./views/edit.erb"))
        renderer.result(binding)
      end

      def self.addCounterPartSelection(params)
        id = params["id"]
        name = params["name"]
        price = params["price"]
        category = params["categories"]
        counterpart = params["counterpart"]
        @@cp_add = params["cp_add"]
        counterpart_add = params["counterpart_add"]

        @@cp_add << counterpart_add
        renderer = ERB.new(File.read("./views/edit.erb"))
        renderer.result(binding)

      end



      def self.update(params)

        id = params['id']
        name = params['name']
        price = params['price']
        category1 = params['counterpart']
        category2 = params['counterpart_add']
        prev_data = Item.get_by_id(id)
        category_real = prev_data.get_category
        prepare = Item.new({"id"=>id, "name"=>name, "price" => price})
        prepare.edit

        category_real.each do |list|
          next if category1.include? list
          cat_id = Categories.get_id_of(list)
          Connector.delete(id, cat_id)
        end

        category2.each do |list|
          Connector.add_connector(id,list)
        end


      end

      def self.create(params)
        id = params["id"]
        name = params["name"]
        price = params["price"]
        item = Item.new({"name"=> name, "price"=>price})
        item.create_new

        category_list = params["category"]
        category_list = category_list.split(",")
        unless category_list.nil?
          category_list.each do |list|
            Connector.add_connector_by_ids(id, list)
          end
        end

    end

    def self.delete(params)
      id = params["ID"]

      data = Item.get_by_id(id)
      data.delete(id)

      Connector.delete_all_item(id)

    end




end
