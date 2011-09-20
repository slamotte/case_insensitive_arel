require "helper"

class TestAs < Test::Unit::TestCase
  should "work correctly in case-insensitive mode" do
    Arel::CaseInsensitive.case_insensitive = true
    should_be_like @users.project(@users[:name].as("n")).to_sql, "SELECT \"users\".\"name\" AS n FROM \"users\""
  end

  should "work correctly in case-sensitive mode" do
    Arel::CaseInsensitive.case_insensitive = false
    should_be_like @users.project(@users[:name].as("n")).to_sql, "SELECT \"users\".\"name\" AS n FROM \"users\""
  end
end