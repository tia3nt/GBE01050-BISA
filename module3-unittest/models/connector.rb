


class Connector
  @@table_join =[]
  @@tb_item_with_category = []
    def self.set_join_table(table_join, properties, param)
       properties = properties.to_s

      @@table_join = Database.db_query_only("
              CREATE TEMPORARY TABLE IF NOT EXISTS
              #{table_join} AS (
              SELECT #{properties}
              FROM #{param['mainTable']}
              JOIN #{param['table1']}
              ON #{param['on1']}
              JOIN #{param['table2']}
              ON #{param['on2']}
              )
              ")


    end

    def self.get_all_items_with_categories
          properties = 'items.name as name, categories.name as category'
          @@tb_item_with_category = self.set_join_table(
              'items_with_category',
              properties ,
              {'mainTable'=>'items',
                'table1'=>'item_categories',
                'on1'=> 'items.id = item_categories.item_id',
                'table2'=>'categories',
                'on2'=>'categories.id = item_categories.category_id'
              }
            )

            data = Database.db_query_only("
              select * from items_with_category")
              data = data.each
    end

    # search all property-item = name, within param{|key= category, value = category name to find|}
    # search all property-category = category, within param(|key= name, value = items name to find)
    def self.get_all_list_of(property, param)
      flag = ""
      tables = Database.db_query_only("
                show tables
                ")
      tables.each do |key, table|
        flag = 'exists' if table == 'items_with_category'
      end
      table = self.get_all_items_with_categories if flag != 'exists'
      lists = []
      param.each do |key, value|
      list = Database.db_query_only("
              select #{property}
              from items_with_category
              where #{key} = '#{value}'
              ")

          list.each do |data|
            data.each do |key, value|
              lists << value
            end
          end
      end
      lists
    end

    # def self.add_connector(item, category_id)
    #
    #   data = Database.db_query_only("
    #           SELECT * FROM
    #           item_categories
    #           WHERE
    #           item_id = #{item} AND category_id = #{category_id}")
    #   check = data.each.empty?
    #   return false unless check
    #       Database.db_query_only("
    #         INSERT INTO item_categories
    #         (item_id, category_id)
    #         VALUES
    #         ('#{item}', '#{category_id}')")
    # end

    def self.add_connector_by_ids(item, category)
      data = Database.db_query_only("
              SELECT * FROM
              item_categories
              WHERE
              item_id = #{item} AND category_id = #{category}")
      check = data.each.empty?
      return false unless check
          Database.db_query_only("
            INSERT INTO item_categories
            (item_id, category_id)
            VALUES
            ('#{item}', '#{category}')")
    end

    def self.add_connector(item, category_name)
      data = Categories.get_id_of(category_name)
      return false if data == false
      category_id = data.get_id
      data = Database.db_query_only("
              SELECT * FROM
              item_categories
              WHERE
              item_id = #{item} AND category_id = #{category_id}")
      check = data.each.empty?
      return false unless check
          Database.db_query_only("
            INSERT INTO item_categories
            (item_id, category_id)
            VALUES
            ('#{item}', '#{category_id}')")
    end

    def self.delete(name_id, category_id)
      Database.db_query_only("
        DELETE FROM
        item_categories
        WHERE item_id = '#{name_id}' AND
        category_id = '#{category_id}'")
    end

    def self.delete_all_item(id)
      Database.db_query_only("
        DELETE FROM
        item_categories
        WHERE item_id = '#{id}'")
    end

    def self.delete_all_category(id)
      Database.db_query_only("
        DELETE FROM
        item_categories
        WHERE category_id = '#{id}'")
      end

end
