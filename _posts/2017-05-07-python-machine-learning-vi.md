---
title: Machine Learning con Python - Tema 3 - Regresión logística
date: 2017-04-30 03:00:00 +0200
description: Notas sobre el libro "Python Machine Learning", de Sebastian Raschka
categories:
  - python
  - libros
  - machine-learning
  - inteligencia-artificial
image: /images/pml/pml.jpg
comments: true
---

La regresión logística es un modelo de clasificación que permite superar algunos de los problemas del perceptrón, como su incapacidad para converger si las clases no son linearmente separables. Para estudiarlo, empezaremos con un pequeño recordatorio sobre los conceptos estadísticos involucrados.

## Análisis por regresión

El análisis por regresión es un proceso que permite estimar la relación entre variables. En este proceso se parte de una o más variables conocidas (variables independientes o predictoras) y se busca construir un modelo que prediga el comportamiento de otra variable desconocida, llamada variable dependiente. Típicamente se busca calcular el valor medio de la variable dependiente para unos valores fijos de las variables independientes.

<div style="text-align:center">
    <figure>
        <img alt="Un ejemplo de regresión lineal sacado de la wikipedia" src ="https://upload.wikimedia.org/wikipedia/commons/3/3a/Linear_regression.svg" />
        <figcaption>Un ejemplo de regresión lineal sacado de la wikipedia</figcaption>
    </figure>
</div>


Dependiendo de la naturaleza de las variables involucradas se pueden llevar a cabo análisis por regresión de distintos tipos. Uno de los más habituales es la [regresión lineal](https://es.wikipedia.org/wiki/Regresión_lineal). En este tipo de análisis se busca una relación lineal entre la variables:

$$
\mathbf{y} = \mathbf{X}\beta + \epsilon
$$

Un ejemplo de regresión lineal sería el siguiente: imaginemos un curso universitario que tiene un examen final puntuado de 0 a 10. Para ese examen tenemos la lista de notas sacadas por los alumnos en los últimos años, así como el número de horas que cada alumno empleó preparando la asignatura.
