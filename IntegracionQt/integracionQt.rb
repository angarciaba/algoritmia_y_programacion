#!/usr/bin/env ruby
# encoding: utf-8
# Programa: integracionQt.rb
Copyright = 
"Autor: Angel Garcia Baños\n" +
"Email: angel.garcia@correounivalle.edu.co\n" +
"Institución: EISC, Universidad del Valle, Colombia" +
"Fecha creación: 2016-03-29\n" +
"Fecha última modificación: 2016-04-14\n" +
"Licencia: GNU-GPL"
Version = "0.4"
Descripcion = 
"Toma uno o más archivos gui.ui con la descripción de una interfase de Qt4 generada con qtcreator, y uno o más archivos funciones.rb con las funciones escritas en modo procedural (ingenuo, no-OO) y los integra en una aplicacion.ui. El nombre de cada archivo con funciones debe de coincidir con el nombre de cada archivo que contenga la respectiva interfase gui y con el nombre de la clase interna (con la salvedad de que el nombre de los archivos debe ir todo en minúsculas). Uno y sólo uno de los archivos debe llamarse mainwindow.ui y debe contener la ventana principal, de tipo Qt::MainWindow. Los demás archivos deben ser de tipo Qt::Dialog. En los archivos .rb se permite escribir qtCreate(dd) y qtDestroy() siendo qtCreate una palabra clave nueva que permite crear un nuevo Dialog, y siendo dd el nombre de la clase que hereda de Qt::Dialog. Con qtDestroy() se incluye código para destruir la ventana actual. Por cierto que cada archivo .ui debe contener un único widget y el nombre del widget debe de coincidir con el nombre del archivo. Con qtcreator hay que crear cada widget (que hereda de Qt::MainWindow o Qt:Dialog), incluyendo el nombre de las funciones externas (slots) que llamará y que deben encontrarse en el respectivo archivo.rb. La aplicación generada se guarda en un directorio aparte con el ejecutable, para que no interfiera con los .rb que contienen las funciones.

La función qtDestroy puede especificar variables a retornar, separadas por comas. Se recibirán en la variable qtI_resultados, que es un array conteniendo las variables retornadas en el mismo orden especificado. O sea, qtDestroy(a, b, c) produce en el programa llamante qtI_resultados = [a, b, c]"
Dependencias =
"
sudo apt-get install ruby-qt4 qtcreator cmake
gem install qtbindings
"
#-----------------------------------------------------------------------------------------------------------------------
# VERSIONES
# 0.4 Puse system en vez de exec. Si no hay argumentos supone que hay que usar todos los archivos del directorio actual. Mejoré los mensajes de salida.
# 0.3 Ya comprendí como generar el archivo de salida. Falta qtCreate(dd), qtDestroy() y verificar que todos los slots tengan su función.
# 0.2 Se elimina lo superfluo, concretamente el análisis de los archivos .ui, dado que esa es una tarea que realiza el rbuic4. Aquí sólo hay que trabajar con el resultado que arroje el rbuic4, es decir, los archivos _ui.rb. Todo lo demás es inútil y se eliminó.
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
# Hay que convertir los *.ui en *_ui.rb con el comando rbuic4. 
# En los archivos _ui.rb hay que reconocer este tipo de líneas:
#    attr_reader :pushButton
#    Qt::Object.connect(@pushButton, SIGNAL('clicked()'), mainWindow, SLOT('lanzarMoneda()'))
# para extraer los atributos como pushButton y los SLOTs como lanzarMoneda

# Directorio donde se salva el archivo ejecutable
DirectorioEjecutable = "salida"

# Variable en Ruby: /([a-z_][a-zA-Z_0-9]*)/
#-----------------------------------------------------------------------------------------------------------------------

class IntegracionQt
  def initialize(archivosEntrada, directorioSalida, archivoSalida, comandoRubyQt="rbuic4")
    @archivosEntrada, @directorioSalida, @archivoSalida, @comandoRubyQt = archivosEntrada, directorioSalida, archivoSalida, comandoRubyQt
    @atributosYSlots = {}
  end
  
  
  def generarEjecutable
    Dir.mkdir @directorioSalida unless File.directory? @directorioSalida
    archivosEntrada = separarArchivos
    archivosEntrada[".ui"].each { |archivo| system "#{@comandoRubyQt} #{archivo}.ui -o #{@directorioSalida}/#{File.basename(archivo)}_ui.rb" }
    unless archivosEntrada[".ui"].inject(false) { |encontrado, archivo| ((encontrado or File.basename(archivo)) == "mainwindow") }
      $error.abortar "Falta el archivo mainwindow.ui, que contiene la ventana principal" 
    end
    
    archivosEntrada[".ui"].each do |archivo|
      atributos, slots, nombreDeClase = extraerAtributosYSlots("#{@directorioSalida}/#{File.basename(archivo)}_ui.rb")
      @atributosYSlots[archivo] = [atributos.uniq, slots.uniq, nombreDeClase]
    end
    
    # Reporte de lo encontrado
    @atributosYSlots.each do |archivo, atributos_slots|
      puts "====================\nDebes escribir un archivo #{archivo}.rb que contenga las siguientes funciones (slots):"
      atributos_slots[1].each { |slot| puts "    def #{slot}\n      # ToDo\n    end\n\n" }
      puts "\n====================\nY dentro de esas funciones puedes usar los siguientes objetos gráficos:"
      atributos_slots[0].each { |atributo| puts "    #{atributo}" }
    end
    
    # Crea el archivo de salida
    if @archivoSalida
      open("#{@directorioSalida}/#{@archivoSalida}", "w") do |flujoSalida|
        archivosEntrada[".ui"].each do |archivo| 
          flujoSalida << "#-----------------------------------------------\n\n"
          open("#{@directorioSalida}/#{File.basename(archivo)}_ui.rb") { |flujoEntrada| flujoSalida << flujoEntrada.read }
        end
        
        @atributosYSlots.each do |archivo, atributos_slots|
          flujoSalida << <<-CODIGO_FIJO_COMIENZO_CLASE 
