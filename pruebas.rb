
STDOUT << "Hola" << "\n"
STDOUT << "Hola"

exit
def dd(expresion,entorno,mensaje="")
  puts "#{expresion}=#{entorno.eval(expresion)}  #{mensaje}\n==="
end

a= "hola"
b=[1,3,5]
c={}
c[0]="a"
c[1]="b"
dd("a",binding)
dd("b",binding)
dd("c",binding)
e=5
f=7
dd("e+f",binding)

exit
    metodos = 
    [
      ["ui",    ".ui", /^\s*<widget class=[^\s]+\s+name=["|'](\w+)["|']>/, /^\s*<slot>(.+?)<\/slot>/],
      ["rb", "_ui.rb", /^\s*attr_reader\s*:(\w*)/, /^\s*Qt::Object\.connect\(@?\w+,\s*SIGNAL\(.*?\),\s*\w+,\s*SLOT\('(.+?)'\)\)/]
    ]

metodos.each do |metodo, extension, regExpAtributo, regExpSlot| 
  p metodo
  p extension
  p regExpAtributo
  p regExpSlot
  p "===="
end
metodos.each do |metodo| 
  p metodo[0]
  p "===="
end
exit
a= ["aaa", "bbb"]
puts "Aviso: #{a}"
p rand 2
p rand

exit
mensaje="angel"

for i in 0...mensaje.length/2
  aux = mensaje[mensaje.length-1-i]
  mensaje[mensaje.length-1-i] = mensaje[i]
  mensaje[i] = aux
end
p mensaje

exit

mensaje="angel"

for i in 0...mensaje.length
  if mensaje[i]=="a"
    mensaje[i] = "4"
  elsif mensaje[i]=="e"
    mensaje[i] = "3"
  end
end
p mensaje
exit

color="amarillo"

codigo = 
  case color
  when "azul"
     1
  when "rojo"
     2
  when "amarillo"
     3
  else
      0
  end
p codigo

exit
a=true
p a
p (not a)
exit
def f(x)
  x.abs
end

a=-5
p a
p f(a)
p a

exit
a=[4, 2, -5, 3, 7]
for i in 0...a.length
  item = a[i]
  p item
end
a.each do |item|
    p item
end
a.each { |item|  p item }
exit

a = if 5 < 7 then 3 else 4 end    # a valdrá 3
p a
exit

p "Introduce un número"
a = gets
a = a.to_i
p a
p "Introduce otro número"
b = gets
b = b.to_f
p b
c = b.to_s
p c
exit

a = 5.5
b = 7
c = "Si multiplico #{a} por #{b} me da #{a*b}"
p c

exit
a = "Hola"
print a
print(a)
puts a
p a
p a.inspect
exit
a = [ [6, 5], [2, -5, 9, 8], [9]]
p a.length
p a[0].length
p a[1].length
p a[2].length


exit
tablaMultiplicar = []  # Array vacío
for i in  0..10
   tablaMultiplicar[i] = []  # Cada elemento es otro array
   for j in 0..10
     tablaMultiplicar[i][j] = i * j
   end
end 

p tablaMultiplicar
exit

letras = ["A", "B", "C"]
letras = letras << "D"        # Añadir al final
p letras
p letras[2]
letras[3] = "Hola"
p letras
letras[10] = "Chao"
p letras
p letras[8]
p letras[333]
p letras[-1]
p letras[-9]
exit
a,b=-3,-4
p "Error" if ((a> 0 or b+a < 5) and a*b==12)
exit
a=-5
a = -a if a < 0
p a
exit
ahorros=20_000_001
if ahorros > 20_000_000
  p "Puedo comprar un carro nuevo"
elsif ahorros > 10_000_000
  p "Puedo comprar un carro usado" 
else
  p "Me toca ir en el Masivo"
end

exit

datos = [9, 25, 14, 6]
contador = 0
while item=datos[contador]
    p item
    contador += 1
end
exit

verdad = 5>2
p verdad
mentira = 4==3
p mentira

datos = []
datos[3] = 100
p datos

exit
contador=5
while contador< 10
  p contador
  contador += 1
end
exit

p "valor final incluido"
for i in 0..10
  p i
end

p "valor final excluido"
for i in 0...10
  p i
end

exit
def modificar(array)
	array[2] = "Hasta la vista"
end

saludos = ["Hola", "Hello", "Hi", "Olá"]
p saludos
modificar(saludos)
p saludos

exit
def duplicar(xx)
  return xx*2
end

def triplicar(yy)
  yy = yy*3  # Se cambia el valor de yy, pero eso no afecta el valor de aa
  return yy
end

aa = 5
bb = duplicar(aa)
cc = triplicar(aa)
p bb    # bb vale 10
p cc    # cc vale 15
p aa    # aa sigue valiendo 5

exit
def ordenar(a,b)
    if a > b
        return b,a
    else
        return a,b
    end 
end


elMenor, elMayor = ordenar(4,5)
p elMenor
p elMayor

exit
def mayor(a, b)
    if a >  b
      return a
    else
      return b
    end
end


p mayor(8,5)

exit
5.times do 
p "Hola"
	end

=begin
5.times { p "Hola" }
=end

exit
def modificar(array)
	array[2] = "Hasta la vista"
end

saludos = ["Hola", "Hello", "Hi", "Olá"]
p saludos
modificar(saludos)
p saludos


5.times do
p "i "
end

def inc(val)
  val += 1
end

a = 1
inc a
puts a
puts "==================="

def change_string(str)
  str << " I can insult you all you want"
  str << " because you'll never see this"
  str << " because I'm going to replace the whole string!"
  str << " Haha you smell bad!"
  str = "What? I didn't say anything." # I'm so sneaky
end

be_nice_to_me = "hello"
change_string(be_nice_to_me)
puts be_nice_to_me
puts "==================="


def duplicar(x)
  return x*2
end

def triplicar(y)
  y = y*3
  return y
end

a = 5
b = duplicar(a)
c = triplicar(a)
print b    # b vale 10
print c    # c vale 15
print a    # Sorpresa: a vale 15
