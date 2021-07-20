require 'Mysql2'
class Data
  attr_accessor :key

  def view_data(rawData)
      datas = Array.new
      lists = Hash.new
      rawData.each do |data|
        data.each do |key, value|
          @key = value
        end

      end
  end

end

def create_db_client
  client = Mysql2::Client.new(
    :host => 'localhost',
    :username => 'dewi',
    :password => 'Tia2139',
    :database => 'food_oms_db',
  )
  client
end


$client = create_db_client
rawData = $client.query("
          select * from order_detail
          ")
data = view_data(rawData)
puts(data)
