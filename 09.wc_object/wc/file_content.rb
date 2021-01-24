# !/usr/bin/env ruby
# frozen_string_literal: true

module Wc
  class FileContent
    attr_reader :hashed_file_detail, :file_name

    def initialize(hashed_file_detail, file_name)
      @hashed_file_detail = hashed_file_detail
      @file_name = file_name
    end

    def with_full
      line_count = format_file(hashed_file_detail[:line_count])
      word_count = format_file(hashed_file_detail[:word_count])
      byte_count = format_file(hashed_file_detail[:byte_count])
      puts "#{line_count}#{word_count}#{byte_count} #{file_name}"
    end

    def only_with_line
      line_count = format_file(hashed_file_detail[:line_count])
      puts "#{line_count} #{file_name}"
    end

    private

    def format_file(text)
      text.to_s.rjust(8)
    end
  end
end
