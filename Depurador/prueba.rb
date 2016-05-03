# Una prueba para el Depurador de código para Ruby usando Qt
# Angel Garcia

def ff()
    imc = 22
    
    if (imc < 18.5)
        categoria = "infrapeso"
    elsif (imc >=18.5 && imc < 25.0)
        categoria = "normal"
    else
        categoria = "sobrepeso"
    end    
end

puts ff

exit

trace = TracePoint.new do |tp|
  printf "%8s %s:%-2d %13s\n", tp.event, tp.path, tp.lineno, tp.method_id
end

def method1; false end
def method2; true end
trace.enable

if method1
  1
elsif(method2)
  2
end

exit

a=4
if a>5
  c=2
  c=5
elsif a==4
  c=0
else
  c= 3
end
puts c

exit

method = <<-EOF
a=4
if a>5
  c=2
elsif a==4
  c=0
else
  c= 3
end
puts c
EOF
puts RubyVM::InstructionSequence.new(method).disasm
exit

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
puts u.s

for i in 0..10
  p i
  j = i+2
end


def add(a,b)
  c = a + b
  return c
end

puts add(1,2)

