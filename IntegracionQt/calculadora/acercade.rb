# Archivo: acercade.rb
# Autor: 
# Email: 
# Generado automáticamente por integracionQt.rb by Angel Garcia <angarciaba@gmail.com> licencia GPL 3.0
# En el caso de que este archivo exista, no se sobreescribirá
# Utilidad: contiene las funciones (slots) que deben ser completadas por usted, para terminar de generar la interface del archivo acercade.ui
#
# Dentro de esas funciones se pueden usar los siguientes objetos gráficos:
#   fotoLabel
#   meGustoCheckBox

# Para poder usar estos objetos gráficos puede consultar sus propiedades y funcionalidades aquí:
#   http://doc.qt.io/qt-4.8/qtgui-module.html
#
# También existen estos otros objetos gráficos, pero usted no les ha dado nombre, por lo que probablemente no le interese usarlos:
#  verticalLayout_2 verticalLayout label label_2 horizontalLayout_2 horizontalSpacer horizontalLayout horizontalSpacer_2 pushButton horizontalSpacer_3
#
# En sus funciones usted puede llamar a:
#  - aa = qtiCreate(dd) para crear una nueva ventana de tipo QDialog. Como argumento (dd) le debe pasar el nombre del objeto gráfico a crear (de tipo QDialog). En aa retorna un array con los argumentos que envió el qtiDestroy(). Usted puede y debe poner nombres distintos a dd y aa.
#  - qtiDestroy(arg1, arg2, etc) para destruir la ventana actual. arg1, arg2, etc son argumentos opcionales de retorno, que los recibirá en el array aa retornado a la función qtiCreate() que creó esta ventana.
#
# Las funciones a completar son: 

    def terminar()
      qtiDestroy(meGustoCheckBox.isChecked)
    end
    
    def inicializar()
      fotoLabel.setPixmap(Qt::Pixmap.fromImage(Qt::Image.new("AngelGarcia3.jpg")))
    end  
    
    
