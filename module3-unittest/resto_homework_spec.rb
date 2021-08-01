require_relative 'test_helper'

require_relative "router"

#

#
before(:all) do
$client_mock = double
allow(Mysql2::Client).to receive(:query).and_return($client_mock)

$database_mock = double("Database")
allow(Database).to receive(:new).and_return($database_mock)

end

RSpec.describe Item do
  describe '#create' do
    context "validate input data" do
      it "should check validation of the input" do
        params ={"price"=>"2500"}
        item = Item.new(params)
        cek = item.valid?
        expect(cek).to be_falsey
      end

    end
  end
  # context 'mock query vs actual database db_query_only' do
  #     it "should able to list all tables exactly the same as actual database will do" do
  #
  #
  #       expect($mock_db).to receive(:query).with("
  #         SELECT * FROM items ")
  #
  #         data = Item.get_all
  #
  #         expect(data).to eq($mock_db)
  #     end
  #
  #   end
end



# describe Controller_item do
#   describe '#create new item' do
#     context "When given valid input"
#     it "should post the item and its choosen categories"
#     params = {
#       "name" => "Nasi Padang Istimewa",
#       "price" => 25000,
#       "cp_mode" => ["1", "3"]
#     }
#     Controller_item.create(params)
#
#     db_item = Database.db_query_only("select id from items where
#       name = #{params["Name"]} and
#       price = #{params["price"]}"
#     ")
#
#
#     db_category = Database.db_query_only("
#       select item_id from item_category where
#       item_id = '#{db_item[0]}'
#           ")
#     check1 = db_item.empty
#     params['cp_mode'] do |list|
#       check2 = db_item.each.include? list
#       check2 =
#
#
#     expect(check1).to be_falsey
    # end
#   end
# end
