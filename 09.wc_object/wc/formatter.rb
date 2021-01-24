# !/usr/bin/env ruby
# frozen_string_literal: true

require './text_in_line'
require './text'
require './summary_files_data'
require './file_content'

module Wc
  class Formatter
    def initialize
      texts_in_line = Wc::TextsInLine.new
      stdin_texts_in_line = texts_in_line.read_stdin
      @file_names = texts_in_line.file_names
      @with_l = texts_in_line.with_l
      @stdin_texts_in_line = stdin_texts_in_line
    end

    def format
      row = 0
      sum_hashed_file_detail = { line_count: 0, word_count: 0, byte_count: 0 }
      @stdin_texts_in_line.each do |text|
        if @file_names == []
          summarize_text(sum_hashed_file_detail, text)
        elsif File.file?(text)
          file_contents_in_text = File.open(text).read

          summarize_text(sum_hashed_file_detail, file_contents_in_text)

          wc_text = Wc::Text.new(file_contents_in_text)
          format_file_or_files(wc_text.text_detail, text).to_s

          row += 1
        else
          puts "wc: #{text}: open: No such file or directory"

          row += 1
        end
      end
      format_file_or_files(sum_hashed_file_detail, 'total') if row >= 2

      format_file_or_files(sum_hashed_file_detail, '') if @file_names == []
    end

    private

    def summarize_text(text_data_in_hash, text)
      wc_summary = Wc::SummaryFilesData.new(text_data_in_hash, text)
      wc_summary.add_file_data
    end

    def format_file_or_files(sum_hashed_file_detail, with_total)
      wc_filecontent = Wc::FileContent.new(sum_hashed_file_detail, with_total)
      if @with_l
        wc_filecontent.only_with_line
      else
        wc_filecontent.with_full
      end
    end
  end
end
