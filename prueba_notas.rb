def linea_larga
  puts '-----------------------------------------------------'
end

def menu_principal
  puts '------------------ Menu Académico -------------------'
  puts '1) Crear Archivo con el promedio'
  puts '2) Cantidad de inasistencias'
  puts '3) Nombre de alumnos aprobados'
  puts '4) Salir'
  linea_larga
end

def menu_opcion1
  puts '---> 1) Crear Archivo con el promedio----------------'
  puts 'Cual es el nombre del archivo? por defecto <promedio>'
  linea_larga
end

def menu_opcion3
  puts '---> 3) Nombre de alumnos aprobados------------------'
  puts 'Cual es la nota para aprobar? por defecto <5>'
  linea_larga
end

def abrir_archivo(archivo)
  file = File.open(archivo, 'r')
  contenido = file.readlines
  file.close
  contenido
end

def graba_archivo(index, archivo)
  file = File.open(archivo, 'w')
  file.puts index
  file.close
end

def promedio(notas)
  prueba_notas = ''
  notas.each do |data|
    suma = 0.0
    data.each { |dato| suma += dato.to_f if dato.to_s != 'A' }
    suma /= (data.length - 1)
    prueba_notas << "#{data.first}, #{suma}\n"
  end
  prueba_notas
end

def arch_promedio(notas, nombre_arch)
  prueba_notas = promedio(notas)
  graba_archivo(prueba_notas, nombre_arch)
end

def muestra_inasistencias(notas)
  tot_inasis = 0
  linea_larga
  notas.each do |data|
    suma = 0
    data.each { |dato| suma += 1 if dato == 'A' }
    puts "#{data.first} tiene #{suma} inasistencia(s)" if suma != 0
    tot_inasis += suma
  end
  linea_larga
  puts "La cantidad TOTAL de inasistencias es #{tot_inasis}"
  linea_larga
end

def aprueba?(notas, nota_aprobacion)
  linea_larga
  notas.each do |data|
    suma = 0.0
    data.each { |dato| suma += dato.to_f if dato.to_s != 'A' }
    suma /= (data.length - 1)
    if suma <= nota_aprobacion
      puts "#{data.first} reprueba con nota #{suma}"
    else
      puts "#{data.first} APRUEBA con nota #{suma}"
    end
  end
  linea_larga
end

def despliega_notas(notas)
  linea_larga
  notas.each do |data|
    iterador = 0
    linea = ''
    data.map do |i|
      if iterador.zero?
        linea = "ALUMNO #{i} ===> NOTAS: "
      else
        linea += " #{i} "
      end
      iterador += 1
    end
    puts linea
  end
  linea_larga
end

# cuerpo del programa
notas = abrir_archivo('notas.csv')
notas = notas.map { |ele| ele.split(', ').map(&:chomp).to_a }

despliega_notas(notas)

# repeticion del menu hasta que coloque opcion 4
loop do
  menu_principal
  numero = gets.chomp.to_i

  salida = false

  case numero
  when 1
    menu_opcion1
    seleccion = gets.chomp.to_s
    seleccion = 'promedio' if seleccion.empty?
    seleccion << '.csv'
    arch_promedio(notas, seleccion)
  when 2
    muestra_inasistencias(notas)
  when 3
    menu_opcion3
    seleccion = gets.chomp
    seleccion = 5.0 if seleccion.empty?
    aprueba?(notas, seleccion.to_f)
  when 4
    # Salir
    linea_larga
    linea_larga
    puts 'GRACIAS POR PROBAR LA APLICACION!!! NOS VEMOS!'
    linea_larga
    linea_larga
    salida = true
  else
    linea_larga
    puts ' ******* Error en selección. Intente otro número.'
  end

  break if salida
end
