# !/usr/bin/env ruby
# frozen_string_literal: true

require './text'

module Wc
  class SummaryFilesData
    def initialize(sum_hashed_file_detail, file_name)
      @wc_text = Wc::Text.new(file_name)
      @sum_hashed_file_detail = sum_hashed_file_detail
      @file_name = file_name
    end

    def add_file_data
      @sum_hashed_file_detail[:line_count] += @wc_text.text_detail[:line_count]
      @sum_hashed_file_detail[:word_count] += @wc_text.text_detail[:word_count]
      @sum_hashed_file_detail[:byte_count] += @wc_text.text_detail[:byte_count]
    end
  end
end
