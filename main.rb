# main.rb
# version 3
#       
require 'Qt4'
require './ui/listdialog_ui'
require './ui/editdialog_ui'

class MainForm < Qt::Dialog

  slots 'add_item()', 'edit_item()', 'delete_item()'
 
  def initialize
    super
  
    @ui = Ui::ListDialog.new
    @ui.setup_ui(self)
 
    Qt::Object.connect(@ui.addButton, SIGNAL('clicked()'), self, SLOT('add_item()'))
    Qt::Object.connect(@ui.editButton, SIGNAL('clicked()'), self, SLOT('edit_item()'))
    Qt::Object.connect(@ui.deleteButton, SIGNAL('clicked()'), self, SLOT('delete_item()'))
 
    self.show
 
  end
 
  def add_item()
    d = EditForm.new(self)
    if(d.exec == 1) # OK clicked
      @ui.list.add_item(d.name + ": " + d.number)
    end
  end
 
  def edit_item()
    if(@ui.list.current_item) # if any item is selected
      temp = @ui.list.current_item.text
      a = temp.split(/: /)
      d = EditForm.new(self)
      d.name = a[0]
      d.number = a[1]
      if(d.exec == 1) # OK clicked
        @ui.list.current_item.text = d.name + ": " + d.number
      end
    end
  end
 
  def delete_item()
    @ui.list.current_item.dispose # delete selected object
  end
  
end

class EditForm < Qt::Dialog
 
  def initialize(parent=nil)
    super(parent)
    @ui = Ui::EditDialog.new
    @ui.setup_ui(self)
    self.show
  end

  def name
    @ui.nameEdit.text
  end
 
  def name=(s)
    @ui.nameEdit.set_text(s)
  end
 
  def number
    @ui.numberEdit.text
  end
 
  def number=(s)
    @ui.numberEdit.set_text(s)
  end
 
end

if $0 == __FILE__
  a = Qt::Application.new(ARGV)
  MainForm.new
  a.exec
end


