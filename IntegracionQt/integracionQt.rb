#!/usr/bin/env ruby
# encoding: utf-8
# Programa: integracionQt.rb
Copyright = 
"Autor: Angel Garcia Baños\n" +
"Email: angel.garcia@correounivalle.edu.co\n" +
"Institución: EISC, Universidad del Valle, Colombia" +
"Fecha creación: 2016-03-29\n" +
"Fecha última modificación: 2016-04-17\n" +
"Licencia: GNU-GPL"
Version = "0.5"
Descripcion = 
"Toma uno o más archivos gui.ui con la descripción de una interfase de Qt4 generada con qtcreator, y uno o más archivos funciones.rb con las funciones escritas en modo procedural (ingenuo, no-OO) y los integra en una aplicacion.ui. El nombre de cada archivo con funciones debe de coincidir con el nombre de cada archivo que contenga la respectiva interfase gui y con el nombre de la clase interna (con la salvedad de que el nombre de los archivos debe ir todo en minúsculas). Uno y sólo uno de los archivos debe llamarse mainwindow.ui y debe contener la ventana principal, de tipo QMainWindow. Los demás archivos deben ser de tipo QDialog. En los archivos .rb se permite escribir qtiCreate(dd) y qtiDestroy(arg1, arg2, etc) siendo qtiCreate una palabra clave nueva que permite crear un nuevo Dialog, y siendo dd el nombre de la clase que hereda de QDialog. Con qtiDestroy(arg1, arg2, etc) se incluye código para destruir la ventana actual y devolver argumentos al programa llamante. Por cierto que cada archivo .ui debe contener un único widget y el nombre del widget debe de coincidir con el nombre del archivo. Con qtcreator hay que crear cada widget (que hereda de QMainWindow o QDialog), incluyendo el nombre de las funciones externas (slots) que llamará y que deben encontrarse en el respectivo archivo.rb. Ejemplo:
# Archivo: mainwindow.rb
# ...
  resultados = qtiCreate(dialogo)
#
# Archivo: dialogo.rb
# ...
  qtiDestroy(resultado1, resultado2, resultado3)
"
Dependencias =
"
sudo apt-get install ruby-qt4 qtcreator cmake
gem install qtbindings
"
#-----------------------------------------------------------------------------------------------------------------------
# VERSIONES
# 0.5 Crear archivos rb del usuario, si no existen, con el esqueleto de todas las funciones y las ayudas necesarias. Si existen, avisar si faltan funciones. Se elimina el directorio de salida y las opciones de la línea de comandos en esta versión. Se añaden las macros qtiCreate(dd) y qtiDestroy(arg1, arg2, etc).
# 0.4 Puse system en vez de exec. Si no hay argumentos supone que hay que usar todos los archivos del directorio actual. Mejoré los mensajes de salida.
# 0.3 Ya comprendí como generar el archivo de salida. Falta qtiCreate(dd), qtiDestroy() y verificar que todos los slots tengan su función.
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
# para extraer los objetosGraficos como pushButton y los SLOTs como lanzarMoneda
ComandoQt = "rbuic4"
# Directorio donde se salva el archivo ejecutable
DirectorioEjecutable = "."
ArchivoEjecutable = "programaQt.rb"
# Nombres que usa Qt por defecto, seguidos eventualmente de _numero:
DefaultQtNames = %w{centralWidget verticalLayoutWidget verticalLayout horizontalLayoutWidget horizontalLayout gridLayoutWidget gridLayout formLayoutWidget formLayout pushButton toolButton radioButton checkBox commandLinkButton buttonBox listView treeView tableView columnView listWidget treeWidget tableWidget groupBox scrollArea scrollAreaWidgetContents toolBox page tabWidget tab stackedWidget frame widget mdiArea comboBox fontComboBox lineEdit textEdit plainTextEdit spinBox doubleSpinBox dateEdit dial horizontalScrollBar verticalScrollBar horizontalSlider verticalSlider keySequenceEdit label textBrowser graphicsView calendarWidget lcdNumber progressBar line menuBar mainToolBar statusBar dockWidget dockWidgetContents horizontalSpacer verticalSpacer}
FuncionInicializar = "inicializar()"  # Función llamada desde el constructor del objeto gráfico

