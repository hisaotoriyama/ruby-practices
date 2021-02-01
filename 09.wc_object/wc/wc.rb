# !/usr/bin/env ruby
# frozen_string_literal: true

require './input_processor'
require './formatter'
require './stdin/summary_calc'
require './stdin/result'
require './file_names/result'
require './file_names/result_for_each_file_detail'
require './file_names/summary_calc'

module Wc
  class Main
    def initialize
      @input_processor = Wc::InputProcessor.new
    end

    def operate_wc
      if @input_processor.file_names_in_line.empty?
        summary_for_stdin
      else
        show_files_details_and_summary_for_file_names
      end
    end

    private

    def summary_for_stdin
      @summary_calc = Wc::Stdin::SummaryCalc.new(@input_processor.stdin_texts_in_line)
      Wc::Stdin::Result.new(@summary_calc, @input_processor.with_l).show_result
    end

    def show_files_details_and_summary_for_file_names
      Wc::FileNames::ResultForEachFileDetail.new(@input_processor.file_names_in_line, @input_processor.with_l).show_detail_each_file

      @summary_calc = Wc::FileNames::SummaryCalc.new(@input_processor.file_names_in_line)
      Wc::FileNames::Result.new(@summary_calc, @input_processor.with_l).show_result
    end
  end
end

main = Wc::Main.new
main.operate_wc
