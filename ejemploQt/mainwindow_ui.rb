=begin
** Form generated from reading ui file 'mainwindow.ui'
**
** Created: sáb abr 2 18:25:30 2016
**      by: Qt User Interface Compiler version 4.8.6
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

require 'Qt4'

class Ui_MainWindow
    attr_reader :centralWidget
    attr_reader :pushButton
    attr_reader :label
    attr_reader :menuBar
    attr_reader :mainToolBar
    attr_reader :statusBar

    def setupUi(mainWindow)
    if mainWindow.objectName.nil?
        mainWindow.objectName = "mainWindow"
    end
    mainWindow.resize(400, 300)
    @centralWidget = Qt::Widget.new(mainWindow)
    @centralWidget.objectName = "centralWidget"
    @pushButton = Qt::PushButton.new(@centralWidget)
    @pushButton.objectName = "pushButton"
    @pushButton.geometry = Qt::Rect.new(120, 190, 141, 27)
    @label = Qt::Label.new(@centralWidget)
    @label.objectName = "label"
    @label.geometry = Qt::Rect.new(160, 70, 67, 17)
    mainWindow.centralWidget = @centralWidget
    @menuBar = Qt::MenuBar.new(mainWindow)
    @menuBar.objectName = "menuBar"
    @menuBar.geometry = Qt::Rect.new(0, 0, 400, 25)
    mainWindow.setMenuBar(@menuBar)
    @mainToolBar = Qt::ToolBar.new(mainWindow)
    @mainToolBar.objectName = "mainToolBar"
    mainWindow.addToolBar(Qt::TopToolBarArea, @mainToolBar)
    @statusBar = Qt::StatusBar.new(mainWindow)
    @statusBar.objectName = "statusBar"
    mainWindow.statusBar = @statusBar

    retranslateUi(mainWindow)
    Qt::Object.connect(@pushButton, SIGNAL('clicked()'), mainWindow, SLOT('lanzarMoneda()'))

    Qt::MetaObject.connectSlotsByName(mainWindow)
    end # setupUi

    def setup_ui(mainWindow)
        setupUi(mainWindow)
    end

    def retranslateUi(mainWindow)
    mainWindow.windowTitle = Qt::Application.translate("MainWindow", "MainWindow", nil, Qt::Application::UnicodeUTF8)
    @pushButton.text = Qt::Application.translate("MainWindow", "Lanzar moneda", nil, Qt::Application::UnicodeUTF8)
    @label.text = Qt::Application.translate("MainWindow", "---", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(mainWindow)
        retranslateUi(mainWindow)
    end

end

module Ui
    class MainWindow < Ui_MainWindow
    end
end  # module Ui

if $0 == __FILE__
    a = Qt::Application.new(ARGV)
    u = Ui_MainWindow.new
    w = Qt::MainWindow.new
    u.setupUi(w)
    w.show
    a.exec
end







