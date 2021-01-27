# !/usr/bin/env ruby
# frozen_string_literal: true

module Wc
  class Result
    def initialize(file_names, summary_calculator, formatter)
      @file_names = file_names
      @summary_calculator = summary_calculator
      @formatter = formatter
    end

    def show_result
      if @file_names.empty? # stdinの場合
        result = @summary_calculator.summarize_text_in_stdin # （計算）1行1行あたりのstdin情報の数値の合算計算
        @formatter.format_file_or_files(result, '') # （1行1行フォーマット）1行1行あたりのstdin情報の内容のフォーマット
      else

        @formatter.show_detail_each_file # （フォーマット）全ファイルとNonファイルの内容のフォーマット

        result2 = @summary_calculator.summarize_text_in_file_names # （計算）1行1行あたりのファイル情報の数値の合算計算
        @formatter.format_file_or_files(result2, 'total') # （1行1行フォーマット）1行1行あたりのファイル情報の内容のフォーマット
      end
    end
  end
end
