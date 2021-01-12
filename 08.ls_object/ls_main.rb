# !/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'
require './ls_filesexpression'

module Ls
  class Main
    def ls_command
      params = ARGV.getopts('a', 'l', 'r')
      expression = Ls::FilesExpression.new(params)
      expression.express_files
    end
  end
end

main = Ls::Main.new
main.ls_command
