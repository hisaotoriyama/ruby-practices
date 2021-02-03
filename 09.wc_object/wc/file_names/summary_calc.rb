# !/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../summary_texts_data'

module Wc
  module FileNames
    class SummaryCalc
      def initialize(file_names_in_line)
        @file_names_in_line = file_names_in_line
        @sum_hashed_file_detail = { line_count: 0, word_count: 0, byte_count: 0 }
      end

      def summarize_text_in_file_names
        @file_names_in_line.each do |text|
          Wc::SummaryTextsData.new(@sum_hashed_file_detail, File.open(text).read).add_file_data if File.file?(text)
        end
        @sum_hashed_file_detail
      end
    end
  end
end
