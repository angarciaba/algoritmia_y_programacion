#!/usr/bin/env ruby
# encoding: utf-8
# Programa: mainwindow.rb
Copyright = 
"Autor: Angel Garcia Baños\n" +
"Email: angel.garcia@correounivalle.edu.co\n" +
"Institución: EISC, Universidad del Valle, Colombia" +
"Fecha creación: 2016-04-08\n" +
"Fecha última modificación: 2016-04-08\n" +
"Licencia: GNU-GPL"
Version = "0.1"
Descripcion = 
"Son los slots de la clase MainWindow de un depurador de código procedural para Ruby corriendo en Ruby con Qt. El objetivo es enseñar a programar a quien nunca antes lo ha hecho. La GUI tiene dos áreas: a la izquierda se ve el código Ruby escrito por el estudiante, que puede ser ejecutado paso a paso cada vez que se hace clic en un botón. La línea de código resaltada es la que se está a punto de ejecutar. A la derecha están todas las variables locales, con sus valores actuales. Se pretende que funcione para programas procedurales (es decir, sin definiciones de clases ni instanciaciones de objetos), al menos en esta primera versión."
Dependencias =
"
sudo apt-get install ruby-qt4 qtcreator cmake
gem install qtbindings
"
#-----------------------------------------------------------------------------------------------------------------------
# VERSIONES
# 0.1 La primera. 
#-----------------------------------------------------------------------------------------------------------------------
# textBrowser, graphicsView
  
  
  archivoFuente = "prueba.rb"

  textBrowser.setReadOnly(true)
  textBrowser.setSource(QUrl::fromLocalFile(archivoFuente))
  
  def stepExecution()
  end


  def about()
    qtCreate(aboutDialog)
  end
  
  
  def quit()
    qtDestroy()
  end


  tp__tp = TracePoint.new(:line, :call, :return) do |tp__tp|
    next if tp__tp.path != archivoFuente
    p tp__tp.lineno
    variables =  tp__tp.binding.eval('local_variables') + tp__tp.binding.eval('instance_variables')- [:tp__tp]
    variables.each do |var| 
      value=tp__tp.binding.eval("#{var}")
      p "#{var}=#{value}"
    end
  end
  tp__tp.enable
  load(archivoFuente)
  tp__tp.disable


  
  

