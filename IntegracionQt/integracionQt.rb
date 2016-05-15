#!/usr/bin/env ruby
# encoding: utf-8
# Program: integracionQt.rb
Copyright = 
"Author: Angel Garcia Baños\n" +
"Email: angel.garcia@correounivalle.edu.co\n" +
"Institution: EISC, Universidad del Valle, Colombia" +
"Creation date: 2016-03-29\n" +
"Last modification date: 2016-05-15\n" +
"License: GNU-GPL"
Version = "0.7"
Description = 
"Eases programing Qt with Ruby, providing a procedural interface to Qt. The public objective are students in its first programming course. Qt is object oriented, but if you are a novice programmer, all this OO complexity can be overhelming. The methodology is: 
- You must design your graphical interface with qtcreator (a tool from Qt). This tool is visual, not programming is required. In your QMainWindow, you must place layouts, buttons, line edits, etc in a copy&paste way. You only must name the objects your program will going to read or to write. You also need to define events, i.e. when user clicks on that button, which function must be executed. In order to do this, you must use the Qt signal/slot mechanism, being the slot your function (you must give the slot the name of your function). Do not forget to save all, thus generating a .ui file.
- Yo must execute this program twice, telling what are your .ui file(s) (i.e. ruby integracionQt.rb file(s).ui).
- The first time you execute it, it generates skeleton .rb files with the functions that you must write, and the graphical objects you can use.
- The second time, it integrates that .rb files you write with the .ui files you design, creating your complete Qt application, a 'program.rb' file ready to be executed. 

It shold be noted that you can create many .ui files (each file is one window, only one of them is a QMainWindow, the others are QDialog (see Qt tutorials for more explanatios)). And it must be one .rb file for each .ui file, containing all the functions the .ui file needs as slots.

In order to show a new window (usually a QDialog) from one of your functions, you dispose a new function: qtiCreate(dd). In this, dd is the name you give to the window (QDialog) that you want to pop up.

Also, when you need to close a window (usually because the user clicks on a 'Accept/Cancel' button),you dispone another function: qtiDestroy(arg1, arg2, ...). With this, you can return as many arguments as you need to the calling function. The complete code snippet will be:
# File: mainwindow.rb
# Calling function:
def chooseFile
  a, b, ... = qtiCreate(MyFileDialog)
end

# File: myfiledialog.rb
# Function that closes the window:
def accept
  qtiDestroy(arg1, arg2, ...)
end

Usually you want to return some values from QDialog window objects (lineEdits, checkBoxes...) to the QMainWindow.
"
Dependences =
"
sudo apt-get install qt4-dev-tools libqt4-dev libqt4-core libqt4-gui
sudo apt-get install ruby-qt4 qtcreator cmake
gem install qtbindings
"
#-----------------------------------------------------------------------------------------------------------------------
# VERSIONS
# 0.7 Better ARGV management, when directories are specified.
# 0.6 Spanish to English translation.
# 0.5 Create .rb programmer's files if do not exist, containing all the function's skeleton and all the necessary helps. It they exist, warn on missing functions. In this version output directory and almost all line command options are eliminated, to ease the use. qtiCreate and qtiDestroy macros are added.
# 0.4 Exec mistake corrected (substituted by system). If there are not files or directories in the command line, it is assumed 'all'. Output messages are improved.
# 0.3 I have just understand how to generate file output. But still missing qtiCreate and qtiDestroy macros, and to assurance all slots have its correspondently functions.
# 0.2 I remove superfluos things, like analizing .ui files (because that task is the responsability of rbuic4 Qt tool). Here I only must to work with the result of rbuic4, that is, the _ui.rb files.
# 0.1 The first one. 
#-----------------------------------------------------------------------------------------------------------------------
# To help debbuging:
def dd(expression,env,menssage="")
  puts "#{expression}=#{env.eval(expression)}  #{menssage}\n==="
