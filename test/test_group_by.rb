require 'helper'

class TestGroupBy < Test::Unit::TestCase
  should "work correctly in case-insensitive mode" do
    Arel::CaseInsensitive.case_insensitive = true
    should_be_like @users.group(@users[:name]).to_sql, "SELECT FROM \"users\" GROUP BY UPPER(\"users\".\"name\")"
    should_be_like @users.group([@users[:id], @users[:name]]).to_sql, "SELECT FROM \"users\" GROUP BY \"users\".\"id\", UPPER(\"users\".\"name\")"
  end

  should "work correctly in case-sensitive mode" do
    Arel::CaseInsensitive.case_insensitive = false
    should_be_like @users.group(@users[:name]).to_sql, "SELECT FROM \"users\" GROUP BY \"users\".\"name\""
    should_be_like @users.group([@users[:id], @users[:name]]).to_sql, "SELECT FROM \"users\" GROUP BY \"users\".\"id\", \"users\".\"name\""
  end
end
