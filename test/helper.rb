require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'arel'
require 'case_insensitive_arel'
require 'pp'

require 'support/fake_record'
Arel::Table.engine = Arel::Sql::Engine.new(FakeRecord::Base.new)

class Test::Unit::TestCase
  def setup
    @users = Arel::Table.new(:users)
    @users2 = @users.alias('u2')
    @photos = Arel::Table.new(:photos)
  end

  def should_be_like(a, b)
    assert_equal b.gsub(/\s+/, ' ').strip, a.gsub(/\s+/, ' ').strip
  end
end