end
# Example:
# a="Hello"
# dd("a",binding)
#-----------------------------------------------------------------------------------------------------------------------
# In order to bundle gets the gems specified in Gemfile: 
require 'rubygems'
require 'bundler/setup'
#-----------------------------------------------------------------------------------------------------------------------
# In case of unefficient code, it can be profiled putting =true in the following line: 
to_do_profiling=false
if to_do_profiling then
require 'ruby-prof'
RubyProf.start
end
#-----------------------------------------------------------------------------------------------------------------------
# Operating comments to myself:
# I must to convert *.ui files on *_ui.rb files using rbuic4 Qt tool.
# I must to code to recognize these lines into *_ui.rb files:
#    attr_reader :pushButton
#    Qt::Object.connect(@myPushButton, SIGNAL('clicked()'), mainWindow, SLOT('throw_a_dice()'))
# in order to extract the graphical object names as myPushButton, and the SLOTs as throw_a_dice()
QtCommand = "rbuic4"
# Directory where executable Ruby file is written:
OutputDirectory = "."
OutputFile = "myqtprogram.rb"
# Default Qt widget's names, followed eventually by _number:
DefaultQtNames = %w{centralWidget verticalLayoutWidget verticalLayout horizontalLayoutWidget horizontalLayout gridLayoutWidget gridLayout formLayoutWidget formLayout pushButton toolButton radioButton checkBox commandLinkButton buttonBox listView treeView tableView columnView listWidget treeWidget tableWidget groupBox scrollArea scrollAreaWidgetContents toolBox page tabWidget tab stackedWidget frame widget mdiArea comboBox fontComboBox lineEdit textEdit plainTextEdit spinBox doubleSpinBox dateEdit dial horizontalScrollBar verticalScrollBar horizontalSlider verticalSlider keySequenceEdit label textBrowser graphicsView calendarWidget lcdNumber progressBar line menuBar mainToolBar statusBar dockWidget dockWidgetContents horizontalSpacer verticalSpacer}
InitializeFunction = "inicializar()"  # Function to be called from the graphical object constructor, initialize()
#-----------------------------------------------------------------------------------------------------------------------

