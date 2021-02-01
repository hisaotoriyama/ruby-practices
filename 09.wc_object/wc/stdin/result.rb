# !/usr/bin/env ruby
# frozen_string_literal: true

module Wc
  module Stdin
    class Result
      def initialize(summary_calc, with_l)
        @summary_calc = summary_calc
        @with_l = with_l
      end

      def show_result
        Wc::Formatter.new(@summary_calc.summarize_text_in_stdin, '', @with_l).format_file_or_files
      end
    end
  end
end
