# !/usr/bin/env ruby
# frozen_string_literal: true

module Wc
  class Formatter
    def initialize(hashed_file_detail, file_name_or_total, with_l)
      @hashed_file_detail = hashed_file_detail
      @file_name_or_total = file_name_or_total
      @with_l = with_l
    end

    def format_file_or_files
      if @with_l
        show_only_with_line
      else
        show_with_full
      end
    end

    def show_with_full
      line_count = format_rjust(@hashed_file_detail[:line_count])
      word_count = format_rjust(@hashed_file_detail[:word_count])
      byte_count = format_rjust(@hashed_file_detail[:byte_count])
      "#{line_count}#{word_count}#{byte_count} #{@file_name_or_total}"
    end

    def show_only_with_line
      line_count = format_rjust(@hashed_file_detail[:line_count])
      "#{line_count} #{@file_name_or_total}"
    end

    private

    def format_rjust(text)
      text.to_s.rjust(8)
    end
  end
end
