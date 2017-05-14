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


### Regresión logística


La principal característica de la regresión logística es que la variable respuesta es una categoría, no un valor continuo. Siguiendo con nuestro ejemplo, la regresión logística nos permitiría relacionar las horas dedicadas al estudio con la categoría final de la nota: suspenso o aprobado. Este tipo de regresión logística, con dos posibles categorías para el resultado, se llama regresión logística binaria.

Este tipo de regresión estima la probabilidad de que una característica dada un única variable predictora.