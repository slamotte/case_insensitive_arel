require 'helper'

class TestProjects < Test::Unit::TestCase
  should "work correctly in case-insensitive mode" do
    Arel::CaseInsensitive.case_insensitive = true
    should_be_like @users.project(Arel.sql('*')).to_sql, "SELECT * FROM \"users\""
    should_be_like @users.project('*').to_sql, "SELECT * FROM \"users\""
    should_be_like @users.project('"users".*').to_sql, "SELECT \"users\".* FROM \"users\""
    should_be_like @users.project(@users[:name]).to_sql, "SELECT \"users\".\"name\" FROM \"users\""
    should_be_like @users.project(@users[:name]).where(@users[:name].eq(@users[:name])).to_sql, "SELECT \"users\".\"name\" FROM \"users\" WHERE UPPER(\"users\".\"name\") = UPPER(\"users\".\"name\")"
  end

  should "work correctly in case-sensitive mode" do
    Arel::CaseInsensitive.case_insensitive = false
  end
end
