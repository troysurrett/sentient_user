require 'rubygems'
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'sentient_user'

class Test::Unit::TestCase
end

class Person
  include SentientUser
end

class User
  include SentientUser
end

class AnonymousUser < User ; end

def check_spelling_in_file(path_relative_to_gem_root)
  path = "#{File.dirname(__FILE__)}/../#{path_relative_to_gem_root}"
  begin
    aspell = "aspell list --add-extra-dicts=#{File.dirname(__FILE__)}/word_list.rws"
    aspell_output = `cat #{path} | #{aspell}`
  rescue => err
    warn "You probably don't have aspell. On mac: brew install aspell --lang=en"
    raise err
  end
  misspellings = aspell_output.split($/)
  assert_equal [], misspellings
end
