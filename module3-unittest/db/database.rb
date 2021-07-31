
class Database



def create_db_client

  client = Mysql2::Client.new(
    :host => 'localhost',
    :username => ENV['DB_Username'],
    :password => ENV['DB_Password'], # eliminate quotation mark from ENV result
    :database => ENV['DB_Food']#'food_oms_db'
  )

end

  @@client = self.new.create_db_client

def self.db_query_only(query_line)
  rawData = @@client.query(query_line)
end

def self.db_query(query_line, dataClass)

  rawData = @@client.query(query_line)
  lists = Array.new
  rawData.each do |data|
    list = dataClass.new(data)
    lists << list
  end

  lists
end

def self.preparation(query_line)
  data = @@client.prepare(query_line)
end

end
