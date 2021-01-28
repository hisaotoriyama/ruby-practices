# !/usr/bin/env ruby
# frozen_string_literal: true

require './result'
require './data_open'
require './summary_calculator'
require './formatter'

module Wc
  class Main
    def initialize
      texts_in_line = Wc::DataOpen.new
      @file_names_in_line = texts_in_line.file_names_in_line
      @texts_in_line = texts_in_line.stdin_texts_in_line
      @with_l = texts_in_line.with_l
      @file_names = texts_in_line.file_names
    end

    def operate_wc
      if @file_names_in_line
        @summary_calculator_file = Wc::SummaryCalculator.new(@file_names_in_line)
        @formatter_file = Wc::Formatter.new(@file_names_in_line, @with_l)
        Wc::Result.new(@file_names, @summary_calculator_file, @formatter_file).show_result
      else
        @summary_calculator_stdin = Wc::SummaryCalculator.new(@texts_in_line)
        @formatter_stdin = Wc::Formatter.new(@texts_in_line, @with_l)
        Wc::Result.new(@file_names, @summary_calculator_stdin, @formatter_stdin).show_result
      end
    end
  end
end

main = Wc::Main.new
main.operate_wc
