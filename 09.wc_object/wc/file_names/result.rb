# !/usr/bin/env ruby
# frozen_string_literal: true

module Wc
  module FileNames
    class Result
      def initialize(summary_calc, with_l)
        @summary_calc = summary_calc
        @with_l = with_l
      end

      def show_result
        Wc::Formatter.new(@summary_calc.summarize_text_in_file_names, 'total', @with_l).format_file_or_files
      end
    end
  end
end
