---
title: Deep learning - Introducción
date: 2017-03-12 22:00:00 +0200
description: Apuntes sobre el libro Deep Learning, de Ian Goodfellow
categories:
  - libros
  - deep-learning
  - inteligencia-artificial
image: /images/deep-learning.jpg
comments: true
---
Notas sobre el capítulo 1 del libro "Deep learning"

## Capítulo 1 - Introducción

El libro comienza hablando sobre los problemas que constituyen el verdadero desafío las la inteligencia artificial hoy en día, aquellos que la gente realiza con facilidad pero cuya descripción formal es compleja, como reconocer rostros en imágenes. _Deep learning_ es una solución a estos problemas. Por una parte acumula conocimiento a través de la experiencia, evitando así que se tenga que definir formalmente todo el conocimiento necesario. Por otro lado, define conceptos en varias capas jerárquicas, de forma que cada concepto se define a partir de varios conceptos más simples. Es esta idea de construir conceptos complejos sobre muchas capas de conceptos más simples, de forma que las estructuras de estas redes neuronales tienen mucha "profundidad", es la que da el nombre de _deep learning_ a esta disciplina.

El origen de esta aproximación a la inteligencia artificial está en las limitaciones de los sistemas que necesitaban que el conocimiento se incorporase de forma explícita. Para eliminar estas limitaciones se empieza a diseñar sistemas capaces de distinguir patrones en datos. Esta capacidad consituye en nucleo del _machine learning_.

## Representaciones y características
Una consecuencia de este enfoque centrado en los datos es que los algoritos de _machine learning_ dependen mucho de la representación de los datos utilizada. El libro nos muestra un ejemplo muy visual: 
<div style="text-align:center">
    <figure>
        <img alt="Figura 1.1 - El mismo conjunto de datos representado en coordenadas cartesianas (izq.) y polares (dcha.)" src ="/images/DL/Fig1.1.jpg" />
        <figcaption>Figura 1.1 - El mismo conjunto de datos representado en coordenadas cartesianas (izq.) y polares (dcha.)</figcaption>
    </figure>
</div>
Si el objetivo fuese separar con una línea recta los datos de una categoría (triángulos verdes) de los de la otra (círculos azules), lo tendríamos fácil al representar los datos con coordenadas polares, e imposible al hacerlo con coordenadas cartesianas.

Otro concepto básico que nos presentan es el de **característica** (_feature_ en inglés, lo he visto también traducido al castellano como **atributo**). Una característica es una propiedad medible del fenómeno que se está representando en los datos. Un ejemplo que nos presentan es el de la identificación de una persona a partir de su voz. El sonido emitido permite estimar el tamaño del tracto vocal; este tamaño constituye una **característica** que sirve de pista sobre el sexo y la edad de la persona que habla. 

La definición de característica da paso a la introducción del concepto _representation learning_ (aprendizaje de representaciones, aunque creo que la expresión se utiliza también en pedagogía con otro sentido distinto). Determinar qué características debe extraer nuestro algoritmo es, habitualmente, una tarea muy compleja (pensemos en cómo indicarle que detecte coches en fotos, haciéndolo en términos del valor de cada pixel). El _representation learning_ busca que el ordenador descubra tanto la relación entre la representación y el resultado (si tiene cuatro ruedas es un coche) como la representación en sí (el ordenador no va a saber qué es una rueda, pero sí va a aprender que ciertos valores de pixels en zonas próximas aparecen dos, tres o cuatro veces en las fotos que contienen coches).

