# Archivo: mainwindow.rb
# Autor: 
# Email: 
# Generado automáticamente por integracionQt.rb by Angel Garcia <angarciaba@gmail.com> licencia GPL 3.0
# En el caso de que este archivo exista, no se sobreescribirá
# Utilidad: contiene las funciones (slots) que deben ser completadas por usted, para terminar de generar la interface del archivo mainwindow.ui
#
# Dentro de esas funciones se pueden usar los siguientes objetos gráficos:
#   operando1LineEdit
#   operando2LineEdit
#   resultadoLineEdit
#   caraLabel

# Para poder usar estos objetos gráficos puede consultar sus propiedades y funcionalidades aquí:
#   http://doc.qt.io/qt-4.8/qtgui-module.html
#
# También existen estos otros objetos gráficos, pero usted no les ha dado nombre, por lo que probablemente no le interese usarlos:
#  centralWidget verticalLayout horizontalLayout pushButton pushButton_2 pushButton_3 pushButton_4 pushButton_5 pushButton_6 horizontalLayout_2 horizontalSpacer label horizontalSpacer_2 horizontalLayout_3 horizontalSpacer_3 pushButton_8 horizontalSpacer_4 pushButton_9 horizontalSpacer_5 menuBar mainToolBar statusBar
#
# En sus funciones usted puede llamar a:
#  - aa = qtiCreate(dd) para crear una nueva ventana de tipo QDialog. Como argumento (dd) le debe pasar el nombre del objeto gráfico a crear (de tipo QDialog). En aa retorna un array con los argumentos que envió el qtiDestroy(). Usted puede y debe poner nombres distintos a dd y aa.
#  - qtiDestroy(arg1, arg2, etc) para destruir la ventana actual. arg1, arg2, etc son argumentos opcionales de retorno, que los recibirá en el array aa retornado a la función qtiCreate() que creó esta ventana.
#
# Las funciones a completar son: 

    def sumar()
      resultadoLineEdit.text = operando1LineEdit.text.to_f + operando2LineEdit.text.to_f
    end

    def restar()
      resultadoLineEdit.text = operando1LineEdit.text.to_f - operando2LineEdit.text.to_f
    end

    def multiplicar()
      resultadoLineEdit.text = operando1LineEdit.text.to_f * operando2LineEdit.text.to_f
    end

    def dividir()
      resultadoLineEdit.text = operando1LineEdit.text.to_f / operando2LineEdit.text.to_f
    end

    def resto()
      resultadoLineEdit.text = operando1LineEdit.text.to_f % operando2LineEdit.text.to_f
    end

    def exponenciar()
      resultadoLineEdit.text = operando1LineEdit.text.to_f ** operando2LineEdit.text.to_f
    end

    def terminar()
      qtiDestroy()
    end

    def mostrarCopyrigth()
      res = qtiCreate(AcercaDe)
      if res[0]
        caraLabel.text = "☺"
      else
        caraLabel.text = "☻"
      end
    end

