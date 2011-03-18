require "helper"

class TestJoins < Test::Unit::TestCase
  should "work correctly in case-insensitive mode" do
    Arel::CaseInsensitive.case_insensitive = true
    should_be_like @users.join(@photos).on(@users[:name].eq(@photos[:user_name])).to_sql, "SELECT FROM \"users\" INNER JOIN \"photos\" ON UPPER(\"users\".\"name\") = UPPER(\"photos\".\"user_name\")"
    should_be_like @users.join(@users2).on(@users[:name].eq(@users2[:name])).to_sql, "SELECT FROM \"users\" INNER JOIN \"users\" \"u2\" ON UPPER(\"users\".\"name\") = UPPER(\"u2\".\"name\")"
  end

  should "work correctly in case-sensitive mode" do
    Arel::CaseInsensitive.case_insensitive = false
    should_be_like @users.join(@photos).on(@users[:name].eq(@photos[:user_name])).to_sql, "SELECT FROM \"users\" INNER JOIN \"photos\" ON \"users\".\"name\" = \"photos\".\"user_name\""
    should_be_like @users.join(@users2).on(@users[:name].eq(@users2[:name])).to_sql, "SELECT FROM \"users\" INNER JOIN \"users\" \"u2\" ON \"users\".\"name\" = \"u2\".\"name\""
  end
end