require 'yobou'
require 'mysql2'

TEST_DATABASE_CONFIG = {
  host: '127.0.0.1',
  username: 'root',
  password: 'root'
}
TEST_DATABASE_NAME = 'yobou_test'
TEST_DATABASE_LOAD_FILENAME = './spec/resources/test.sql'
TEST_DATABASE_DUMP_FILENAME = './tmp/test.sql'

@mysql_client = nil

RSpec.describe Yobou do

  before :each do
    reset_db
  end

  context "#load" do

    it "returns an unsuccessful Response object in case of failure" do
      response = Yobou.load(database: 'wrong_db', filename: TEST_DATABASE_LOAD_FILENAME, **TEST_DATABASE_CONFIG)
      expect(response.success).to be_falsey
    end

    it "returns a successful Response object in case of success" do
      response = Yobou.load(database: TEST_DATABASE_NAME, filename: TEST_DATABASE_LOAD_FILENAME, **TEST_DATABASE_CONFIG)
      expect(response.success).to be_truthy
    end

  end

  context "#dump" do

    it "returns an unsuccessful Response object in case of failure" do
      response = Yobou.dump(database: 'wrong_db', filename: TEST_DATABASE_DUMP_FILENAME, **TEST_DATABASE_CONFIG)
      expect(response.success).to be_falsey
    end

    it "returns a successful Response object in case of success" do
      response = Yobou.dump(database: TEST_DATABASE_NAME, filename: TEST_DATABASE_DUMP_FILENAME, **TEST_DATABASE_CONFIG)
      expect(response.success).to be_truthy
    end

  end

end

private

def reset_db
  @mysql_client ||= Mysql2::Client.new(TEST_DATABASE_CONFIG)
  @mysql_client.query("DROP DATABASE IF EXISTS #{TEST_DATABASE_NAME}")
  @mysql_client.query("CREATE DATABASE #{TEST_DATABASE_NAME}")
  File.delete(TEST_DATABASE_DUMP_FILENAME) if File.file?(TEST_DATABASE_DUMP_FILENAME)
end
