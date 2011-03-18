require 'helper'

class TestComparisons < Test::Unit::TestCase
  should "work correctly in case-insensitive mode" do
    Arel::CaseInsensitive.case_insensitive = true
    should_be_like @users.where(@users[:name].eq('Steve')).to_sql, "SELECT FROM \"users\" WHERE UPPER(\"users\".\"name\") = 'STEVE'"
    should_be_like @users.where(@users[:name].not_eq('Steve')).to_sql, "SELECT FROM \"users\" WHERE UPPER(\"users\".\"name\") != 'STEVE'"
    should_be_like @users.where(@users[:name].matches('Ste%')).to_sql, "SELECT FROM \"users\" WHERE UPPER(\"users\".\"name\") LIKE 'STE%'"
    should_be_like @users.where(@users[:name].does_not_match('Ste%')).to_sql, "SELECT FROM \"users\" WHERE UPPER(\"users\".\"name\") NOT LIKE 'STE%'"
    should_be_like @users.where(@users[:name].eq(@users[:name])).to_sql, "SELECT FROM \"users\" WHERE UPPER(\"users\".\"name\") = UPPER(\"users\".\"name\")"
    should_be_like @users.where(@users[:name].gteq('Steve')).to_sql, "SELECT FROM \"users\" WHERE UPPER(\"users\".\"name\") >= 'STEVE'"
    should_be_like @users.where(@users[:name].in(['Steve', 'Barb'])).to_sql, "SELECT FROM \"users\" WHERE UPPER(\"users\".\"name\") IN ('STEVE', 'BARB')"
    should_be_like @users.where(@users[:name].not_in(['Steve', 'Barb'])).to_sql, "SELECT FROM \"users\" WHERE UPPER(\"users\".\"name\") NOT IN ('STEVE', 'BARB')"
    should_be_like @users.where(@users[:name].matches_any(['Steve', 'Barb'])).to_sql, "SELECT FROM \"users\" WHERE (UPPER(\"users\".\"name\") LIKE 'STEVE' OR UPPER(\"users\".\"name\") LIKE 'BARB')"
  end

  should "work correctly in case-sensitive mode" do
    Arel::CaseInsensitive.case_insensitive = false
    should_be_like @users.where(@users[:name].eq('Steve')).to_sql, "SELECT FROM \"users\" WHERE \"users\".\"name\" = 'Steve'"
    should_be_like @users.where(@users[:name].not_eq('Steve')).to_sql, "SELECT FROM \"users\" WHERE \"users\".\"name\" != 'Steve'"
    should_be_like @users.where(@users[:name].matches('Ste%')).to_sql, "SELECT FROM \"users\" WHERE \"users\".\"name\" LIKE 'Ste%'"
    should_be_like @users.where(@users[:name].does_not_match('Ste%')).to_sql, "SELECT FROM \"users\" WHERE \"users\".\"name\" NOT LIKE 'Ste%'"
    should_be_like @users.where(@users[:name].eq(@users[:name])).to_sql, "SELECT FROM \"users\" WHERE \"users\".\"name\" = \"users\".\"name\""
    should_be_like @users.where(@users[:name].gteq('Steve')).to_sql, "SELECT FROM \"users\" WHERE \"users\".\"name\" >= 'Steve'"
    should_be_like @users.where(@users[:name].in(['Steve', 'Barb'])).to_sql, "SELECT FROM \"users\" WHERE \"users\".\"name\" IN ('Steve', 'Barb')"
    should_be_like @users.where(@users[:name].not_in(['Steve', 'Barb'])).to_sql, "SELECT FROM \"users\" WHERE \"users\".\"name\" NOT IN ('Steve', 'Barb')"
    should_be_like @users.where(@users[:name].matches_any(['Steve', 'Barb'])).to_sql, "SELECT FROM \"users\" WHERE (\"users\".\"name\" LIKE 'Steve' OR \"users\".\"name\" LIKE 'Barb')"
  end
end
