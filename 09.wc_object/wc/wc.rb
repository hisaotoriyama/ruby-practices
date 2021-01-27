# !/usr/bin/env ruby
# frozen_string_literal: true

require './result'
require './texts_in_line'
require './summary_calculator'
require './formatter'

module Wc
  class Main
    def initialize
      texts_in_line = Wc::TextsInLine.new
      @file_names_or_texts_in_line = texts_in_line.read_stdin
      @with_l = texts_in_line.with_l
      @file_names = texts_in_line.file_names
      @summary_calculator = Wc::SummaryCalculator.new(@file_names_or_texts_in_line, { line_count: 0, word_count: 0, byte_count: 0 })
      @formatter = Wc::Formatter.new(@file_names_or_texts_in_line, @with_l)
    end

    def operate_wc
      Wc::Result.new(@file_names, @summary_calculator, @formatter).show_result
    end
  end
end

main = Wc::Main.new
main.operate_wc
