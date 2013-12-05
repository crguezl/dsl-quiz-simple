#!/usr/bin/env ruby

filename = ARGV.shift 

exam =  File.open(filename).read
exam = <<"EXAM"
  require './quiz1'

  Quiz.new() do
    #{exam}
  end
EXAM
puts "************************"
quiz =  eval exam
quiz.run
