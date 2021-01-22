# !/usr/bin/env ruby
# frozen_string_literal: true

require './formatter'

module Wc
  class Main
    def operate_wc
      Wc::Formatter.new.format
    end
  end
end

main = Wc::Main.new
main.operate_wc
