require 'helper'

class TestComparisons < Test::Unit::TestCase
  should "work correctly in case-insensitive mode" do
    Arel::CaseInsensitive.case_insensitive = true
    should_be_like @users.where(@users[:name].eq('Steve')).to_sql, "SELECT FROM \"users\" WHERE UPPER(\"users\".\"name\") = UPPER('Steve')"
    should_be_like @users.where(@users[:name].not_eq('Steve')).to_sql, "SELECT FROM \"users\" WHERE UPPER(\"users\".\"name\") != UPPER('Steve')"
    should_be_like @users.where(@users[:name].matches('Ste%')).to_sql, "SELECT FROM \"users\" WHERE UPPER(\"users\".\"name\") LIKE UPPER('Ste%')"
    should_be_like @users.where(@users[:name].does_not_match('Ste%')).to_sql, "SELECT FROM \"users\" WHERE UPPER(\"users\".\"name\") NOT LIKE UPPER('Ste%')"
    should_be_like @users.where(@users[:name].eq(@users[:name])).to_sql, "SELECT FROM \"users\" WHERE UPPER(\"users\".\"name\") = UPPER(\"users\".\"name\")"
    should_be_like @users.where(@users[:name].gteq('Steve')).to_sql, "SELECT FROM \"users\" WHERE UPPER(\"users\".\"name\") >= UPPER('Steve')"
    should_be_like @users.where(@users[:name].in(%w(Steve Barb))).to_sql, "SELECT FROM \"users\" WHERE UPPER(\"users\".\"name\") IN (UPPER('Steve'), UPPER('Barb'))"
    should_be_like @users.where(@users[:name].not_in(%w(Steve Barb))).to_sql, "SELECT FROM \"users\" WHERE UPPER(\"users\".\"name\") NOT IN (UPPER('Steve'), UPPER('Barb'))"
    should_be_like @users.where(@users[:name].matches_any(%w(Steve Barb))).to_sql, "SELECT FROM \"users\" WHERE (UPPER(\"users\".\"name\") LIKE UPPER('Steve') OR UPPER(\"users\".\"name\") LIKE UPPER('Barb'))"
    should_be_like @users.where(@users[:id].eq(1)).to_sql, "SELECT FROM \"users\" WHERE \"users\".\"id\" = 1"
    should_be_like @users.where(@users[:bool].eq(true)).to_sql, "SELECT FROM \"users\" WHERE \"users\".\"bool\" = 't'"
  end

  should "work correctly in case-sensitive mode" do
    Arel::CaseInsensitive.case_insensitive = false
    should_be_like @users.where(@users[:name].eq('Steve')).to_sql, "SELECT FROM \"users\" WHERE \"users\".\"name\" = 'Steve'"
    should_be_like @users.where(@users[:name].not_eq('Steve')).to_sql, "SELECT FROM \"users\" WHERE \"users\".\"name\" != 'Steve'"
    should_be_like @users.where(@users[:name].matches('Ste%')).to_sql, "SELECT FROM \"users\" WHERE \"users\".\"name\" LIKE 'Ste%'"
    should_be_like @users.where(@users[:name].does_not_match('Ste%')).to_sql, "SELECT FROM \"users\" WHERE \"users\".\"name\" NOT LIKE 'Ste%'"
    should_be_like @users.where(@users[:name].eq(@users[:name])).to_sql, "SELECT FROM \"users\" WHERE \"users\".\"name\" = \"users\".\"name\""
    should_be_like @users.where(@users[:name].gteq('Steve')).to_sql, "SELECT FROM \"users\" WHERE \"users\".\"name\" >= 'Steve'"
    should_be_like @users.where(@users[:name].in(%w(Steve Barb))).to_sql, "SELECT FROM \"users\" WHERE \"users\".\"name\" IN ('Steve', 'Barb')"
    should_be_like @users.where(@users[:name].not_in(%w(Steve Barb))).to_sql, "SELECT FROM \"users\" WHERE \"users\".\"name\" NOT IN ('Steve', 'Barb')"
    should_be_like @users.where(@users[:name].matches_any(%w(Steve Barb))).to_sql, "SELECT FROM \"users\" WHERE (\"users\".\"name\" LIKE 'Steve' OR \"users\".\"name\" LIKE 'Barb')"
    should_be_like @users.where(@users[:id].eq(1)).to_sql, "SELECT FROM \"users\" WHERE \"users\".\"id\" = 1"
    should_be_like @users.where(@users[:id].eq(1)).to_sql, "SELECT FROM \"users\" WHERE \"users\".\"id\" = 1"
    should_be_like @users.where(@users[:bool].eq(true)).to_sql, "SELECT FROM \"users\" WHERE \"users\".\"bool\" = 't'"
  end
end
