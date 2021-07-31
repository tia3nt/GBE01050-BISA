
class Control_category

  @@cp_mode = "item"
  @@this_mode = "category"
  @@wd = ['3%', '40%', '35%']
  @@header = ["ID", "Name", "Items"]
  @@cp_db = Item.get_all
  @@getter_number = 2
  @@newId = Categories.default_new_id
  @@hist = Hash.new
  @@cp_add = Array.new

        def self.get_all

        model = "Category"
        datas = Categories.get_all
        route = "category"
        cp_route = '/'
        renderer = ERB.new(File.read("./views/main.erb"))
        renderer.result(binding)
      end

      def self.get_create

          data = "Category"
          route = "Category"
          names = ["name"]
          datas = Categories.get_all
          renderer= ERB.new(File.read("./views/create.erb"))
          renderer.result(binding)
      end

      def self.get_edit(params)
        methode_used = 'put'
        data = Categories.get_by_id(params["id"])
        title = data.get_name
        counterpart = data.get_items

        prev_data = Hash.new
        prev_data.store("name", data.get_name)
        notneeded = false
        @@hist = {}
        @@cp_add = []
        header = ["name"]
        model = 'categories'
        act = 'Edit'
        route = 'update'
        button = 'Edit Category'
        renderer = ERB.new(File.read("./views/edit.erb"))
        renderer.result(binding)
      end

      def self.get_update(params)
        methode_used = 'put'
        data = Categories.get_by_id(params["id"])
        title = data.get_name
        counterpart = data.get_items
        @@hist.store("name", params["name"])
        @@hist.store("counterpart", params["counterpart"])
        @@cp_add << params["counterpart_add"] unless @@cp_add.include? params["counterpart_add"]
        prev_data = @@hist
        notneeded = false
        header = ["name"]
        model = 'category'
        act = 'Edit'
        button = 'Edit Category'
        route = 'update'
        renderer = ERB.new(File.read("./views/edit.erb"))
        renderer.result(binding)
      end

      def self.get_show(params)

        data = Categories.get_by_id(params["id"])
        renderer = ERB.new(File.read("./views/show.erb"))
        renderer.result(binding)
      end

      def self.get_delete(params)
        methode_used = 'delete'
        data = Categories.get_by_id(params["id"])
        title = data.get_name
        @@hist = {}
        notneeded = true
        prev_data=Hash.new
        prev_data.store("name", data.get_name)
        counterpart = data.get_items
        header = ["name"]
        model = "category"
        act = "Delete"
        route = "delete"
        button = "Delete this Category"
        renderer = ERB.new(File.read("./views/edit.erb"))
        renderer.result(binding)
      end

      def self.addCounterPartSelection(params)
        id = params["id"]
        name = params["name"]

        items = params["items"]
        counterpart = params["counterpart"]
        @@cp_add << params["cp_add"]
        counterpart_add = params["counterpart_add"]

        @@cp_add << counterpart_add
        renderer = ERB.new(File.read("./views/edit.erb"))
        renderer.result(binding)

      end


      def self.update(params)

        id = params['id']
        name = params['name']

        items1 = params['counterpart']
        items2 = params['counterpart_add']
        real_data =Categories.get_by_id(id)
        items_real = real_data.get_items
        prepare = Categories.new({"id"=>id, "name"=>name})
        prepare.edit
        unless items_real.nil?
          items_real.each do |list|
            next if items1.include? list
            item_id = Item.get_id_of(list)
            Connector.delete(id, cat_id)
          end
        end

        unless item2.nil?
          items2.each do |list|
            Connector.add_connector(id,list)
          end
        end

      end

      def self.create(params)
        id = params["id"]
        name = params["name"]
        item = params["item"]
        data = Categories.new({"name"=> name})
        data.create_new

        item_list = params["item"]
        item_list = item_list.split(',')
        unless item_list.nil?
          item_list.each do |list|
            Connector.add_connector_by_ids(list, id)
          end
        end

      end

    def self.delete(params)
      id = params["ID"]

      data = Categories.get_by_id(id)
      data.delete(id)

      Connector.delete_all_category(id)

    end



end
