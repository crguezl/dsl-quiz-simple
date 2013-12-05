title "Examen de Historia y Matemáticas"

question '¿En que año Cristobal Colón descubrió América?',
  wrong =>'1942',
  right =>'1492',
  wrong =>'1808',
  wrong =>'1914'

a = rand(10)
b = rand(10)
question "#{a}+#{b} = ",
  wrong =>"44",
  wrong =>"#{a + b + 2}",
  right =>"#{a + b}",
  wrong =>"#{a + b - 2}"

