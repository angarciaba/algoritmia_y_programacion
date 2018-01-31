#!/usr/bin/env ruby
# encoding: utf-8
# Programa: pasos.rb
Copyright = 
"Author: Angel Garcia Baños\n" +
"Email: angel.garcia@correounivalle.edu.co\n" +
"Institution: EISC, Universidad del Valle, Colombia" +
"Creation date: 2016-04-08\n" +
"Last modification date: 2018-01-31\n" +
"License: GNU-GPL"
Version = "0.7"
Description = "It is useful for executing a Ruby program step by step, showing all local variables and instance variables and the code line that is going to be executed if you press <F9>. It is very simple, compared with other debbugers, but that is its main porpouse, for novice users (students learning Ruby as its first programming course)"
Dependences = 
"Nothing"
#-----------------------------------------------------------------------------------------------------------------------
# VERSIONS
# 0.7 Using F9 instead of ENTER to step on the program (compatible with Linux and Cloud9)
# 0.6 Avoiding weird behavior when steping on elsif
# 0.5 Using inspect except with null objects
# 0.4 Spanish to English translation.
# 0.3 Remove echo in "gets", to avoid the user get confused when its program execute another "gets".
# 0.2 Corrected malfuctioning "gets", due to ARGV redirection.
# 0.1 The first one. 
#-----------------------------------------------------------------------------------------------------------------------
begin
require 'optparse'
class Arguments < Hash
  def initialize(args)
    super()
    options = OptionParser.new do |option|
      option.banner = "Use: #$0 [options] file\n\n" + Description + "\n\n" + Copyright + "\nVersion: " + Version + "\nOptions:\n" + "Dependences:\n" + Dependences

      option.on('-v', '--version', 'shows version and quits') do
        puts Version
        exit
      end

      option.on_tail('-h', '--help', 'shows this help and quits') do
        puts option
        exit
      end
    end

    options.parse!(args)
  end
end
end

#-----------------------------------------------------------------------------------------------------------------------
require 'io/console'
def waitigForAKey(keyCode="\e[20~")  # Default is F9 keycode
  found = false
  while not found
    found = true
    keyCode.each_char do |code|
      keyPoint = STDIN.getch
      if keyPoint != code
        found = false
        break
      end
    end
  end
end
#-----------------------------------------------------------------------------------------------------------------------
if $0 == __FILE__
  require 'io/console'
  p "Hit F9 to execute your program step by step"
  arguments = Arguments.new(ARGV)
  sourceFile = ARGV[0]
  ARGV.replace []
  arrayLines = open(sourceFile).readlines
  oldLine = -1
  tp__tp = TracePoint.new() do |tp__tp|
    next if tp__tp.path != sourceFile
    currentLine = tp__tp.lineno
    next if oldLine == currentLine
    variables =  tp__tp.binding.eval('local_variables') + tp__tp.binding.eval('instance_variables')- [:tp__tp]
    variables.each do |var| 
      value=tp__tp.binding.eval("v=#{var} ? #{var}.inspect : ''")
      puts "\t\t#{var}=#{value}"
    end
    puts "\t#{currentLine}: #{arrayLines[currentLine-1].chomp}"
    oldLine = currentLine
    waitigForAKey
  end
  tp__tp.enable
  load(sourceFile)
  tp__tp.disable
end