class IntegracionQt
  def initialize(inputFiles, outputDirectory, outputFile, qtCommand)
    @inputFiles, @outputDirectory, @outputFile, @qtCommand = inputFiles, outputDirectory, outputFile, qtCommand
    @objectNamesAndSlots = {}
  end
  
  
  def buildExecutable
    # Create output directory:
    Dir.mkdir @outputDirectory if (@outputDirectory != "." and (not File.directory? @outputDirectory))

    # Separate input .ui files and input .rb files:
    inputFiles = separateFiles(@inputFiles)
    
    # Verify to exist mainwindow.ui file. Otherwise it is impossible to continue:
    unless inputFiles[".ui"].inject(false) { |found, file| ((found or File.basename(file)) == "mainwindow") }
      $error.abortar "Missing mainwindow.ui file" 
    end

    # Convert .ui files to _ui.rb files using certain Qt command:
    inputFiles[".ui"].each { |file| system "#{@qtCommand} #{file}.ui -o #{@outputDirectory}/#{File.basename(file)}_ui.rb" }
    
    # Extract graphic object and slots from each _ui.rb file:    
    inputFiles[".ui"].each do |file|
      graphicObjects, slots, className = extractGraphicObjectsAndSlots("#{@outputDirectory}/#{File.basename(file)}_ui.rb")
      @objectNamesAndSlots[file] = [graphicObjects.uniq, slots.uniq, className]
    end
    
    # Report all found and create one .rb file from each .ui file:
    createRbFileSkeletons()
    
    # Write output file by merging adequately all input files:
    writeOutputFile(inputFiles)

    # Remove temporal files:
    inputFiles[".ui"].each { |files| File.delete "#{@outputDirectory}/#{File.basename(files)}_ui.rb" }
  end
  
  
  
  # Write output file by merging adequately all input files:
  def writeOutputFile(inputFiles)
    open("#{@outputDirectory}/#{@outputFile}", "w") do |outputStream|
      inputFiles[".ui"].each do |file| 
        outputStream << "#-----------------------------------------------\n\n"
        open("#{@outputDirectory}/#{File.basename(file)}_ui.rb") { |inputStream| outputStream << inputStream.read }
      end
        
      @objectNamesAndSlots.each do |file, graphicObjects_slots|
        outputStream << "#-----------------------------------------------\n"
        outputStream << "require 'Qt4'\n"
        outputStream << "class #{File.basename(file) == "mainwindow" ? "MainForm" : "QtI_"+graphicObjects_slots[2]} < Qt::#{File.basename(file) == "mainwindow" ? "MainWindow" : "Dialog"}\n"
        if graphicObjects_slots[1].length > 0
          outputStream << "  slots '#{graphicObjects_slots[1][0]}'"
          graphicObjects_slots[1].drop(1).each { |slot| outputStream << ", '#{slot}'" }
          outputStream << "\n  attr_accessor :qtiResults # To return values when this window will be closed\n"
        end
        # To add .rb files with the function definitions that are slots in the .ui file:
        inicializarFound = false
        if File.file? file+".rb"
          open(file+".rb").each do |line|
            inicializarFound = true if line.match "^\s*def\s+#{InitializeFunction}"
            case line
            when /^(.*?)=?\s*qtiCreate\((.*)\)/
              if $1[0] != "#"
                outputStream << "      dialog_#{$2} = QtI_#{$2}.new(self)\n"
                outputStream << "      dialog_#{$2}.exec\n"
                outputStream << "      #{$1.strip} = dialog_#{$2}.qtiResults\n" if (not $1.strip.empty?)
              else
                outputStream << line << "\n"
              end
            when /^(.*?)qtiDestroy\((.*)\)/
              if $1[0] != "#"
                variables = findAndConvertNames($2, graphicObjects_slots[0])
                outputStream << "      @qtiResults = [ #{variables} ]\n"
                outputStream << "      close()\n"
              else
                outputStream << line << "\n"
              end
            else
              outputStream << findAndConvertNames(line, graphicObjects_slots[0])
            end
          end
        end
        outputStream << "\n\n"
        outputStream << "  def initialize(parent=nil)\n"
        outputStream << "    super(parent)\n"
        outputStream << "    @ui = Ui::#{graphicObjects_slots[2]}.new\n"
        outputStream << "    @ui.setup_ui(self)\n"
        outputStream << (inicializarFound ? " " : "#")
        outputStream <<  "   inicializar()\n"
        outputStream << "    self.show\n"
        outputStream << "  end\n"
        outputStream << "end\n\n"
      end
        outputStream << "\n\n\n"
      outputStream << "if $0 == __FILE__\n"
      outputStream << "  app = Qt::Application.new(ARGV)\n"
      outputStream << "  MainForm.new\n"
      outputStream << "  app.exec\n"
      outputStream << "end\n\n"
    end
  end  



  # Report all found and .rb file creation for each .ui file:
  def createRbFileSkeletons()
    @objectNamesAndSlots.each do |file, graphicObjects_slots|
      if File.exists? "#{file}.rb"
        puts "File #{file}.rb exists, thus it will not be overwritten"
        foundedFunctions = []
        open("#{file}.rb").each do |line|
          if line.match(/(\s*)def(\s+)(.*)/)
            foundedFunctions << "#{$3}"
          end
        end
        missingFunctions = graphicObjects_slots[1] - foundedFunctions
        if not missingFunctions.empty?
          puts "However, still missing the following functions, that you can complete if you need:\n\n"
          missingFunctions.each { |slot| puts "    def #{slot}\n      # Pendiente de hacer\n    end\n\n" }
        end
      else
        puts "File #{file}.rb does not exists, thus it will be created with the function skeletons that you must write."
        open("#{file}.rb", "w") do |outputStream|
          outputStream << "# Archivo: #{File.basename(file)}.rb\n# Autor: \n# Email: \n"
          outputStream << "# Generado automáticamente por #{__FILE__} by Angel Garcia <angarciaba@gmail.com> licencia GPL 3.0\n"
          outputStream << "# En el caso de que este file exista, no se sobreescribirá\n"
          outputStream << "# Utilidad: contiene las funciones (slots) que deben ser completadas por usted, para terminar de generar la interface del file #{File.basename(file)}.ui\n#"

          outputStream << "\n# Dentro de esas funciones se pueden usar los siguientes objetos gráficos:\n"
          graphicObjects_slots[0].each { |guiObject| outputStream << "#   #{guiObject}\n" if (not isDefaultName?(guiObject)) } #     (que es de tipo #{})
          outputStream << "\n# Para poder usar estos objetos gráficos puede consultar sus propiedades y funcionalidades aquí:"
          outputStream << "\n#   http://doc.qt.io/qt-4.8/qtgui-module.html"
          outputStream << "\n#\n# También existen estos otros objetos gráficos, pero usted no les ha dado nombre, por lo que probablemente no le interese usarlos:\n# "
          graphicObjects_slots[0].each { |guiObject| outputStream << " #{guiObject}" if isDefaultName?(guiObject) }

          outputStream << "\n#\n# En sus funciones usted puede llamar a:"
          outputStream << "\n#  - aa = qtiCreate(dd) para crear una nueva ventana de tipo QDialog. Como argumento (dd) le debe pasar el nombre del objeto gráfico a crear (de tipo QDialog). En aa retorna un array con los Arguments que envió el qtiDestroy(). Usted puede y debe poner nombres distintos a dd y aa."
          outputStream << "\n#  - qtiDestroy(arg1, arg2, etc) para destruir la ventana actual. arg1, arg2, etc son Arguments opcionales de retorno, que los recibirá en el array aa retornado a la función qtiCreate() que creó esta ventana."

          outputStream << "\n#\n# Las funciones a completar son: \n\n"
          graphicObjects_slots[1].each { |slot| outputStream << "    def #{slot}\n      # Pendiente de hacer\n    end\n\n" }
        end
      end
    end
  end



  # Verifies if a token is a Qt widget default name:
  def isDefaultName?(token)
    DefaultQtNames.each { |name| return true if token.match "#{name}(_\d+)?" }
    return false
  end



  # Searches for widgets into the line. Verifies it does not make part of a larger word. Puts before them "@ui."
  def findAndConvertNames(line, graphicObjects)
    graphicObjects.each do |attribute|
      index = 0
      loop do
        index = line.index(attribute, index)
        break unless index
        if ((index == 0 or (not line[index-1].match(/\w/))) and (index+attribute.length > line.length or (not line[index+attribute.length].match(/\w/))))
          line.insert(index, "@ui.")
          index += "@ui.".length
        end
        index += attribute.length
      end
    end
    line
  end
 


  # Creates a two-raw array. Raw 0 is a array containing the input .ui files. Raw 1 is another array with the .rb input files
  def separateFiles(inputFiles)
    files = Hash.new() { |hash, key| hash[key] = [] }
    inputFiles.each do |file|
      [".ui", ".rb"].each do |extension|
        files[extension] << file.chomp(extension) if file.end_with?(extension)
      end
    end
    files
  end
  


  # Given a _rb.ui file, it extracts all widgets and all slots:   
  def extractGraphicObjectsAndSlots(file)
    guiObjects = []
    guiSlots = [ InitializeFunction ]
    allLines = ""
    open(file).each do |line|
      found = /^\s*attr_reader\s*:(\w*)/.match(line)
      guiObjects << found[1] if found
      found = /^\s*Qt::Object\.connect\(@?\w+,\s*SIGNAL\(.*?\),\s*\w+,\s*SLOT\('(.+?)'\)\)/.match(line)
      guiSlots << found[1] if found
      allLines << line
    end
    return guiObjects, guiSlots, allLines.match(/^module\s+Ui\s+class (\w+)/)[1]
  end

