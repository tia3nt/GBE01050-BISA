class Temporary
  def self.template_item
    Database.db_query_only("
      Create temporary table if not EXISTS
      table_edit (
      id INT,
      name varchar(50),
      price INT,
      categories text,
      )
      ")
      Database.db_query_only("
        CREATE TEMPORARY TABLE IF NOT EXISTS
        table_counterpart
        id INT,
        name VARCHAR(50)
        ")
  end

  def self.set_counterpart(params)
    Database.db_query_only("
      CREATE TEMPORARY TABLE IF NOT EXISTS
      table_counterpart
      id INT,
      name VARCHAR(50)
      ")
    end

end
