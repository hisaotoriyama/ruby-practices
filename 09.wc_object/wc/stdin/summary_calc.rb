# !/usr/bin/env ruby
# frozen_string_literal: true

require_relative './result'
require_relative '../summary_texts_data'

module Wc
  module Stdin
    class SummaryCalc
      def initialize(stdin_texts_in_line)
        @stdin_texts_in_line = stdin_texts_in_line
        @sum_hashed_stdin_detail = { line_count: 0, word_count: 0, byte_count: 0 }
      end

      def summarize_text_in_stdin
        @stdin_texts_in_line.each do |text|
          Wc::SummaryTextsData.new(@sum_hashed_stdin_detail, text).add_file_data
        end
        @sum_hashed_stdin_detail
      end
    end
  end
end