end


#-----------------------------------------------------------------------------------------------------------------------
require 'optparse'
class Arguments < Hash
  def initialize(args)
    super()
    options = OptionParser.new do |option|
      option.banner = "Use: #$0 [option] files [...]\n\n" + Description + "\n\n" + Copyright + "\nVersion: " + Version + "\nOptions:\n" + "Dependences:\n" + Dependences

      option.on('-b', '--verbose', 'shows all warnings and errors found') do
        self[:verbose] = true
      end

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



require 'singleton'
class Error
  include Singleton
  attr_accessor :verbose

  def initialize
    @verbose = false
  end
  
  def warn(string)
    if @verbose then puts "WARNING: #{string}" end
  end
  
  def abortar(string)
    puts "FATAL ERROR: #{string}"
    exit 1
  end
end



if $0 == __FILE__
  $error = Error.instance
  arguments = Arguments.new(ARGV)
  files = []
  files = Dir["*.rb"] + Dir["*.ui"] if ARGV.empty?
  ARGV.each do |file| 
    if File.directory?(file)
      files << Dir["#{file}/*.rb"] + Dir["#{file}/*.ui"]
    else
      files << file
    end
  end
  files -= ["integracionQt.rb"]
  files -= [OutputFile] if (OutputFile and (not OutputDirectory))
  $error.verbose = arguments[:verbose]
  integracionQt = IntegracionQt.new(files, OutputDirectory, OutputFile, QtCommand)
  integracionQt.buildExecutable
end



#-----------------------------------------------------------------------------------------------------------------------
if to_do_profiling then
$result = RubyProf.stop
printer = RubyProf::FlatPrinter.new($result)
printer.print(STDOUT)
end
#-----------------------------------------------------------------------------------------------------------------------



