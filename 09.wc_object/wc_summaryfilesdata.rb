# !/usr/bin/env ruby
# frozen_string_literal: true

require './wc_text'
require './wc_textsexpression'

module Wc
  class SummaryFilesData
    attr_reader :summary_file_details_in_hash, :file_name_in_text, :wc_text

    def initialize(summary_file_details_in_hash, file_name_in_text)
      wc_text = Wc::Text.new(file_name_in_text)
      @wc_text = wc_text
      @summary_file_details_in_hash = summary_file_details_in_hash
      @file_name_in_text = file_name_in_text
    end

    def add_file_data
      summary_file_details_in_hash[:line_count] += wc_text.text_detail[:line_count]
      summary_file_details_in_hash[:word_count] += wc_text.text_detail[:word_count]
      summary_file_details_in_hash[:byte_count] += wc_text.text_detail[:byte_count]
    end
  end
end
