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
