#!/usr/bin/env ruby
# encoding: utf-8
# Programa: integracionQt.rb
Copyright = 
"Autor: Angel Garcia Baños\n" +
"Email: angel.garcia@correounivalle.edu.co\n" +
"Fecha creación: 2016-03-29\n" +
"Fecha última modificación: 2016-03-29\n" +
"Licencia: GNU-GPL"
Version = "0.1"
Descripcion = 
"Toma uno o más archivos gui.ui con la descripción de una interfase de Qt5 generada con qtcreator, y uno o más archivos funciones.rb con las funciones escritas en modo procedural (ingenuo, no-OO) y los integra en una aplicacion.ui. El nombre de cada archivo con funciones debe de coincidir con el nombre de cada archivo con la respectiva interfase gui."
Dependencias =
"
sudo apt-get install ruby-qt4 qtcreator cmake
gem install qtbindings
"
#-----------------------------------------------------------------------------------------------------------------------
# VERSIONES
# 0.1 La primera. 
#-----------------------------------------------------------------------------------------------------------------------
# Para ayudar a depurar:
def dd(expresion,entorno,mensaje="")
  puts "#{expresion}=#{entorno.eval(expresion)}  #{mensaje}\n==="
end
# Ejemplo de uso:
# a="Hola"
# dd("a",binding)
#-----------------------------------------------------------------------------------------------------------------------
# Para que funcione bundler (que traiga las gemas especificadas en Gemfile):
require 'rubygems'
require 'bundler/setup'
#-----------------------------------------------------------------------------------------------------------------------
# Si se sospecha que el código es ineficiente, se puede hacer un perfilado poniendo la siguiente variable =true
hacer_perfilado=false
if hacer_perfilado then
require 'ruby-prof'
RubyProf.start
end
#-----------------------------------------------------------------------------------------------------------------------
# Hay que convertir los *.ui en *.rb con el comando rbuic4. 
# En los archivos ui hay que reconocer este tipo de lineas:
#   <widget class="QPushButton" name="pushButton">
#   <slot>lanzarMoneda()</slot>
# Y en los archivos rb hay que reconocer este tipo de líneas:
#    attr_reader :pushButton
#    Qt::Object.connect(@pushButton, SIGNAL('clicked()'), mainWindow, SLOT('lanzarMoneda()'))
# para extraer los atributos como pushButton y los SLOTs como lanzarMoneda

# Directorio donde se salva el archivo ejecutable
DirectorioEjecutable = "ejecutable"


