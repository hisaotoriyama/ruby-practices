# !/usr/bin/env ruby
# frozen_string_literal: true

require './bowling_oop_game'

game = Game.new(ARGV[0])
puts game.calc_frames_score