# Variable en Ruby: /([a-z_][a-zA-Z_0-9]*)/
#-----------------------------------------------------------------------------------------------------------------------

class IntegracionQt
  def initialize(archivosEntrada, directorioSalida, archivoSalida, comandoRubyQt)
    @archivosEntrada, @directorioSalida, @archivoSalida, @comandoRubyQt = archivosEntrada, directorioSalida, archivoSalida, comandoRubyQt
    @atributosYSlots = {}
  end
  
  
  def generarEjecutable
    # Crear directorio salida:
    Dir.mkdir @directorioSalida if (@directorioSalida != "." and (not File.directory? @directorioSalida))

    # Separa los archivos de entrada .ui de los .rb:
    archivosEntrada = separarArchivos(@archivosEntrada)
    
    # Verificar que exista el archivo con la ventana principal, mainwindow.ui. Sin ella no se puede continuar:
    unless archivosEntrada[".ui"].inject(false) { |encontrado, archivo| ((encontrado or File.basename(archivo)) == "mainwindow") }
      $error.abortar "Falta el archivo mainwindow.ui, que contiene la ventana principal" 
    end

    # Convertir archivos .ui a _ui.rb usando el comando de Qt para Ruby:
    archivosEntrada[".ui"].each { |archivo| system "#{@comandoRubyQt} #{archivo}.ui -o #{@directorioSalida}/#{File.basename(archivo)}_ui.rb" }
    
    # Extraer objetos gráficos y slots de cada archivo _ui.rb:    
    archivosEntrada[".ui"].each do |archivo|
      objetosGraficos, slots, nombreDeClase = extraerObjetosGraficosYSlots("#{@directorioSalida}/#{File.basename(archivo)}_ui.rb")
      @atributosYSlots[archivo] = [objetosGraficos.uniq, slots.uniq, nombreDeClase]
    end
    
    # Reporte de lo encontrado y creación de archivos .rb para cada archivo.ui:
    crearArchivosEsqueletoRb()
    
    # Crea el archivo de salida juntando adecuadamente todos los de entrada:
    crearArchivoSalida(archivosEntrada)

    # Borrar archivos temporales:
    archivosEntrada[".ui"].each { |archivo| File.delete "#{@directorioSalida}/#{File.basename(archivo)}_ui.rb" }
  end
  
  
  
  # Crea el archivo de salida juntando adecuadamente todos los de entrada:
  def crearArchivoSalida(archivosEntrada)
    open("#{@directorioSalida}/#{@archivoSalida}", "w") do |flujoSalida|
      archivosEntrada[".ui"].each do |archivo| 
        flujoSalida << "#-----------------------------------------------\n\n"
        open("#{@directorioSalida}/#{File.basename(archivo)}_ui.rb") { |flujoEntrada| flujoSalida << flujoEntrada.read }
      end
        
      @atributosYSlots.each do |archivo, objetosGraficos_slots|
        flujoSalida << "#-----------------------------------------------\n"
        flujoSalida << "require 'Qt4'\n"
        flujoSalida << "class #{File.basename(archivo) == "mainwindow" ? "MainForm" : "QtI_"+objetosGraficos_slots[2]} < Qt::#{File.basename(archivo) == "mainwindow" ? "MainWindow" : "Dialog"}\n"
        if objetosGraficos_slots[1].length > 0
          flujoSalida << "  slots '#{objetosGraficos_slots[1][0]}'"
          objetosGraficos_slots[1].drop(1).each { |slot| flujoSalida << ", '#{slot}'" }
          flujoSalida << "\n  attr_accessor :qtiResultados # Para devolver resultados al destruirse este objeto gráfico\n"
        end
        # Se añaden los archivos.rb con las definiciones de funciones que son slots en el GUI.
        hayDefInicializar = false
        if File.file? archivo+".rb"
          open(archivo+".rb").each do |linea|
            hayDefInicializar = true if linea.match "^\s*def\s+#{FuncionInicializar}"
            case linea
            when /^(.*?)=?\s*qtiCreate\((.*)\)/
              if $1[0] != "#"
                flujoSalida << "      dialog_#{$2} = QtI_#{$2}.new(self)\n"
                flujoSalida << "      dialog_#{$2}.exec\n"
                flujoSalida << "      #{$1.strip} = dialog_#{$2}.qtiResultados\n" if (not $1.strip.empty?)
              else
                flujoSalida << linea << "\n"
              end
            when /^(.*?)qtiDestroy\((.*)\)/
              if $1[0] != "#"
                variables = buscarYTransformarAtributos($2, objetosGraficos_slots[0])
                flujoSalida << "      @qtiResultados = [ #{variables} ]\n"
                flujoSalida << "      close()\n"
              else
                flujoSalida << linea << "\n"
              end
            else
              flujoSalida << buscarYTransformarAtributos(linea, objetosGraficos_slots[0])
            end
          end
        end
        flujoSalida << "\n\n"
        flujoSalida << "  def initialize(parent=nil)\n"
        flujoSalida << "    super(parent)\n"
        flujoSalida << "    @ui = Ui::#{objetosGraficos_slots[2]}.new\n"
        flujoSalida << "    @ui.setup_ui(self)\n"
        flujoSalida << (hayDefInicializar ? " " : "#")
        flujoSalida <<  "   inicializar()\n"
        flujoSalida << "    self.show\n"
        flujoSalida << "  end\n"
        flujoSalida << "end\n\n"
      end
        flujoSalida << "\n\n\n"
      flujoSalida << "if $0 == __FILE__\n"
      flujoSalida << "  app = Qt::Application.new(ARGV)\n"
      flujoSalida << "  MainForm.new\n"
      flujoSalida << "  app.exec\n"
      flujoSalida << "end\n\n"
    end
  end  



  # Reporte de lo encontrado y creación de archivos .rb para cada archivo.ui:
  def crearArchivosEsqueletoRb()
    @atributosYSlots.each do |archivo, objetosGraficos_slots|
      if File.exists? "#{archivo}.rb"
        puts "El archivo #{archivo}.rb ya existe, por lo que no se va a modificar."
        funcionesEncontradas = []
        open("#{archivo}.rb").each do |linea|
          if linea.match(/(\s*)def(\s+)(.*)/)
            funcionesEncontradas << "#{$3}"
          end
        end
        funcionesFaltantes = objetosGraficos_slots[1] - funcionesEncontradas
        if not funcionesFaltantes.empty?
          puts "Sin embargo, todavía le faltan las siguientes funciones a completar:\n\n"
          funcionesFaltantes.each { |slot| puts "    def #{slot}\n      # Pendiente de hacer\n    end\n\n" }
        end
      else
        puts "El archivo #{archivo}.rb no existe, por lo que se va a crear con el esqueleto de las funciones que debes escribir."
        open("#{archivo}.rb", "w") do |flujoSalida|
          flujoSalida << "# Archivo: #{File.basename(archivo)}.rb\n# Autor: \n# Email: \n"
          flujoSalida << "# Generado automáticamente por #{__FILE__} by Angel Garcia <angarciaba@gmail.com> licencia GPL 3.0\n"
          flujoSalida << "# En el caso de que este archivo exista, no se sobreescribirá\n"
          flujoSalida << "# Utilidad: contiene las funciones (slots) que deben ser completadas por usted, para terminar de generar la interface del archivo #{File.basename(archivo)}.ui\n#"

          flujoSalida << "\n# Dentro de esas funciones se pueden usar los siguientes objetos gráficos:\n"
          objetosGraficos_slots[0].each { |objetoGUI| flujoSalida << "#   #{objetoGUI}\n" if (not esDefaultName?(objetoGUI)) } #     (que es de tipo #{})
          flujoSalida << "\n# Para poder usar estos objetos gráficos puede consultar sus propiedades y funcionalidades aquí:"
          flujoSalida << "\n#   http://doc.qt.io/qt-4.8/qtgui-module.html"
          flujoSalida << "\n#\n# También existen estos otros objetos gráficos, pero usted no les ha dado nombre, por lo que probablemente no le interese usarlos:\n# "
          objetosGraficos_slots[0].each { |objetoGUI| flujoSalida << " #{objetoGUI}" if esDefaultName?(objetoGUI) }

          flujoSalida << "\n#\n# En sus funciones usted puede llamar a:"
          flujoSalida << "\n#  - aa = qtiCreate(dd) para crear una nueva ventana de tipo QDialog. Como argumento (dd) le debe pasar el nombre del objeto gráfico a crear (de tipo QDialog). En aa retorna un array con los argumentos que envió el qtiDestroy(). Usted puede y debe poner nombres distintos a dd y aa."
          flujoSalida << "\n#  - qtiDestroy(arg1, arg2, etc) para destruir la ventana actual. arg1, arg2, etc son argumentos opcionales de retorno, que los recibirá en el array aa retornado a la función qtiCreate() que creó esta ventana."

          flujoSalida << "\n#\n# Las funciones a completar son: \n\n"
          objetosGraficos_slots[1].each { |slot| flujoSalida << "    def #{slot}\n      # Pendiente de hacer\n    end\n\n" }
        end
      end
    end
  end



  # Verifica si un token es un nombre por defecto de objeto gráfico de Qt:
  def esDefaultName?(token)
    DefaultQtNames.each { |nombre| return true if token.match "#{nombre}(_\d+)?" }
    return false
  end



  # Busca los objetos graficos en la linea. Verifica que no forman parte de una palabra más larga. Pone delante de ellos "@ui."
  def buscarYTransformarAtributos(linea, objetosGraficos)
    objetosGraficos.each do |atributo|
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
 


  # Crea un array de dos filas. La fila 0 es un array con los archivos de entrada con extensión .ui. Y la fila 1, con extensión .rb
  def separarArchivos(archivosEntrada)
    archivos = Hash.new() { |hash, key| hash[key] = [] }
    archivosEntrada.each do |archivo|
      [".ui", ".rb"].each do |extension|
        archivos[extension] << archivo.chomp(extension) if archivo.end_with?(extension)
      end
    end
    archivos
  end
  


  # Dado un archivo _rb.ui, extrae todos los objetos gráficos y todas las funciones slot:   
  def extraerObjetosGraficosYSlots(archivo)
    objetosGUI = []
    slotsGUI = [ FuncionInicializar ]
    todasLasLineas = ""
    open(archivo).each do |linea|
      encontrado = /^\s*attr_reader\s*:(\w*)/.match(linea)
      objetosGUI << encontrado[1] if encontrado
      encontrado = /^\s*Qt::Object\.connect\(@?\w+,\s*SIGNAL\(.*?\),\s*\w+,\s*SLOT\('(.+?)'\)\)/.match(linea)
      slotsGUI << encontrado[1] if encontrado
      todasLasLineas << linea
    end
    return objetosGUI, slotsGUI, todasLasLineas.match(/^module\s+Ui\s+class (\w+)/)[1]
  end

end


#-----------------------------------------------------------------------------------------------------------------------
require 'optparse'
class Argumentos < Hash
  def initialize(args)
    super()
    opciones = OptionParser.new do |opciones|
      opciones.banner = "Uso: #$0 [opciones] archivos...\n\n" + Descripcion + "\n\n" + Copyright + "\nVersion: " + Version + "\nOpciones:\n" + "Dependencias:\n" + Dependencias

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
  archivos = ARGV
  archivos = Dir["*.rb"] + Dir["*.ui"] if ARGV.empty?
  archivos -= ["integracionQt.rb"]
  archivos -= [ArchivoEjecutable] if (ArchivoEjecutable and (not DirectorioEjecutable))
  $error.verbose = argumentos[:verbose]
  integracionQt = IntegracionQt.new(archivos, DirectorioEjecutable, ArchivoEjecutable, ComandoQt)
  integracionQt.generarEjecutable
end



#-----------------------------------------------------------------------------------------------------------------------
if hacer_perfilado then
$result = RubyProf.stop
printer = RubyProf::FlatPrinter.new($result)
printer.print(STDOUT)
end
#-----------------------------------------------------------------------------------------------------------------------