class IntegracionQt
  def initialize(archivosEntrada, directorioSalida, archivoSalida, metodoExtraccion, comandoRubyQt="rbuic4")
    @archivosEntrada, @directorioSalida, @archivoSalida, @metodoExtraccion, @comandoRubyQt = archivosEntrada, directorioSalida, archivoSalida, metodoExtraccion, comandoRubyQt
    @dependencias = {}
    @metodos = 
    [
      ["ui",    ".ui", /^\s*<(?:widget|layout) class=[^\s]+\s+name=["|'](\w+)["|']\/?>/, /^\s*<slot>(.+?)<\/slot>/],
      ["rb", "_ui.rb", /^\s*attr_reader\s*:(\w*)/, /^\s*Qt::Object\.connect\(@?\w+,\s*SIGNAL\(.*?\),\s*\w+,\s*SLOT\('(.+?)'\)\)/]
    ]
  end
  
  
  def generarNuevaExtension(viejaExtension)
    @metodos.each { |caso| return caso[1] if caso[0] == viejaExtension }
    nil
  end
  
  
  def generarEjecutable
    archivosGUI, archivosFunciones = separarArchivos
#    archivosGUI.each { |archivoGUI| exec "#{@comandoRubyQt} #{archivoGUI}.ui #{archivoGUI == "mainwindow" ? "-x" : ""} -o #{archivoGUI}_ui.rb" }

    archivosGUI.each do |archivoGUI|
      hayFunciones=
      if archivosFunciones.include? archivoGUI
        archivosFunciones.delete archivoGUI
        true
      else
        $error.aviso("No hay ningún archivo .rb conteniendo funciones para el archivo GUI #{archivoGUI}.ui")
        false
      end
      if archivosFunciones.size != 0
        $error.aviso("Los archivos .rb #{archivosFunciones} contienen funciones que no son de ningún archivo GUI. Se añadirán al final del archivo de salida")
      end
          
      @dependencias[archivoGUI] = {}

      @metodos.each do |metodo, extension, regExpAtributo, regExpSlot| 
        if @metodoExtraccion.include?(metodo)
          atributosGUI, slotsGUI = extraerAtributosYSlots(archivoGUI+extension, regExpAtributo, regExpSlot)
          @dependencias[archivoGUI][metodo] = [hayFunciones, atributosGUI.uniq, slotsGUI.uniq]
        end
      end
    end
    
    # Reporte de lo encontrado
    @dependencias.each do |archivo, metodos|
      metodos.each do |metodo, value|
        p "====================\nEl archivo #{archivo}#{generarNuevaExtension(metodo)} contiene los siguientes objetos gráficos:"
        value[1].each { |atributo| p "    #{atributo}" }
        p "====================\nEl archivo #{archivo}#{generarNuevaExtension(metodo)} contiene las siguientes funciones (slots):"
        value[2].each { |slot| p "    #{slot}" }
      end
    end
    
    # ToDo crear el archivo de salida
  end
 

  def separarArchivos
    archivosGUI = []
    archivosFunciones = []
    @archivosEntrada.each do |archivo|
      if archivo.end_with?("ui")
        archivosGUI << archivo.chomp(".ui")
      elsif archivo.end_with?("rb")
        archivosFunciones << archivo.chomp(".rb")
      end
    end
    return archivosGUI, archivosFunciones
  end
  
  
  def extraerAtributosYSlots(archivo, regExpAtributo, regExpSlot)
    atributosGUI = []
    slotsGUI = []
    open(archivo).each do |linea|
if linea.include? "statusBar"
p "*** #{linea}" 
end
      encontrado = regExpAtributo.match(linea)
      atributosGUI << encontrado[1] if encontrado
      encontrado = regExpSlot.match(linea)
      slotsGUI << encontrado[1] if encontrado
    end
    return atributosGUI, slotsGUI
  end
end


#-----------------------------------------------------------------------------------------------------------------------
require 'optparse'
class Argumentos < Hash
  def initialize(args)
    super()
    opciones = OptionParser.new do |opciones|
      opciones.banner = "Uso: #$0 [opciones] archivos...\n\n" + Descripcion + "\n\n" + Copyright + "\nVersion: " + Version + "\nOpciones:\n" + "Dependencias:\n" + Dependencias
      self[:salida] = "salida.rb"
      self[:metodoExtraccion] = "ui,rb"
      
      opciones.on('-o=ARG', '--salida=ARG', "archivo de salida (el ejecutable). Por defecto es salida.rb. Y siempre se salva en el directorio #{DirectorioEjecutable}") do |argumento|
        self[:salida] = argumento
      end

      opciones.on('-m=ARG', '--metodo-extraccion=ARG', 'se extraen los atributos y slots a partir del archivo {ui, rb}. Por defecto es con ambos métodos y verificando después que coinciden. Si se selecciona un único método, no se hace ninguna verificación. Esto puede servir para intentar por uno u otro método cuando deje de funcionar uno de ellos en las nuevas versiones de Qt') do |argumento|
        self[:metodoExtraccion] = argumento if (argumento.include?("ui") or argumento.include?("rb")) 
      end

      opciones.on('-b', '--verbose', 'muestra todos los errores y problemas encontrados') do
        self[:verbose] = true
      end

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



require 'singleton'
class Error
  attr_accessor :verbose
  attr_accessor :archivo
  attr_accessor :numeroDeLinea
  include Singleton

  def initialize
    @verbose = false
    @archivo = ""
    @numeroDeLinea = 0
  end
  
  def avisoArchivo(string)
    if @verbose then puts "AVISO: en el archivo #{@archivo} en el indice #{@numeroDeLinea}. #{string}" end
  end

  def aviso(string)
    if @verbose then puts "AVISO: #{string}" end
  end
end




if $0 == __FILE__
  $error = Error.instance
  argumentos = Argumentos.new(ARGV)
  $error.verbose = argumentos[:verbose]
  integracionQt = IntegracionQt.new(ARGV, DirectorioEjecutable, argumentos[:salida], argumentos[:metodoExtraccion], "rbuic4")
  integracionQt.generarEjecutable
end



#-----------------------------------------------------------------------------------------------------------------------
if hacer_perfilado then
$result = RubyProf.stop
printer = RubyProf::FlatPrinter.new($result)
printer.print(STDOUT)
end
#-----------------------------------------------------------------------------------------------------------------------



