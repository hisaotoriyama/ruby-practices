# !/usr/bin/env ruby
# frozen_string_literal: true

require './wc_textinline'
require './wc_text'
require './wc_summaryfilesdata'
require './wc_fileformalize'

module Wc
  class TextsExpression
    attr_reader :texts_in_line_after_read_stdin, :file_names_in_text, :with_l

    def initialize
      texts_in_line = Wc::TextsInLine.new
      texts_in_line_after_read_stdin = texts_in_line.read_stdin
      @file_names_in_text = texts_in_line.file_names_in_text
      @with_l = texts_in_line.with_l
      @texts_in_line_after_read_stdin = texts_in_line_after_read_stdin
    end

    def expression
      row = 0
      summary_file_details_in_hash = { line_count: 0, word_count: 0, byte_count: 0 }
      texts_in_line_after_read_stdin.each do |text|
        if file_names_in_text == []
          summary_text(summary_file_details_in_hash, text)
        elsif File.file?(text)
          file_contents_in_text = File.open(text).read

          summary_text(summary_file_details_in_hash, file_contents_in_text)

          wc_text = Wc::Text.new(file_contents_in_text)
          "#{fileorfilesformalize(wc_text.text_detail, text)}"

          row += 1
        else
          puts "wc: #{text}: open: No such file or directory"

          row += 1
        end
      end
      fileorfilesformalize(summary_file_details_in_hash, 'total') if row >= 2

      fileorfilesformalize(summary_file_details_in_hash, '') if file_names_in_text == []
    end

    private

    def summary_text(text_data_in_hash, text)
      wc_summary = Wc::SummaryFilesData.new(text_data_in_hash, text)
      wc_summary.add_file_data
    end

    def fileorfilesformalize(summary_file_details_in_hash, with_total_expression)
      wc_fileformalize = Wc::FileFormalize.new(summary_file_details_in_hash, with_total_expression)
      if with_l
        wc_fileformalize.only_with_line
      else
        wc_fileformalize.with_full
      end
    end
  end
end
