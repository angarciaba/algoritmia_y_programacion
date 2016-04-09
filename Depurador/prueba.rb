# Una prueba para el Depurador de código para Ruby usando Qt
# Angel Garcia


class Estring
  attr_accessor :s
  def initialize(x)
    @s=x
  end
end

string="Hola"
string << "A"
string << "B"
u=Estring.new("Chao")
p u.s

for i in 0..10
  p i
  j = i+2
end


def add(a,b)
  c = a + b
  return c
end

p add(1,2)

