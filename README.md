Práctica: DSL: Redacción de Cuestionarios 
============================

En este repositorio encontrará una solución a la siguiente práctica tutorizada.
Intente resolverla antes de copiar.

Se trata de escribir un programa que redacte cuestionarios. En principio, sólo soportaremos preguntas del tipo selección múltiple:

    1. ¿En que año Cristobal Colón descubrió América?
          1 - 1942
          2 - 1492
          3 - 1808
          4 - 1914
    Su respuesta:

Debe definir una API que soporte un pequeño lenguaje en el que las preguntas puedan ser especificadas de una forma natural. Algo así vale:

      [~/chapter8ReflectionandMetaprogramming/DSL/quiz(master)]$ cat histandmath.rb 
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


Se deberá escribir un intérprete `q.rb` que cuando se ejecuta 
pregunta y evalúa el cuestionario:


      [~/chapter8ReflectionandMetaprogramming/DSL/quiz(master)]$ ./q.rb histandmath.rb 
      ************************
      Examen de Historia y Matemáticas

      ¿En que año Cristobal Colón descubrió América?

        1 -  1942
        2 -  1492
        3 -  1808
        4 -  1914

      Su respuesta: _

Los cuestionarios deberían tener un método `to_s`.

Los cuestionarios deberían tener un método `run` que formulara cada una de las preguntas del cuestionario y mostrara el porcentaje de aciertos.

Puede que le interese crear tres clases, 

* una para las respuestas (`Answer`), 
* otra para las preguntas (`Question`) 
* y una para el cuestionario (`Quiz`)

Hay un problema con la llamada al método `question`:

      question '¿En que año Cristobal Colón descubrió América?',
        wrong =>'1942',
        right =>'1492',
        wrong =>'1808',
        wrong =>'1914'

Si el segundo argumento es un hash y las claves son `wrong` y `right`
se va a producir una colisión y el último valor sobreescribirá a
los anteriores. ¿Se puede resolver?

