Práctica: DSL: Redacción de Cuestionarios II (Con Contexto)
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

    quiz = Quiz.new("Cuestionario de PFS 10/12/2011") {

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
    }

    puts quiz
    puts "************************"
    quiz.run

El programa anterior podría producir una salida parecida a esta:

    Cuestionario de PFS 10/12/2011

    ¿En que año Cristobal Colón descubrió América?

      1 -  1942
      2 -  1492
      3 -  1808
      4 -  1914

    Su respuesta: 3
    0+8 = 

      1 -  44
      2 -  10
      3 -  8
      4 -  6

    Su respuesta: 1
    0 respuestas correctas de un total de 2.
    MacBookdeCasiano:chapter8ReflectionandMetaprogramming casiano$

Los cuestionarios deberían tener un método `to_s`
Los cuestionarios deberían tener un método `run` que formulara cada una de las preguntas del cuestionario y mostrara el porcentaje de aciertos.

Puede que le interese crear tres clases, una para las respuestas (`Answer`), otra para las preguntas (`Question`) y una para el cuestionario (`Quiz`)
Hay un problema con la llamada al método question:

      question '¿En que año Cristobal Colón descubrió América?',
        wrong =>'1942',
        right =>'1492',
        wrong =>'1808',
        wrong =>'1914'

Si el segundo argumento es un hash y las claves son `wrong` y `right` se va a producir una colisión y el último valor sobreescribirá a los anteriores. ¿Se puede resolver?

