# !/usr/bin/env ruby
# frozen_string_literal: true

require './text_detail_calc'

module Wc
  class SummaryTextsData
    def initialize(sum_hashed_detail, file_name)
      @wc_text = Wc::TextDetailCalc.new(file_name)
      @sum_hashed_detail = sum_hashed_detail
    end

    def add_file_data
      @sum_hashed_detail[:line_count] += @wc_text.hashed_text_detail[:line_count]
      @sum_hashed_detail[:word_count] += @wc_text.hashed_text_detail[:word_count]
      @sum_hashed_detail[:byte_count] += @wc_text.hashed_text_detail[:byte_count]
    end
  end
end
