# !/usr/bin/env ruby
# frozen_string_literal: true

module Wc
  class FileFormalize
    attr_reader :detailed_info_in_hash, :file_name_in_text

    def initialize(detailed_info_in_hash, file_name_in_text)
      @detailed_info_in_hash = detailed_info_in_hash
      @file_name_in_text = file_name_in_text
    end

    def with_full
      line_count = format(detailed_info_in_hash[:line_count])
      word_count = format(detailed_info_in_hash[:word_count])
      byte_count = format(detailed_info_in_hash[:byte_count])
      puts "#{line_count}#{word_count}#{byte_count} #{file_name_in_text}"
    end

    def only_with_line
      line_count = format(detailed_info_in_hash[:line_count])
      puts "#{line_count} #{file_name_in_text}"
    end

    private

    def format(text)
      text.to_s.rjust(8)
    end
  end
end
