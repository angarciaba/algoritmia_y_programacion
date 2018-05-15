#!/usr/bin/env ruby
# encoding: utf-8
# Program: integracionQt.rb
Copyright = 
"Author: Angel Garcia Baños\n" +
"Email: angel.garcia@correounivalle.edu.co\n" +
"Institution: EISC, Universidad del Valle, Colombia" +
"Creation date: 2016-03-29\n" +
"Last modification date: 2018-05-14\n" +
"License: GNU-GPL"
Version = "1.2es"
Descripcion = 
"Hay que especificar los archivos *.ui o los directorios donde están los archivos *.ui que se van a usar para generar el programa.

Facilita la integración de Qt con Ruby, por medio de una interface procedural (solo con funciones, sin conceptos OO). El público objetivo de este programa son los estudiantes de un primer curso de programación. Qt es orientado a objetos (OO), pero si tu eres un programador novato la complejidad OO te puede desanimar y por eso diseñé este programa. 

La metodología que propongo seguir usando este programa es:
- Primero debes diseñar tu interface gráfica usando qtcreator (una herramienta de Qt). Esta herramienta es visual (arrastrar y soltar) de modo que no se necesita saber programar. En tu ventana principal (QMainWindow) debes colocar los Layouts, Buttons, LineEdits, etc. arrastrándolos y soltándolos donde desees. Lo único que debes de hacer es dar un nombre a cada objeto con el que quieras interacturar desde tu programa en Ruby. También debes definir allí los eventos, o sea, cuando un usuario haga clic en un botón, decir qué función de tu programa debe ejecutarse. Para ello debes de usar el editor de Signals/Slots de qtcreator. Tu función será el slot que recibe el evento. No olvides salvar todo, con lo cual se generará un archivo (típicamente mainwindow.ui).
- Debes ejecutar este programa (integracionQt.rb) diciendo en qué directorio(s) está(n) tu(s) archivo(s) *.ui (es obligatorio que exista al menos mainwindow.ui) y tus archivos *_slots.rb (es obligatorio al menos mainwindow_slots.rb) conteniendo las funciones que se van a ejecutar para cada slot. Ejemplos:
    ruby integracionQt.rb directorio
    ruby integracionQt.rb miPrograma.ui

Si lo deseas, con la opción -g se generarán los esqueletos *_slots.rb para que los rellenes. Allí aparecerán los esqueleto de las funciones que debes rellenar y en los comentarios aparecerán todos los objetos nuevos que has definido, así como instrucciones de ayuda. Cada archivo comenzará por el mismo nombre que el correspondiente *.ui. Si el archivo_slots.rb ya existe, no se sobreescribirá.
    ruby integracionQt.rb -g directorio

Como salida se generará el programa llamado miProgramaQt.rb. Este programa es el ejecutable final, que contiene la interface gráfica definida en mainwindow.ui unida al código de tus funciones que están en mainwindow_slots.rb (y cualesquiera otros archivos *.ui y *_slots.rb que existan en los directorios especificados). Puedes ejecutar este programa así:
    ruby miProgramaQt.rb
    


Si no especificas ningún directorio ni ningún archivo se usarán todos los archivos *.ui del directorio actual.
El nombre del archivo de salida siempre es miProgramaQt.rb. Si deseas otro nombre, lo puedes renombrar después de que se haya creado con esta herramienta.



Para los usuarios avanzados: con qtcreator se pueden crear varias ventanas cada una con un nombre *.ui. Solo una de ellas debe llamarse mainwindow.ui. Las otras serán cajas de diálogo (QDialog). Si quieres saber más, mira la documentación de Qt. Y este programa (ruby integracionQt.rb -g) te generará los correspondientes archivos *_slots.rb. Edita todos ellos y añade código al esqueleto de cada función. La segunda vez que ejecutes integracionQt.rb (sin la opción -g) se uniran todos estos archivos en uno solo, que se llamará miProgramaQt.rb

