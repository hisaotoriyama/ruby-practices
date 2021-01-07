# !/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'
require 'active_support/core_ext/array/grouping'
require './ls_filesexpression'

class Main
  def ls_command
    params = ARGV.getopts('a', 'l', 'r')
    expression = FilesExpression.new(params)
    expression.express_files
  end
end

main = Main.new
main.ls_command
