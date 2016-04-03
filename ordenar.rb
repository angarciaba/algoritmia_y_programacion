# Archivo: ordenar.rb
# Autor: Ángel
# Fecha: 2016-03-20
# Versión: 0.1


def ordenar(b)
  x=b
  for i in 0...x.length-1 do
    for j in i+1..x.length do
    p j
      if x[i] > x[j]
        x[i], x[j] = x[j], x[i]
      end
    end
  end
  x
end


a = [4, 5, 1, 0, -3, 2.2, 100, 7, 7, 200, 2]
p a
p ordenar(a)
p a

