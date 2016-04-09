#!/usr/bin/env ruby
# encoding: utf-8
# Programa: pasos.rb
Copyright = 
"Autor: Angel Garcia Baños\n" +
"Email: angel.garcia@correounivalle.edu.co\n" +
"Institución: EISC, Universidad del Valle, Colombia" +
"Fecha creación: 2016-04-08\n" +
"Fecha última modificación: 2016-04-08\n" +
"Licencia: GNU-GPL"
Version = "0.1"
Descripcion = 
"Sirve para ejecutar paso a paso un programa viendo después de cada paso todas las variables locales y de instancia, así como la siguiente línea de código que se va a ejecutar. Cada vez que se pulse <ENTER> se ejecuta una línea de código."
Dependencias = 
"Ninguna."
#-----------------------------------------------------------------------------------------------------------------------
# VERSIONES
# 0.1 La primera. 
#-----------------------------------------------------------------------------------------------------------------------
begin
require 'optparse'
class Argumentos < Hash
  def initialize(args)
    super()
    opciones = OptionParser.new do |opciones|
      opciones.banner = "Uso: #$0 [opciones] archivo\n\n" + Descripcion + "\n\n" + Copyright + "\nVersion: " + Version + "\nOpciones:\n" + "Dependencias:\n" + Dependencias

      opciones.on('-v', '--version', 'muestra la version y termina') do
        puts Version
        exit
      end

      opciones.on_tail('-h', '--help', 'muestra esta ayuda y termina') do
        puts opciones
        exit
      end
    end

    opciones.parse!(args)
  end
end
end

#-----------------------------------------------------------------------------------------------------------------------
if $0 == __FILE__
  argumentos = Argumentos.new(ARGV)
  archivoFuente = ARGV[0]
  archivoFuente = "prueba.rb"
  arrayLineas = open(archivoFuente).readlines
  tp__tp = TracePoint.new(:line, :call, :return) do |tp__tp|
    next if tp__tp.path != archivoFuente
    lineaActual = tp__tp.lineno
    variables =  tp__tp.binding.eval('local_variables') + tp__tp.binding.eval('instance_variables')- [:tp__tp]
    variables.each do |var| 
      value=tp__tp.binding.eval("#{var}")
      puts "\t\t#{var}=#{value}"
    end
    puts "\t#{lineaActual}: #{arrayLineas[lineaActual-1].chomp}"
    $stdin.gets
  end
  tp__tp.enable
  load(archivoFuente)
  tp__tp.disable
end

