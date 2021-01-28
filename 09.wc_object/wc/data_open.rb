# !/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

module Wc
  class DataOpen
    attr_reader :file_names, :with_l, :stdin_texts_in_line, :file_names_in_line

    def initialize
      opt = OptionParser.new
      opt.on('-l') { |v| @with_l = v }
      @with_l = with_l
      file_names = opt.parse!(ARGV)
      @file_names = file_names
      if file_names.empty?
        stdin_texts_in_line = $stdin.readlines
      else
        file_names_in_line = file_names
      end
      @stdin_texts_in_line = stdin_texts_in_line
      @file_names_in_line = file_names_in_line
    end
  end
end
