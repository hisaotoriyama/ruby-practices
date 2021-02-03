# !/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

module Wc
  class InputProcessor
    attr_reader :with_l, :stdin_texts_in_line, :file_names_in_line

    def initialize
      opt = OptionParser.new
      opt.on('-l') { |v| @with_l = v }
      @with_l = with_l
      @file_names_in_line = opt.parse!(ARGV)
      if @file_names_in_line.empty?
        @stdin_texts_in_line = $stdin.readlines
      else
        @file_names_in_line
      end
    end
  end
end