Si deseas mostrar una caja de diálogo desde una de tus funciones, ejecuta la función qtiCreate(dd)  donde dd es el nombre que le hayas puesto a tu caja de diálogo. Y cuando quieras cerrar una caja de diálogo (o la ventana principal mainwindow) típicamente porque el usuario ha hecho clic en un botón de ACEPTAR, CANCELAR o TERMINAR, entonces desde una de sus funciones debes ejecutar qtiDestroy(arg1, arg2, ...). Los argumentos son opcionales y si los pones se retornaran al programa que creó la ventana. Un trozo de código donde se muestra la idea es:

# Archivo: mainwindow.rb
# Creando una nueva ventana desde una de las funciones:
def funcionQueEligeUnArchivo
  a, b, ... = qtiCreate(miCajaDeDialogoParaElegirUnArchivo)
end

# Archivo: micajadedialogoparaelegiriunarchivo.rb
# Función que cierra la ventana:
def terminar
  qtiDestroy(arg1, arg2, ...) # Los argumentos arg1, arg2... se copiarán a las variables a, b... de la función llamante.
end

Usualmente tu querrás retornar algunos valores de la cajaDeDialogo como lineEdits, checkBoxes... a la ventana principal.



Es conveniente que los widgets que crees desde qtcreator les pongas un nombre tuyo propio (y no dejar el nombre por defecto). Así, este programa integracionQt.rb los podrá reconocer. Para todos los widget, además de la interface típica de Qt (que está en la documentación http://doc.qt.io/qt-4.8/qtgui-module.html) este programa añade ciertas funcionalidades extra:
  widget.get.chomp.to_i  # Para leer un entero
  widget.get.chomp.to_f  # Para leer un flotante
  widget.get.chomp.to_s  # Para leer un string
  widget.get.chomp.to_b  # Para leer un booleano
  widget.puts \"mensaje\"  # Para escribir
"
Dependencias =
"
# Instalación de qt4:
sudo apt-get install qt-sdk
# Instalación de rvm:
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
sudo apt-get install software-properties-common
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt-get update
sudo apt-get install rvm
sudo adduser ruby rvm
# En el Teminal - Menu - Editar - Preferencias - Perfiles - Editar - Orden: Ejecutar la orden como un intérprete de acceso (login shell)
rvm fix-permissions
# Logout y volver a loguearse (no basta con cerrar el terminal)
# Instalación de ruby:
rvm install 2.4.3
rvm use 2.4.3
rvm gemset create nombreProyecto
rvm gemset use nombreProyecto
gem install qtbindings bundler
# Instalación de la conexión entre ruby y qt4:
sudo apt-get install ruby-qt4
"
#-----------------------------------------------------------------------------------------------------------------------
# VERSIONES
# 1.2es Elimino los require innecesarios
# 1.1es Corrijo dos bugs: qtiDestroy se acepta ahora con o sin paréntesis. La clase AbstractButton ya no funciona, por lo que se sustituye por CheckBox
# 1.0es Corrijo dos bugs: una RegExp que no funcionaba en todos los casos; y lo que ocurre cuando se ejecuta sin argumentos.
# 0.9es Añade funcionalidades puts y gets a los widgets más comunes. Se ejecuta en una pasada, leyendo los archivos *_slots.rb. O en dos pasadas, donde la primera pasada genera esos archivos (usando la opción -g) con los esqueletos de las funciones (slots).
# 0.8es Con ayudas, clases, funciones y variables en español de nuevo, por si los estudiantes quieren mirar el código
# 0.8 Accept several Ruby versions (without String#end_with? and with improper use of ARGV as Array within Array)
# 0.7 Better ARGV management, when directories are specified.
# 0.6 Spanish to English translation.
# 0.5 Create .rb programmer's files if do not exist, containing all the function's skeleton and all the necessary helps. It they exist, warn on missing functions. In this version output directory and almost all linea command options are eliminated, to ease the use. qtiCreate and qtiDestroy macros are added.
# 0.4 Exec mistake corrected (substituted by system). If there are not files or directories in the command linea, it is assumed 'all'. Output messages are improved.
# 0.3 I have just understand how to generate archivo output. But still missing qtiCreate and qtiDestroy macros, and to assurance all slots have its correspondently functions.
# 0.2 I remove superfluos things, like analizing .ui files (because that task is the responsability of rbuic4 Qt tool). Here I only must to work with the result of rbuic4, that is, the _ui.rb files.
# 0.1 The first one. 
#-----------------------------------------------------------------------------------------------------------------------
# Para ayudar a depurar:
def dd(expresion,env,mensaje="")
  puts "#{expresion}=#{env.eval(expresion)}  #{mensaje}\n==="
end
# Ejemplo:
# a="Hola"
# dd("a",binding)
#-----------------------------------------------------------------------------------------------------------------------
# Para poder usar las gemas del archivo Gemfile: 
#require 'rubygems'
#require 'bundler'
#-----------------------------------------------------------------------------------------------------------------------
# Si el código es lento, puede hacerse un perfilado para buscar donde están las ineficiencias, poniento =true en la siguiente línea:
hacer_perfilado=false
if hacer_perfilado then
require 'ruby-prof'
RubyProf.start
end
#-----------------------------------------------------------------------------------------------------------------------
# Cómo funciona este programa:
# Convierte los archivos *.ui a archivos *_ui.rb usando la herramienta rbuic4 que viene con Qt4.x.
# Identifica las líneas de código de los archivos *_ui.rb que tengan esta forma:
#    attr_reader :miWidget
#    Qt::Object.connect(@miWidget, SIGNAL('clicked()'), mainWindow, SLOT('miFuncion()'))
# con el objetivo de extraer los objetos gráficos que creó el usuario (como miWidget) y las funciones a ejecutar en los SLOTS (como miFuncion)
ElComandoQt4 = "rbuic4"
# Directorio donde generar el ejecutable final, y nombre de ese ejecutable:
ElDirectorioSalida = "."
ElArchivoSalida = "miProgramaQt.rb"
# Nombres por defecto de los widgets de Qt4, seguidos eventualmente por _n (siendo n un número entero):
NombresQtPorDefecto = %w{centralWidget verticalLayoutWidget verticalLayout horizontalLayoutWidget horizontalLayout gridLayoutWidget gridLayout formLayoutWidget formLayout pushButton toolButton radioButton checkBox commandLinkButton buttonBox listView treeView tableView columnView listWidget treeWidget tableWidget groupBox scrollArea scrollAreaWidgetContents toolBox page tabWidget tab stackedWidget frame widget mdiArea comboBox fontComboBox lineEdit textEdit plainTextEdit spinBox doubleSpinBox dateEdit dial horizontalScrollBar verticalScrollBar horizontalSlider verticalSlider keySequenceEdit label textBrowser graphicsView calendarWidget lcdNumber progressBar linea menuBar mainToolBar statusBar dockWidget dockWidgetContents horizontalSpacer verticalSpacer}
# Función del usuario que será llamada por initialize(), el constructor del GUI de Qt:
FuncionDeInicializacion = "inicializar()"  
#-----------------------------------------------------------------------------------------------------------------------

class IntegracionQt
  def initialize(archivosUI, directorioSalida, archivoSalida, comandoQt4, generarEsqueletos)
    @archivosUI, @directorioSalida, @archivoSalida, @comandoQt4, @generarEsqueletos = archivosUI, directorioSalida, archivoSalida, comandoQt4, generarEsqueletos
    @nombresDeWidgetsYSlots = {}
  end
  
  
  def crearEjecutable
    # Crear el directorio de salida:
    Dir.mkdir @directorioSalida if (@directorioSalida != "." and (not File.directory? @directorioSalida))

    # Verificar si existe el archivo mainwindow.ui, que debió crearlo el usuario con qtcreator. Si no existe, es imposible continuar:
    unless @archivosUI.inject(false) { |encontrado, archivo| (encontrado or (File.basename(archivo) == "mainwindow")) }
      $error.abortar "No existe el archivo mainwindow.ui. Usted debe especificar en que directorio está. O debe crearlo usando qtcreator." 
    end

    # Convertir archivos .ui a archivos _ui.rb usando cierto comando de Qt:
    @archivosUI.each { |archivo| system "#{@comandoQt4} #{archivo}.ui -o #{archivo}_ui.rb" }
    
    # Extraer los widgets y los slots de cada archivo _ui.rb:    
    @archivosUI.each do |archivo|
      nombreDeLosWidgets, nombreDeLosSlots, nombreDeLasClases = extraerWidgetsYSlots("#{archivo}_ui.rb")
      @nombresDeWidgetsYSlots[archivo] = [nombreDeLosWidgets.uniq, nombreDeLosSlots.uniq, nombreDeLasClases]
    end
    
    if @generarEsqueletos
      # Crear un archivo _slots.rb por cada archivo .ui existente y reportar allí todo lo encontrado:
      crearArchivosEsqueletoRb()
    else
      # Generar el archivo de salida, leyendo los archivos *_slots.rb y juntando adecuadamente todos los archivos de entrada:
      generarArchivoDeSalida()
    end
    
    # Borrar los archivos temporales:
    @archivosUI.each { |archivo| File.delete "#{archivo}_ui.rb" }
  end
  
    
  # Generar el archivo de salida, juntando adecuadamente todos los archivos de entrada:
  def generarArchivoDeSalida()
    archivoFaltante = false
    open("#{@directorioSalida}/#{@archivoSalida}", "w") do |flujoDeSalida|
      # Primero se copian a la salida todos los archivos *_ui.rb:
      @archivosUI.each do |archivo| 
        flujoDeSalida << "#-----------------------------------------------\n\n"
        open("#{archivo}_ui.rb") { |flujoDeEntrada| flujoDeSalida << flujoDeEntrada.read }
      end
      # Luego se añaden las nuevas funcionalidades a los widgets (gets y puts):
      flujoDeSalida << "#-----------------------------------------------\n"
      flujoDeSalida << "require 'Qt4'\n\n"
      nuevasFuncionalidades(flujoDeSalida)
      flujoDeSalida << "#-----------------------------------------------\n"

      # Se crean las clases definidas por el usuario. La clase procedente de mainwindow debe llamarse MainForm y hereda de MainWindow. Las demás clases se llaman QtI_nombreDelArchivo y heredan de Dialog 
      @nombresDeWidgetsYSlots.each do |archivo, widget_slot_clase|
        flujoDeSalida << "class #{File.basename(archivo) == "mainwindow" ? "MainForm" : "QtI_"+widget_slot_clase[2]} < Qt::#{File.basename(archivo) == "mainwindow" ? "MainWindow" : "Dialog"}\n"
        # En cada clase se declaran los slots que va a usar:
        if widget_slot_clase[1].length > 0
          flujoDeSalida << "  slots '#{widget_slot_clase[1][0]}'"
          widget_slot_clase[1].drop(1).each { |slot| flujoDeSalida << ", '#{slot}'" }
          flujoDeSalida << "\n  attr_accessor :qtiResults # Para retornar valores si se cierra esta ventana\n"
        end
        # Añadir los archivos *_slots.rb con las definiciones de funciones que son slots en el archivo .ui:
        encontreLaFuncionDeInicializacion = false
        if File.file? archivo+"_slots.rb"
          open(archivo+"_slots.rb").each do |linea|
            encontreLaFuncionDeInicializacion = true if linea.match "^\s*def\s+#{FuncionDeInicializacion}"
            case linea
            when /^(.*?)=?\s*qtiCreate(\((.*)\))?/
              if $1[0] != "#"
                flujoDeSalida << "      dialog_#{$2} = QtI_#{$2}.new(self)\n"
                flujoDeSalida << "      dialog_#{$2}.exec\n"
                flujoDeSalida << "      #{$1.strip} = dialog_#{$2}.qtiResults\n" if (not $1.strip.empty?)
              else
                flujoDeSalida << linea << "\n"
              end
            when /^(.*?)qtiDestroy\(?([^)]*)\)?/
              if $1[0] != "#"
                variables = buscarYConvertirNombres($2, widget_slot_clase[0])
                flujoDeSalida << "      @qtiResults = [ #{variables} ]\n"
                flujoDeSalida << "      close()\n"
              else
                flujoDeSalida << linea << "\n"
              end
            else
              flujoDeSalida << buscarYConvertirNombres(linea, widget_slot_clase[0])
            end
          end
        else
          archivoFaltante = archivo
        end
        flujoDeSalida << "\n\n"
        flujoDeSalida << "  def initialize(parent=nil)\n"
        flujoDeSalida << "    super(parent)\n"
        flujoDeSalida << "    @ui = Ui::#{widget_slot_clase[2]}.new\n"
        flujoDeSalida << "    @ui.setup_ui(self)\n"
        flujoDeSalida << (encontreLaFuncionDeInicializacion ? " " : "#")
        flujoDeSalida <<  "   inicializar()\n"
        flujoDeSalida << "    self.show\n"
        flujoDeSalida << "  end\n"
        flujoDeSalida << "end\n\n"
      end
      flujoDeSalida << "\n\n\n"
      flujoDeSalida << "if $0 == __FILE__\n"
      flujoDeSalida << "  app = Qt::Application.new(ARGV)\n"
      flujoDeSalida << "  MainForm.new\n"
      flujoDeSalida << "  app.exec\n"
      flujoDeSalida << "end\n\n"
    end
    
    if archivoFaltante
      $error.error "No se puede continuar. Falta el archivo #{archivoFaltante}_slots.rb con las funciones (slots) de la ventana #{archivoFaltante}.ui. Puedes generar un esqueleto de este archivo ejecutando de nuevo el programa con la opción -g (los demás archivos *_slots.rb no se sobreescribiran)" if not @generarEsqueletos
      File.delete "#{@directorioSalida}/#{@archivoSalida}"
    end
  end  


  # Crear un archivo _slots.rb por cada archivo .ui existente y reportar allí todo lo encontrado:
  def crearArchivosEsqueletoRb()
    @nombresDeWidgetsYSlots.each do |archivo, widget_slot_clase|
      if File.exists? "#{archivo}_slots.rb"
        puts "El archivo #{archivo}_slots.rb ya existe, por lo que no lo voy a sobreescribir. Si necesita regenerarlo de nuevo, debe borrar usted el original."
        funcionesEncontradas = []
        open("#{archivo}_slots.rb").each do |linea|
          if linea.match(/(\s*)def(\s+)(.*)/)
            funcionesEncontradas << "#{$3}"
          end
        end
        funcionesNoEncontradas = widget_slot_clase[1] - funcionesEncontradas
        if not funcionesNoEncontradas.empty?
          puts "Sin embargo, todavía faltan las siguientes funciones, que deberías añadir:\n\n"
          funcionesNoEncontradas.each { |slot| puts "    def #{slot}\n      # Pendiente de hacer\n    end\n\n" }
        end
      else
        puts "El archivo #{archivo}_slots.rb no existe, por lo que voy a crearlo con los esqueletos de las funciones que debes rellenar."
        open("#{archivo}_slots.rb", "w") do |flujoDeSalida|
          flujoDeSalida << "# Archivo: #{File.basename(archivo)}_slots.rb\n# Autor: \n# Email: \n"
          flujoDeSalida << "# Generado automáticamente por #{__FILE__} by Angel Garcia <angarciaba@gmail.com> licencia GPL 3.0\n"
          flujoDeSalida << "# En el caso de que este archivo exista, no se sobreescribirá. De modo que puede usted añadir o modificar el código sin peligro de perderlo en la siguiente iteración.\n"
          flujoDeSalida << "# Utilidad: contiene las funciones (slots creados por usted con qtcreator) que deben ser completadas por usted, para terminar de generar la interface del archivo #{File.basename(archivo)}.ui\n#"

          flujoDeSalida << "\n# Dentro de esas funciones se pueden usar los siguientes widgets creados por usted con qtcreator:"
          widget_slot_clase[0].each { |nombreWidget| flujoDeSalida << "\n#    #{nombreWidget}" if (not esUnNombrePorDefecto?(nombreWidget)) } 
          flujoDeSalida << "\n#\n# También existen estos otros widgets, pero usted no les ha dado nombre, por lo que probablemente no le interese usarlos (aunque nada impide que los use):\n"
          widget_slot_clase[0].each { |nombreWidget| flujoDeSalida << "#    #{nombreWidget}\n" if esUnNombrePorDefecto?(nombreWidget) }
          
          # v0.9 begin
          flujoDeSalida << "#\n#Para ofrecer mayor facilidad de uso a todos estos widgets, se les ha añadido las funciones de entrada/salida gets y puts, de modo que puede leerlos y escribirlos así:"
          flujoDeSalida << "\n#  x = widget.gets.chomp.to_i # Para leer un número entero"
          flujoDeSalida << "\n#  x = widget.gets.chomp.to_f # Para leer un número flotante"
          flujoDeSalida << "\n#  x = widget.gets.chomp.to_s # Para leer un string"
          flujoDeSalida << "\n#  x = widget.gets.chomp.to_b # Para leer un booleano true/false"
          flujoDeSalida << "\n#  widget.puts string  # Para imprimir un string (puede usar los interpoladores habituales para insertar variables) "
          # v0.9 end

          flujoDeSalida << "\n#\n# Si quiere usar otras funcionalidades de estos objetos gráficos debe consultar aquí:"
          flujoDeSalida << "\n#   http://doc.qt.io/qt-4.8/qtgui-module.html"

          flujoDeSalida << "\n#\n# En sus funciones usted puede llamar a:"
          flujoDeSalida << "\n#  aa = qtiCreate(dd) # para crear una nueva ventana de tipo QDialog. Como argumento (dd) le debe pasar el nombre del objeto gráfico a crear (de tipo QDialog). En aa retorna un array con los argumentos que envió el qtiDestroy(). Usted puede (y debe) poner nombres distintos a dd y aa."
          flujoDeSalida << "\n#  qtiDestroy(arg1, arg2, etc) # para destruir la ventana actual. arg1, arg2, etc son argumentos opcionales de retorno, que los recibirá en el array aa retornado a la función qtiCreate() que creó esta ventana."

          flujoDeSalida << "\n#\n# Las funciones a completar son: \n\n"
          widget_slot_clase[1].each { |slot| flujoDeSalida << "    def #{slot}\n      # Pendiente de hacer\n    end\n\n" }
        end
      end
    end
  end


  def nuevasFuncionalidades(flujoDeSalida)
    flujoDeSalida << "# Patch monkey muy sabroso :):D:)\n"
    flujoDeSalida << "module Qt\n"

    flujoDeSalida << "  class AbstractSlider   # Slider y Dial\n"
    flujoDeSalida << "    def puts(a)\n"
    flujoDeSalida << "      setValue(a.to_i)\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "    def gets\n"
    flujoDeSalida << "      value.to_s\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "  end\n"

    flujoDeSalida << "  class CheckBox    # (AbstractButton ya no funciona)\n"
    flujoDeSalida << "    def puts(a)\n"
    flujoDeSalida << "      setChecked(a.to_b)\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "    def gets\n"
    flujoDeSalida << "      isChecked ? 'true' : 'false'\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "  end\n"

    flujoDeSalida << "  class Date\n"
    flujoDeSalida << "    def puts(a)\n"
    flujoDeSalida << "     b = /(....)-(..)-(..)/.match(a)\n"
    flujoDeSalida << "      setDate(b[1], b[2], b[3])\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "    def gets\n"
    flujoDeSalida << "      toString('YYYY-MM-DD')\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "  end\n"

    flujoDeSalida << "  class DateTime\n"
    flujoDeSalida << "    def puts(a)\n"
    flujoDeSalida << "     b = /(....)-(..)-(..) (..):(..):(..)/.match(a)\n"
    flujoDeSalida << "      setDate(b[1], b[2], b[3])\n"
    flujoDeSalida << "      setHMS(b[4], b[5], b[6])\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "    def gets\n"
    flujoDeSalida << "      toString('yyyy-MM-dd hh:mm:ss')\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "  end\n"

    flujoDeSalida << "  class DoubleSpinBox\n"
    flujoDeSalida << "    def puts(a)\n"
    flujoDeSalida << "      setValue(a.to_f)\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "    def gets\n"
    flujoDeSalida << "      value.to_s\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "  end\n"

    flujoDeSalida << "  class Label\n"
    flujoDeSalida << "    def puts(a)\n"
    flujoDeSalida << "      setText(a)\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "    def gets\n"
    flujoDeSalida << "      text\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "  end\n"

    flujoDeSalida << "  class LCDNumber\n"
    flujoDeSalida << "    def puts(a)\n"
    flujoDeSalida << "      display(a)\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "    def gets\n"
    flujoDeSalida << "      value.to_s\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "  end\n"

    flujoDeSalida << "  class LineEdit\n"
    flujoDeSalida << "    def puts(a)\n"
    flujoDeSalida << "      setText(a)\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "    def gets\n"
    flujoDeSalida << "      text\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "  end\n"

    flujoDeSalida << "  class PlainTextEdit\n"
    flujoDeSalida << "    def puts(a)\n"
    flujoDeSalida << "      setPlainText(a)\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "    def gets\n"
    flujoDeSalida << "      toPlainText\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "  end\n"

    flujoDeSalida << "  class ProgressBar\n"
    flujoDeSalida << "    def puts(a)\n"
    flujoDeSalida << "      setValue(a.to_i)\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "    def gets\n"
    flujoDeSalida << "      value.to_s\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "  end\n"

    flujoDeSalida << "  class PushButton\n"
    flujoDeSalida << "    def puts(a)\n"
    flujoDeSalida << "      setText(a)\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "    def gets\n"
    flujoDeSalida << "      text\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "  end\n"

    flujoDeSalida << "  class RadioButton\n"
    flujoDeSalida << "    def puts(a)\n"
    flujoDeSalida << "      setChecked(a.to_b)\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "    def gets\n"
    flujoDeSalida << "      isChecked ? 'true' : 'false'\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "  end\n"

    flujoDeSalida << "  class SpinBox\n"
    flujoDeSalida << "    def puts(a)\n"
    flujoDeSalida << "      setValue(a.to_i)\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "    def gets\n"
    flujoDeSalida << "      value.to_s\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "  end\n"

    flujoDeSalida << "  class TextEdit\n"
    flujoDeSalida << "    def puts(a)\n"
    flujoDeSalida << "      setText(a)\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "    def gets\n"
    flujoDeSalida << "      text\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "  end\n"

    flujoDeSalida << "  class Time\n"
    flujoDeSalida << "    def puts(a)\n"
    flujoDeSalida << "     b = /(..):(..):(..)/.match(a)\n"
    flujoDeSalida << "      setHMS(b[1], b[2], b[3])\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "    def gets\n"
    flujoDeSalida << "      toString('hh:mm:ss')\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "  end\n"

    flujoDeSalida << "end\n\n"

    flujoDeSalida << "  class String\n"
    flujoDeSalida << "    def to_b\n"
    flujoDeSalida << "      (self == 'false' or self == '') ? false : true\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "  end\n"

    flujoDeSalida << "  class FalseClass\n"
    flujoDeSalida << "    def to_s\n"
    flujoDeSalida << "      'false'\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "  end\n"

    flujoDeSalida << "  class TrueClass\n"
    flujoDeSalida << "    def to_s\n"
    flujoDeSalida << "      'true'\n"
    flujoDeSalida << "    end\n"
    flujoDeSalida << "  end\n"
  end


  # Verifica si un token es un nombre por defecto de algún Widget de Qt4:
  def esUnNombrePorDefecto?(token)
    NombresQtPorDefecto.each { |nombre| return true if token.match /^#{nombre}_?(\d)*$/ }
    return false
  end



  # Busca nombres de widgets en la linea de texto, asegurándose de que no formen parte de una palabra más larga. Pone delante de cada uno:  "@ui."
  def buscarYConvertirNombres(linea, widgets)
    añadirDelante =  "@ui."
    widgets.each do |unWidget|
      indice = 0
      loop do
        indice = linea.index(unWidget, indice)
        break unless indice
        if ((indice == 0 or (not linea[indice-1].match(/\w/))) and (indice+unWidget.length > linea.length or (not linea[indice+unWidget.length].match(/\w/))))
          linea.insert(indice, añadirDelante)
          indice += añadirDelante.length
        end
        indice += unWidget.length
      end
    end
    linea
  end
 
 
  def end_with?(string, ending)
    string.index(ending) == string.size - ending.size
  end
  

  # Dado un archivo _rb.ui extrae todos los widgets, slots y nombres de clases:
  def extraerWidgetsYSlots(archivo)
    widgets = []
    slots = [ FuncionDeInicializacion ]
    todasLasLineas = ""
    open(archivo).each do |linea|
      encontrado = /^\s*attr_reader\s*:(\w*)/.match(linea)
      widgets << encontrado[1] if encontrado
      encontrado = /^\s*Qt::Object\.connect\(@?\w+,\s*SIGNAL\(.*?\),\s*\w+,\s*SLOT\('(.+?)'\)\)/.match(linea)
      slots << encontrado[1] if encontrado
      todasLasLineas << linea
    end
    return widgets, slots, todasLasLineas.match(/^module\s+Ui\s+class (\w+)/)[1]
  end

end


#-----------------------------------------------------------------------------------------------------------------------
require 'optparse'
class ArgumentosEnLaLineaDeComandos < Hash
  def initialize(args)
    super()
    self[:esqueletos] = false
    opciones = OptionParser.new do |opcion|
      opcion.banner = "Use: #$0 [opciones] archivos.ui o directorios [...]\n\n" + Descripcion + "\n\n" + Copyright + "\nVersion: " + Version + "\nOptions:\n" + "Dependencias:\n" + Dependencias

      opcion.on('-g', '--generar-esqueletos', 'genera los archivos _slots.rb con los esqueletos de las funciones (los slots definidos en los archivos *.ui)') do 
        self[:esqueletos] = true
      end

      opcion.on('-b', '--verbose', 'muestra todos los errores y avisos que ocurran') do
        self[:verbose] = true
      end

      opcion.on('-v', '--version', 'muestra la versión y termina') do
        puts Version
        exit
      end

      opcion.on_tail('-h', '--help', 'muestra esta ayuda y termina') do
        puts opcion
        exit
      end
    end

    opciones.parse!(args)
  end
end



require 'singleton'
class Error
  include Singleton
  attr_accessor :verbose

  def initialize
    @verbose = false
  end
  
  def aviso(string)
    if @verbose then puts "AVISO: #{string}" end
  end
  
  def error(string)
    puts "ERROR: #{string}"
  end

  def abortar(string)
    puts "ERROR FATAL: #{string}"
    exit 1
  end
end



if $0 == __FILE__
  $error = Error.instance
  argumentos = ArgumentosEnLaLineaDeComandos.new(ARGV)
  archivosUI = []
  directorios = ARGV
  directorios = ["."] if ARGV.empty?
  directorios.each do |directorio| 
    if File.directory?(directorio)
      Dir["#{directorio}/*.ui"].each { |archivo| archivosUI << "#{directorio}/#{File.basename(archivo, ".ui")}"}
    else
      archivosUI << File.basename(directorio, ".ui") if File.extname(directorio) == ".ui"
    end
  end
  $error.verbose = argumentos[:verbose]
  integracionQt = IntegracionQt.new(archivosUI.flatten, ElDirectorioSalida, ElArchivoSalida, ElComandoQt4, argumentos[:esqueletos])
  integracionQt.crearEjecutable
end



#-----------------------------------------------------------------------------------------------------------------------
if hacer_perfilado then
$result = RubyProf.stop
printer = RubyProf::FlatPrinter.new($result)
printer.print(STDOUT)
end
#-----------------------------------------------------------------------------------------------------------------------



