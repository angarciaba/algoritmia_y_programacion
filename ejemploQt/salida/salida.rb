#-----------------------------------------------

=begin
** Form generated from reading ui file 'datospersonales.ui'
**
** Created: dom abr 3 20:17:19 2016
**      by: Qt User Interface Compiler version 4.8.6
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_DatosPersonales
    attr_reader :verticalLayout
    attr_reader :horizontalLayout
    attr_reader :label
    attr_reader :lineEdit
    attr_reader :horizontalLayout_2
    attr_reader :label_2
    attr_reader :spinBox
    attr_reader :pushButton

    def setupUi(datosPersonales)
    if datosPersonales.objectName.nil?
        datosPersonales.objectName = "datosPersonales"
    end
    datosPersonales.resize(556, 344)
    @verticalLayout = Qt::VBoxLayout.new(datosPersonales)
    @verticalLayout.spacing = 6
    @verticalLayout.margin = 11
    @verticalLayout.objectName = "verticalLayout"
    @horizontalLayout = Qt::HBoxLayout.new()
    @horizontalLayout.spacing = 6
    @horizontalLayout.objectName = "horizontalLayout"
    @label = Qt::Label.new(datosPersonales)
    @label.objectName = "label"

    @horizontalLayout.addWidget(@label)

    @lineEdit = Qt::LineEdit.new(datosPersonales)
    @lineEdit.objectName = "lineEdit"

    @horizontalLayout.addWidget(@lineEdit)


    @verticalLayout.addLayout(@horizontalLayout)

    @horizontalLayout_2 = Qt::HBoxLayout.new()
    @horizontalLayout_2.spacing = 6
    @horizontalLayout_2.objectName = "horizontalLayout_2"
    @label_2 = Qt::Label.new(datosPersonales)
    @label_2.objectName = "label_2"

    @horizontalLayout_2.addWidget(@label_2)

    @spinBox = Qt::SpinBox.new(datosPersonales)
    @spinBox.objectName = "spinBox"
    @spinBox.minimum = 1
    @spinBox.maximum = 200

    @horizontalLayout_2.addWidget(@spinBox)


    @verticalLayout.addLayout(@horizontalLayout_2)

    @pushButton = Qt::PushButton.new(datosPersonales)
    @pushButton.objectName = "pushButton"

    @verticalLayout.addWidget(@pushButton)


    retranslateUi(datosPersonales)
    Qt::Object.connect(@pushButton, SIGNAL('released()'), datosPersonales, SLOT('ok_datos()'))

    Qt::MetaObject.connectSlotsByName(datosPersonales)
    end # setupUi

    def setup_ui(datosPersonales)
        setupUi(datosPersonales)
    end

    def retranslateUi(datosPersonales)
    datosPersonales.windowTitle = Qt::Application.translate("DatosPersonales", "DatosPersonales", nil, Qt::Application::UnicodeUTF8)
    @label.text = Qt::Application.translate("DatosPersonales", "Nombre", nil, Qt::Application::UnicodeUTF8)
    @label_2.text = Qt::Application.translate("DatosPersonales", "Edad", nil, Qt::Application::UnicodeUTF8)
    @pushButton.text = Qt::Application.translate("DatosPersonales", "OK", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(datosPersonales)
        retranslateUi(datosPersonales)
    end

end

module Ui
    class DatosPersonales < Ui_DatosPersonales
    end
end  # module Ui

#-----------------------------------------------

=begin
** Form generated from reading ui file 'mainwindow.ui'
**
** Created: dom abr 3 20:16:53 2016
**      by: Qt User Interface Compiler version 4.8.6
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_MainWindow
    attr_reader :centralWidget
    attr_reader :verticalLayout_2
    attr_reader :verticalLayout
    attr_reader :spinBox
    attr_reader :label
    attr_reader :horizontalLayout
    attr_reader :pushButton
    attr_reader :pushButton_2
    attr_reader :menuBar
    attr_reader :mainToolBar
    attr_reader :statusBar

    def setupUi(mainWindow)
    if mainWindow.objectName.nil?
        mainWindow.objectName = "mainWindow"
    end
    mainWindow.resize(455, 367)
    @centralWidget = Qt::Widget.new(mainWindow)
    @centralWidget.objectName = "centralWidget"
    @verticalLayout_2 = Qt::VBoxLayout.new(@centralWidget)
    @verticalLayout_2.spacing = 6
    @verticalLayout_2.margin = 11
    @verticalLayout_2.objectName = "verticalLayout_2"
    @verticalLayout = Qt::VBoxLayout.new()
    @verticalLayout.spacing = 6
    @verticalLayout.objectName = "verticalLayout"
    @spinBox = Qt::SpinBox.new(@centralWidget)
    @spinBox.objectName = "spinBox"

    @verticalLayout.addWidget(@spinBox)

    @label = Qt::Label.new(@centralWidget)
    @label.objectName = "label"

    @verticalLayout.addWidget(@label)

    @horizontalLayout = Qt::HBoxLayout.new()
    @horizontalLayout.spacing = 6
    @horizontalLayout.objectName = "horizontalLayout"
    @pushButton = Qt::PushButton.new(@centralWidget)
    @pushButton.objectName = "pushButton"

    @horizontalLayout.addWidget(@pushButton)

    @pushButton_2 = Qt::PushButton.new(@centralWidget)
    @pushButton_2.objectName = "pushButton_2"

    @horizontalLayout.addWidget(@pushButton_2)


    @verticalLayout.addLayout(@horizontalLayout)


    @verticalLayout_2.addLayout(@verticalLayout)

    mainWindow.centralWidget = @centralWidget
    @menuBar = Qt::MenuBar.new(mainWindow)
    @menuBar.objectName = "menuBar"
    @menuBar.geometry = Qt::Rect.new(0, 0, 455, 25)
    mainWindow.setMenuBar(@menuBar)
    @mainToolBar = Qt::ToolBar.new(mainWindow)
    @mainToolBar.objectName = "mainToolBar"
    mainWindow.addToolBar(Qt::TopToolBarArea, @mainToolBar)
    @statusBar = Qt::StatusBar.new(mainWindow)
    @statusBar.objectName = "statusBar"
    mainWindow.statusBar = @statusBar

    retranslateUi(mainWindow)
    Qt::Object.connect(@pushButton, SIGNAL('clicked()'), mainWindow, SLOT('lanzarMoneda()'))
    Qt::Object.connect(@pushButton_2, SIGNAL('released()'), mainWindow, SLOT('terminar()'))
    Qt::Object.connect(@pushButton_2, SIGNAL('clicked()'), @spinBox, SLOT('stepDown()'))

    Qt::MetaObject.connectSlotsByName(mainWindow)
    end # setupUi

    def setup_ui(mainWindow)
        setupUi(mainWindow)
    end

    def retranslateUi(mainWindow)
    mainWindow.windowTitle = Qt::Application.translate("MainWindow", "MainWindow", nil, Qt::Application::UnicodeUTF8)
    @label.text = Qt::Application.translate("MainWindow", "---", nil, Qt::Application::UnicodeUTF8)
    @pushButton.text = Qt::Application.translate("MainWindow", "Lanzar moneda", nil, Qt::Application::UnicodeUTF8)
    @pushButton_2.text = Qt::Application.translate("MainWindow", "Terminar", nil, Qt::Application::UnicodeUTF8)
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
class QtI_DatosPersonales < Qt::Dialog
  slots 'ok_datos()'
  def initialize
    super
    @ui = Ui::DatosPersonales.new
    @ui.setup_ui(self)
    self.show
  end
end

#-----------------------------------------------
require 'Qt4'
class MainForm < Qt::MainWindow
  slots 'lanzarMoneda()', 'terminar()'

  def lanzarMoneda()
    if rand(2) == 0
      @ui.label.text = "CARA"
    else
      @ui.label.text = "SELLO"
    end
  end

  def initialize
    super
    @ui = Ui::MainWindow.new
    @ui.setup_ui(self)
    self.show
  end
end

if $0 == __FILE__
    a = Qt::Application.new(ARGV)
    MainForm.new
    a.exec
end

