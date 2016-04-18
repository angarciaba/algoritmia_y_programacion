#-----------------------------------------------

=begin
** Form generated from reading ui file 'acercade.ui'
**
** Created: dom abr 17 22:11:31 2016
**      by: Qt User Interface Compiler version 4.8.6
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_AcercaDe
    attr_reader :verticalLayout_2
    attr_reader :verticalLayout
    attr_reader :fotoLabel
    attr_reader :label
    attr_reader :label_2
    attr_reader :horizontalLayout_2
    attr_reader :meGustoCheckBox
    attr_reader :horizontalSpacer
    attr_reader :horizontalLayout
    attr_reader :horizontalSpacer_2
    attr_reader :pushButton
    attr_reader :horizontalSpacer_3

    def setupUi(acercaDe)
    if acercaDe.objectName.nil?
        acercaDe.objectName = "acercaDe"
    end
    acercaDe.resize(319, 231)
    @verticalLayout_2 = Qt::VBoxLayout.new(acercaDe)
    @verticalLayout_2.objectName = "verticalLayout_2"
    @verticalLayout = Qt::VBoxLayout.new()
    @verticalLayout.objectName = "verticalLayout"
    @fotoLabel = Qt::Label.new(acercaDe)
    @fotoLabel.objectName = "fotoLabel"
    @fotoLabel.minimumSize = Qt::Size.new(100, 100)

    @verticalLayout.addWidget(@fotoLabel)

    @label = Qt::Label.new(acercaDe)
    @label.objectName = "label"

    @verticalLayout.addWidget(@label)

    @label_2 = Qt::Label.new(acercaDe)
    @label_2.objectName = "label_2"

    @verticalLayout.addWidget(@label_2)


    @verticalLayout_2.addLayout(@verticalLayout)

    @horizontalLayout_2 = Qt::HBoxLayout.new()
    @horizontalLayout_2.objectName = "horizontalLayout_2"
    @meGustoCheckBox = Qt::CheckBox.new(acercaDe)
    @meGustoCheckBox.objectName = "meGustoCheckBox"

    @horizontalLayout_2.addWidget(@meGustoCheckBox)

    @horizontalSpacer = Qt::SpacerItem.new(40, 20, Qt::SizePolicy::Expanding, Qt::SizePolicy::Minimum)

    @horizontalLayout_2.addItem(@horizontalSpacer)


    @verticalLayout_2.addLayout(@horizontalLayout_2)

    @horizontalLayout = Qt::HBoxLayout.new()
    @horizontalLayout.objectName = "horizontalLayout"
    @horizontalSpacer_2 = Qt::SpacerItem.new(40, 20, Qt::SizePolicy::Expanding, Qt::SizePolicy::Minimum)

    @horizontalLayout.addItem(@horizontalSpacer_2)

    @pushButton = Qt::PushButton.new(acercaDe)
    @pushButton.objectName = "pushButton"

    @horizontalLayout.addWidget(@pushButton)

    @horizontalSpacer_3 = Qt::SpacerItem.new(40, 20, Qt::SizePolicy::Expanding, Qt::SizePolicy::Minimum)

    @horizontalLayout.addItem(@horizontalSpacer_3)


    @verticalLayout_2.addLayout(@horizontalLayout)


    retranslateUi(acercaDe)
    Qt::Object.connect(@pushButton, SIGNAL('clicked()'), acercaDe, SLOT('terminar()'))

    Qt::MetaObject.connectSlotsByName(acercaDe)
    end # setupUi

    def setup_ui(acercaDe)
        setupUi(acercaDe)
    end

    def retranslateUi(acercaDe)
    acercaDe.windowTitle = Qt::Application.translate("AcercaDe", "Dialog", nil, Qt::Application::UnicodeUTF8)
    @fotoLabel.text = Qt::Application.translate("AcercaDe", "foto", nil, Qt::Application::UnicodeUTF8)
    @label.text = Qt::Application.translate("AcercaDe", "\302\251 by \303\201ngel Garc\303\255a <angarciaba@gmail.com>", nil, Qt::Application::UnicodeUTF8)
    @label_2.text = Qt::Application.translate("AcercaDe", "GNU 3.0 License", nil, Qt::Application::UnicodeUTF8)
    @meGustoCheckBox.text = Qt::Application.translate("AcercaDe", "Me gust\303\263", nil, Qt::Application::UnicodeUTF8)
    @pushButton.text = Qt::Application.translate("AcercaDe", "OK", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(acercaDe)
        retranslateUi(acercaDe)
    end

end

module Ui
    class AcercaDe < Ui_AcercaDe
    end
end  # module Ui

#-----------------------------------------------

=begin
** Form generated from reading ui file 'mainwindow.ui'
**
** Created: dom abr 17 22:11:32 2016
**      by: Qt User Interface Compiler version 4.8.6
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_MainWindow
    attr_reader :centralWidget
    attr_reader :verticalLayout
    attr_reader :operando1LineEdit
    attr_reader :horizontalLayout
    attr_reader :pushButton
    attr_reader :pushButton_2
    attr_reader :pushButton_3
    attr_reader :pushButton_4
    attr_reader :pushButton_5
    attr_reader :pushButton_6
    attr_reader :operando2LineEdit
    attr_reader :horizontalLayout_2
    attr_reader :horizontalSpacer
    attr_reader :label
    attr_reader :horizontalSpacer_2
    attr_reader :resultadoLineEdit
    attr_reader :horizontalLayout_3
    attr_reader :horizontalSpacer_3
    attr_reader :pushButton_8
    attr_reader :horizontalSpacer_4
    attr_reader :pushButton_9
    attr_reader :caraLabel
    attr_reader :horizontalSpacer_5
    attr_reader :menuBar
    attr_reader :mainToolBar
    attr_reader :statusBar

    def setupUi(mainWindow)
    if mainWindow.objectName.nil?
        mainWindow.objectName = "mainWindow"
    end
    mainWindow.resize(380, 309)
    @centralWidget = Qt::Widget.new(mainWindow)
    @centralWidget.objectName = "centralWidget"
    @verticalLayout = Qt::VBoxLayout.new(@centralWidget)
    @verticalLayout.spacing = 6
    @verticalLayout.margin = 11
    @verticalLayout.objectName = "verticalLayout"
    @operando1LineEdit = Qt::LineEdit.new(@centralWidget)
    @operando1LineEdit.objectName = "operando1LineEdit"
    @operando1LineEdit.alignment = Qt::AlignRight|Qt::AlignTrailing|Qt::AlignVCenter

    @verticalLayout.addWidget(@operando1LineEdit)

    @horizontalLayout = Qt::HBoxLayout.new()
    @horizontalLayout.spacing = 6
    @horizontalLayout.objectName = "horizontalLayout"
    @pushButton = Qt::PushButton.new(@centralWidget)
    @pushButton.objectName = "pushButton"
    @sizePolicy = Qt::SizePolicy.new(Qt::SizePolicy::Fixed, Qt::SizePolicy::Fixed)
    @sizePolicy.setHorizontalStretch(0)
    @sizePolicy.setVerticalStretch(0)
    @sizePolicy.heightForWidth = @pushButton.sizePolicy.hasHeightForWidth
    @pushButton.sizePolicy = @sizePolicy
    @pushButton.maximumSize = Qt::Size.new(50, 50)
    @font = Qt::Font.new
    @font.pointSize = 20
    @pushButton.font = @font

    @horizontalLayout.addWidget(@pushButton)

    @pushButton_2 = Qt::PushButton.new(@centralWidget)
    @pushButton_2.objectName = "pushButton_2"
    @sizePolicy.heightForWidth = @pushButton_2.sizePolicy.hasHeightForWidth
    @pushButton_2.sizePolicy = @sizePolicy
    @pushButton_2.maximumSize = Qt::Size.new(50, 50)
    @pushButton_2.font = @font

    @horizontalLayout.addWidget(@pushButton_2)

    @pushButton_3 = Qt::PushButton.new(@centralWidget)
    @pushButton_3.objectName = "pushButton_3"
    @sizePolicy.heightForWidth = @pushButton_3.sizePolicy.hasHeightForWidth
    @pushButton_3.sizePolicy = @sizePolicy
    @pushButton_3.maximumSize = Qt::Size.new(50, 50)
    @pushButton_3.font = @font

    @horizontalLayout.addWidget(@pushButton_3)

    @pushButton_4 = Qt::PushButton.new(@centralWidget)
    @pushButton_4.objectName = "pushButton_4"
    @sizePolicy.heightForWidth = @pushButton_4.sizePolicy.hasHeightForWidth
    @pushButton_4.sizePolicy = @sizePolicy
    @pushButton_4.maximumSize = Qt::Size.new(50, 50)
    @pushButton_4.font = @font

    @horizontalLayout.addWidget(@pushButton_4)

    @pushButton_5 = Qt::PushButton.new(@centralWidget)
    @pushButton_5.objectName = "pushButton_5"
    @sizePolicy.heightForWidth = @pushButton_5.sizePolicy.hasHeightForWidth
    @pushButton_5.sizePolicy = @sizePolicy
    @pushButton_5.maximumSize = Qt::Size.new(50, 50)
    @pushButton_5.font = @font

    @horizontalLayout.addWidget(@pushButton_5)

    @pushButton_6 = Qt::PushButton.new(@centralWidget)
    @pushButton_6.objectName = "pushButton_6"
    @sizePolicy1 = Qt::SizePolicy.new(Qt::SizePolicy::Preferred, Qt::SizePolicy::Preferred)
    @sizePolicy1.setHorizontalStretch(0)
    @sizePolicy1.setVerticalStretch(0)
    @sizePolicy1.heightForWidth = @pushButton_6.sizePolicy.hasHeightForWidth
    @pushButton_6.sizePolicy = @sizePolicy1
    @pushButton_6.maximumSize = Qt::Size.new(50, 50)
    @font1 = Qt::Font.new
    @font1.pointSize = 20
    @font1.bold = true
    @font1.weight = 75
    @pushButton_6.font = @font1

    @horizontalLayout.addWidget(@pushButton_6)


    @verticalLayout.addLayout(@horizontalLayout)

    @operando2LineEdit = Qt::LineEdit.new(@centralWidget)
    @operando2LineEdit.objectName = "operando2LineEdit"
    @operando2LineEdit.alignment = Qt::AlignRight|Qt::AlignTrailing|Qt::AlignVCenter

    @verticalLayout.addWidget(@operando2LineEdit)

    @horizontalLayout_2 = Qt::HBoxLayout.new()
    @horizontalLayout_2.spacing = 6
    @horizontalLayout_2.objectName = "horizontalLayout_2"
    @horizontalSpacer = Qt::SpacerItem.new(40, 20, Qt::SizePolicy::Expanding, Qt::SizePolicy::Minimum)

    @horizontalLayout_2.addItem(@horizontalSpacer)

    @label = Qt::Label.new(@centralWidget)
    @label.objectName = "label"
    @label.font = @font

    @horizontalLayout_2.addWidget(@label)

    @horizontalSpacer_2 = Qt::SpacerItem.new(40, 20, Qt::SizePolicy::Expanding, Qt::SizePolicy::Minimum)

    @horizontalLayout_2.addItem(@horizontalSpacer_2)


    @verticalLayout.addLayout(@horizontalLayout_2)

    @resultadoLineEdit = Qt::LineEdit.new(@centralWidget)
    @resultadoLineEdit.objectName = "resultadoLineEdit"
    @resultadoLineEdit.enabled = false
    @resultadoLineEdit.alignment = Qt::AlignRight|Qt::AlignTrailing|Qt::AlignVCenter

    @verticalLayout.addWidget(@resultadoLineEdit)

    @horizontalLayout_3 = Qt::HBoxLayout.new()
    @horizontalLayout_3.spacing = 6
    @horizontalLayout_3.objectName = "horizontalLayout_3"
    @horizontalSpacer_3 = Qt::SpacerItem.new(40, 20, Qt::SizePolicy::Expanding, Qt::SizePolicy::Minimum)

    @horizontalLayout_3.addItem(@horizontalSpacer_3)

    @pushButton_8 = Qt::PushButton.new(@centralWidget)
    @pushButton_8.objectName = "pushButton_8"

    @horizontalLayout_3.addWidget(@pushButton_8)

    @horizontalSpacer_4 = Qt::SpacerItem.new(40, 20, Qt::SizePolicy::Expanding, Qt::SizePolicy::Minimum)

    @horizontalLayout_3.addItem(@horizontalSpacer_4)

    @pushButton_9 = Qt::PushButton.new(@centralWidget)
    @pushButton_9.objectName = "pushButton_9"

    @horizontalLayout_3.addWidget(@pushButton_9)

    @caraLabel = Qt::Label.new(@centralWidget)
    @caraLabel.objectName = "caraLabel"
    @caraLabel.minimumSize = Qt::Size.new(40, 40)

    @horizontalLayout_3.addWidget(@caraLabel)

    @horizontalSpacer_5 = Qt::SpacerItem.new(40, 20, Qt::SizePolicy::Expanding, Qt::SizePolicy::Minimum)

    @horizontalLayout_3.addItem(@horizontalSpacer_5)


    @verticalLayout.addLayout(@horizontalLayout_3)

    mainWindow.centralWidget = @centralWidget
    @menuBar = Qt::MenuBar.new(mainWindow)
    @menuBar.objectName = "menuBar"
    @menuBar.geometry = Qt::Rect.new(0, 0, 380, 25)
    mainWindow.setMenuBar(@menuBar)
    @mainToolBar = Qt::ToolBar.new(mainWindow)
    @mainToolBar.objectName = "mainToolBar"
    mainWindow.addToolBar(Qt::TopToolBarArea, @mainToolBar)
    @statusBar = Qt::StatusBar.new(mainWindow)
    @statusBar.objectName = "statusBar"
    mainWindow.statusBar = @statusBar

    retranslateUi(mainWindow)
    Qt::Object.connect(@pushButton, SIGNAL('clicked()'), mainWindow, SLOT('sumar()'))
    Qt::Object.connect(@pushButton_2, SIGNAL('clicked()'), mainWindow, SLOT('restar()'))
    Qt::Object.connect(@pushButton_3, SIGNAL('clicked()'), mainWindow, SLOT('multiplicar()'))
    Qt::Object.connect(@pushButton_4, SIGNAL('clicked()'), mainWindow, SLOT('dividir()'))
    Qt::Object.connect(@pushButton_5, SIGNAL('clicked()'), mainWindow, SLOT('resto()'))
    Qt::Object.connect(@pushButton_6, SIGNAL('clicked()'), mainWindow, SLOT('exponenciar()'))
    Qt::Object.connect(@pushButton_8, SIGNAL('clicked()'), mainWindow, SLOT('terminar()'))
    Qt::Object.connect(@pushButton_9, SIGNAL('clicked()'), mainWindow, SLOT('mostrarCopyrigth()'))

    Qt::MetaObject.connectSlotsByName(mainWindow)
    end # setupUi

    def setup_ui(mainWindow)
        setupUi(mainWindow)
    end

    def retranslateUi(mainWindow)
    mainWindow.windowTitle = Qt::Application.translate("MainWindow", "Calculadora", nil, Qt::Application::UnicodeUTF8)
    @pushButton.text = Qt::Application.translate("MainWindow", "+", nil, Qt::Application::UnicodeUTF8)
    @pushButton_2.text = Qt::Application.translate("MainWindow", "-", nil, Qt::Application::UnicodeUTF8)
    @pushButton_3.text = Qt::Application.translate("MainWindow", "*", nil, Qt::Application::UnicodeUTF8)
    @pushButton_4.text = Qt::Application.translate("MainWindow", "/", nil, Qt::Application::UnicodeUTF8)
    @pushButton_5.text = Qt::Application.translate("MainWindow", "%", nil, Qt::Application::UnicodeUTF8)
    @pushButton_6.text = Qt::Application.translate("MainWindow", "**", nil, Qt::Application::UnicodeUTF8)
    @label.text = Qt::Application.translate("MainWindow", "=", nil, Qt::Application::UnicodeUTF8)
    @pushButton_8.text = Qt::Application.translate("MainWindow", "Terminar", nil, Qt::Application::UnicodeUTF8)
    @pushButton_9.text = Qt::Application.translate("MainWindow", "Acerca de", nil, Qt::Application::UnicodeUTF8)
    @caraLabel.text = ''
    end # retranslateUi

    def retranslate_ui(mainWindow)
        retranslateUi(mainWindow)
    end

end

module Ui
    class MainWindow < Ui_MainWindow
    end
end  # module Ui

#-----------------------------------------------
require 'Qt4'
class QtI_AcercaDe < Qt::Dialog
  slots 'inicializar()', 'terminar()'
  attr_accessor :qtiResultados # Para devolver resultados al destruirse este objeto gráfico
# Archivo: acercade.rb
# Autor: 
# Email: 
# Generado automáticamente por integracionQt.rb by Angel Garcia <angarciaba@gmail.com> licencia GPL 3.0
# En el caso de que este archivo exista, no se sobreescribirá
# Utilidad: contiene las funciones (slots) que deben ser completadas por usted, para terminar de generar la interface del archivo acercade.ui
#
# Dentro de esas funciones se pueden usar los siguientes objetos gráficos:
#   @ui.fotoLabel
#   @ui.meGustoCheckBox

# Para poder usar estos objetos gráficos puede consultar sus propiedades y funcionalidades aquí:
#   http://doc.qt.io/qt-4.8/qtgui-module.html
#
# También existen estos otros objetos gráficos, pero usted no les ha dado nombre, por lo que probablemente no le interese usarlos:
#  @ui.verticalLayout_2 @ui.verticalLayout @ui.label @ui.label_2 @ui.horizontalLayout_2 @ui.horizontalSpacer @ui.horizontalLayout @ui.horizontalSpacer_2 @ui.pushButton @ui.horizontalSpacer_3
#
# En sus funciones usted puede llamar a:
#  - aa = qtiCreate(dd) para crear una nueva ventana de tipo QDialog. Como argumento (dd) le debe pasar el nombre del objeto gráfico a crear (de tipo QDialog). En aa retorna un array con los argumentos que envió el qtiDestroy(). Usted puede y debe poner nombres distintos a dd y aa.

#  - qtiDestroy(arg1, arg2, etc) para destruir la ventana actual. arg1, arg2, etc son argumentos opcionales de retorno, que los recibirá en el array aa retornado a la función qtiCreate() que creó esta ventana.

#
# Las funciones a completar son: 

    def terminar()
      @qtiResultados = [ @ui.meGustoCheckBox.isChecked ]
      close()
    end
    
    def inicializar()
      @ui.fotoLabel.setPixmap(Qt::Pixmap.fromImage(Qt::Image.new("AngelGarcia3.jpg")))
    end  
    
    


  def initialize(parent=nil)
    super(parent)
    @ui = Ui::AcercaDe.new
    @ui.setup_ui(self)
    inicializar()
    self.show
  end
end

#-----------------------------------------------
require 'Qt4'
class MainForm < Qt::MainWindow
  slots 'inicializar()', 'sumar()', 'restar()', 'multiplicar()', 'dividir()', 'resto()', 'exponenciar()', 'terminar()', 'mostrarCopyrigth()'
  attr_accessor :qtiResultados # Para devolver resultados al destruirse este objeto gráfico
# Archivo: mainwindow.rb
# Autor: 
# Email: 
# Generado automáticamente por integracionQt.rb by Angel Garcia <angarciaba@gmail.com> licencia GPL 3.0
# En el caso de que este archivo exista, no se sobreescribirá
# Utilidad: contiene las funciones (slots) que deben ser completadas por usted, para terminar de generar la interface del archivo mainwindow.ui
#
# Dentro de esas funciones se pueden usar los siguientes objetos gráficos:
#   @ui.operando1LineEdit
#   @ui.operando2LineEdit
#   @ui.resultadoLineEdit
#   @ui.caraLabel

# Para poder usar estos objetos gráficos puede consultar sus propiedades y funcionalidades aquí:
#   http://doc.qt.io/qt-4.8/qtgui-module.html
#
# También existen estos otros objetos gráficos, pero usted no les ha dado nombre, por lo que probablemente no le interese usarlos:
#  @ui.centralWidget @ui.verticalLayout @ui.horizontalLayout @ui.pushButton @ui.pushButton_2 @ui.pushButton_3 @ui.pushButton_4 @ui.pushButton_5 @ui.pushButton_6 @ui.horizontalLayout_2 @ui.horizontalSpacer @ui.label @ui.horizontalSpacer_2 @ui.horizontalLayout_3 @ui.horizontalSpacer_3 @ui.pushButton_8 @ui.horizontalSpacer_4 @ui.pushButton_9 @ui.horizontalSpacer_5 @ui.menuBar @ui.mainToolBar @ui.statusBar
#
# En sus funciones usted puede llamar a:
#  - aa = qtiCreate(dd) para crear una nueva ventana de tipo QDialog. Como argumento (dd) le debe pasar el nombre del objeto gráfico a crear (de tipo QDialog). En aa retorna un array con los argumentos que envió el qtiDestroy(). Usted puede y debe poner nombres distintos a dd y aa.

#  - qtiDestroy(arg1, arg2, etc) para destruir la ventana actual. arg1, arg2, etc son argumentos opcionales de retorno, que los recibirá en el array aa retornado a la función qtiCreate() que creó esta ventana.

#
# Las funciones a completar son: 

    def sumar()
      @ui.resultadoLineEdit.text = @ui.operando1LineEdit.text.to_f + @ui.operando2LineEdit.text.to_f
    end

    def restar()
      @ui.resultadoLineEdit.text = @ui.operando1LineEdit.text.to_f - @ui.operando2LineEdit.text.to_f
    end

    def multiplicar()
      @ui.resultadoLineEdit.text = @ui.operando1LineEdit.text.to_f * @ui.operando2LineEdit.text.to_f
    end

    def dividir()
      @ui.resultadoLineEdit.text = @ui.operando1LineEdit.text.to_f / @ui.operando2LineEdit.text.to_f
    end

    def resto()
      @ui.resultadoLineEdit.text = @ui.operando1LineEdit.text.to_f % @ui.operando2LineEdit.text.to_f
    end

    def exponenciar()
      @ui.resultadoLineEdit.text = @ui.operando1LineEdit.text.to_f ** @ui.operando2LineEdit.text.to_f
    end

    def terminar()
      @qtiResultados = [  ]
      close()
    end

    def mostrarCopyrigth()
      dialog_AcercaDe = QtI_AcercaDe.new(self)
      dialog_AcercaDe.exec
      res = dialog_AcercaDe.qtiResultados
      if res[0]
        @ui.caraLabel.text = "☺"
      else
        @ui.caraLabel.text = "☻"
      end
    end



  def initialize(parent=nil)
    super(parent)
    @ui = Ui::MainWindow.new
    @ui.setup_ui(self)
#   inicializar()
    self.show
  end
end




if $0 == __FILE__
  app = Qt::Application.new(ARGV)
  MainForm.new
  app.exec
end