#-----------------------------------------------
require 'Qt4'
class #{File.basename(archivo) == "mainwindow" ? "MainForm" : "QtI_"+atributos_slots[2]} < Qt::#{File.basename(archivo) == "mainwindow" ? "MainWindow" : "Dialog"}
          CODIGO_FIJO_COMIENZO_CLASE
          if atributos_slots[1].length > 0
            flujoSalida << "  slots '#{atributos_slots[1][0]}'"
            atributos_slots[1].drop(1).each { |slot| flujoSalida << ", '#{slot}'" }
            flujoSalida << "\n  attr_accessor :qtI_resultados\n"
          end
          # Se añaden los archivos.rb con las definiciones de funciones que son slots en el GUI.
          if File.file? archivo+".rb"
            open(archivo+".rb").each do |linea|
              case linea
              when /qtCreate\((.*)\)/
                flujoSalida << <<-CODIGO_LLAMADA_QTCREATE
    dialog_#{$1} = QtI_#{$1}.new(self)
    if(dialog_#{$1}.exec == 1) # OK clicked
    #  ToDo ????
    end
    qtI_resultados = dialog_#{$1}.qtI_resultados
                CODIGO_LLAMADA_QTCREATE
              when /qtDestroy\((.*)\)/
                variables = buscarYTransformarAtributos($1, atributos_slots[0])
                flujoSalida << "    @qtI_resultados = [ #{variables} ]\n"
                flujoSalida << "    close()\n"
              else
                flujoSalida << buscarYTransformarAtributos(linea, atributos_slots[0])
              end
            end
          end
          flujoSalida << <<-CODIGO_FIJO_FIN_CLASE
  def initialize(parent=nil)
    super(parent)
    @ui = Ui::#{atributos_slots[2]}.new
    @ui.setup_ui(self)
    self.show
  end
end

        CODIGO_FIJO_FIN_CLASE
        end
        flujoSalida << <<-CODIGO_FIJO_MAIN
if $0 == __FILE__
    a = Qt::Application.new(ARGV)
    MainForm.new
    a.exec
end

      CODIGO_FIJO_MAIN
      end
    else
      # ToDo: crea los archivos de salida 
    end
  end


  # Busca los atributos en la linea. Verifica que no forman parte de una palabra más larga. Pone delante de ellos "@ui."
  def buscarYTransformarAtributos(linea, atributos)
    atributos.each do |atributo|
      indice = 0
      loop do
        indice = linea.index(atributo, indice)
        break unless indice
        if ((indice == 0 or (not linea[indice-1].match(/\w/))) and (indice+atributo.length > linea.length or (not linea[indice+atributo.length].match(/\w/))))
          linea.insert(indice, "@ui.")
          indice += "@ui.".length
        end
        indice += atributo.length
      end
    end
    linea
  end
 

  def separarArchivos
    archivos = Hash.new() { |hash, key| hash[key] = [] }
    @archivosEntrada.each do |archivo|
      [".ui", ".rb"].each do |extension|
        archivos[extension] << archivo.chomp(extension) if archivo.end_with?(extension)
      end
    end
    archivos
  end
  
  
  def extraerAtributosYSlots(archivo)
    atributosGUI = []
    slotsGUI = []
    todasLasLineas = ""
    open(archivo).each do |linea|
      encontrado = /^\s*attr_reader\s*:(\w*)/.match(linea)
      atributosGUI << encontrado[1] if encontrado
      encontrado = /^\s*Qt::Object\.connect\(@?\w+,\s*SIGNAL\(.*?\),\s*\w+,\s*SLOT\('(.+?)'\)\)/.match(linea)
      slotsGUI << encontrado[1] if encontrado
      todasLasLineas << linea
    end
    return atributosGUI, slotsGUI, todasLasLineas.match(/^module\s+Ui\s+class (\w+)/)[1]
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

      opciones.on('-m', '--multiples', "genera múltiples archivos de salida (uno por cada clase). Siempre se salvan en el directorio #{DirectorioEjecutable} con el nombre de cada clase. (Por defecto no se usa esta opción, con lo cual se genera un único archivo, conteniendo todas las clases)") do
        self[:salida] = nil
      end

      opciones.on('-o=ARG', '--salida=ARG', "genera un único archivo de salida (conteniendo todas las clases). Esta opción funciona por defecto, generandose un archivo llamado salida.rb. Y siempre se salva en el directorio #{DirectorioEjecutable}") do |argumento|
        self[:salida] = argumento
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
  
  def abortar(string)
    puts "ERROR FATAL: #{string}"
    exit 1
  end
end



if $0 == __FILE__
#  require 'pry'
#  binding.pry
  $error = Error.instance
  argumentos = Argumentos.new(ARGV)
  archivos = []
  archivos = Dir["*.rb"] + Dir["*.ui"] if ARGV.empty?
  archivos -= ["integracionQt.rb"]
  $error.verbose = argumentos[:verbose]
  integracionQt = IntegracionQt.new(archivos, DirectorioEjecutable, argumentos[:salida], "rbuic4")
  integracionQt.generarEjecutable
end



#-----------------------------------------------------------------------------------------------------------------------
if hacer_perfilado then
$result = RubyProf.stop
printer = RubyProf::FlatPrinter.new($result)
printer.print(STDOUT)
end
#-----------------------------------------------------------------------------------------------------------------------



