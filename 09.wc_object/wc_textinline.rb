# !/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

module Wc
  class TextsInLine
    attr_reader :file_names_in_text, :with_l

    def initialize
      opt = OptionParser.new
      opt.on('-l') { |v| @with_l = v }
      @file_names_in_text = opt.parse!(ARGV)
    end

    def read_stdin
      if file_names_in_text.empty?
        $stdin.readlines
      else
        file_names_in_text
      end
    end
  end
end
