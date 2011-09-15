require "helper"

class TestJoins < Test::Unit::TestCase
  should "work correctly in case-insensitive mode" do
    Arel::CaseInsensitive.case_insensitive = true
    should_be_like @users.join(@products).on(@users[:name].eq(@products[:name])).to_sql, "SELECT FROM \"users\" INNER JOIN \"products\" ON UPPER(\"users\".\"name\") = UPPER(\"products\".\"name\")"
    should_be_like @users.join(@users2).on(@users[:name].eq(@users2[:name])).to_sql, "SELECT FROM \"users\" INNER JOIN \"users\" \"u2\" ON UPPER(\"users\".\"name\") = UPPER(\"u2\".\"name\")"
  end

  should "work correctly in case-sensitive mode" do
    Arel::CaseInsensitive.case_insensitive = false
    should_be_like @users.join(@products).on(@users[:name].eq(@products[:name])).to_sql, "SELECT FROM \"users\" INNER JOIN \"products\" ON \"users\".\"name\" = \"products\".\"name\""
    should_be_like @users.join(@users2).on(@users[:name].eq(@users2[:name])).to_sql, "SELECT FROM \"users\" INNER JOIN \"users\" \"u2\" ON \"users\".\"name\" = \"u2\".\"name\""
  end
end