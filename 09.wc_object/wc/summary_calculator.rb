# !/usr/bin/env ruby
# frozen_string_literal: true

require './data_open'
require './summary_files_data'

module Wc
  class SummaryCalculator
    def initialize(file_names_or_texts_in_line)
      @file_names_or_texts_in_line = file_names_or_texts_in_line
      @sum_hashed_file_detail = { line_count: 0, word_count: 0, byte_count: 0 }
    end

    # stdinの場合
    def summarize_text_in_stdin
      @file_names_or_texts_in_line.each do |text|
        summarize_text(@sum_hashed_file_detail, text) # （計算）1行1行あたりのstdin情報の数値の合算計算
      end
      @sum_hashed_file_detail
    end

    # ファイルの場合
    def summarize_text_in_file_names
      @file_names_or_texts_in_line.each do |text|
        if File.file?(text)
          file_contents_in_text = File.open(text).read
          summarize_text(@sum_hashed_file_detail, file_contents_in_text) # （計算）1行1行あたりのファイル情報の数値の合算計算
        end
      end
      @sum_hashed_file_detail
    end

    private

    # （計算）1行1行あたりのstdinないしファイルの数値の合算計算。
    def summarize_text(text_data_in_hash, text)
      wc_summary = Wc::SummaryFilesData.new(text_data_in_hash, text)
      wc_summary.add_file_data
    end
  end
end
