=begin
** Form generated from reading ui file 'datospersonales.ui'
**
** Created: sáb abr 2 18:57:02 2016
**      by: Qt User Interface Compiler version 4.8.6
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

require 'Qt4'

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
    datosPersonales.resize(228, 115)
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

if $0 == __FILE__
    a = Qt::Application.new(ARGV)
    u = Ui_DatosPersonales.new
    w = Qt::Dialog.new
    u.setupUi(w)
    w.show
    a.exec
end
