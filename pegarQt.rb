##################################################
######### LO NUEVO A INSERTAR ####################
##################################################

require 'Qt4'

class MainForm < Qt::MainWindow
  slots 'lanzarMoneda()'
  def lanzarMoneda()
    if rand(2) == 0
      @ui.label.text = "CARA"
    else
      @ui.label.setText("SELLO")
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



