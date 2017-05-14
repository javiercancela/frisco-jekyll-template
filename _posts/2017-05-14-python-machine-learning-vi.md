---
title: Machine Learning con Python - Tema 3 - Regresión lineal
date: 2017-05-14 03:00:00 +0200
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

El análisis por regresión es un proceso que permite estimar la relación entre dos o más variables. En este proceso se parte de una o más variables conocidas (variables independientes o predictoras) y se busca construir un modelo que prediga el comportamiento de otra variable desconocida, llamada variable dependiente. Típicamente se busca calcular el valor medio de la variable dependiente para unos valores fijos de las variables independientes.

<div style="text-align:center">
    <figure>
        <img alt="Un ejemplo de regresión lineal sacado de la wikipedia" src ="https://upload.wikimedia.org/wikipedia/commons/3/3a/Linear_regression.svg" />
        <figcaption>Un ejemplo de regresión lineal sacado de la wikipedia</figcaption>
    </figure>
</div>

### Regresión lineal


Dependiendo de la naturaleza de las variables involucradas se pueden llevar a cabo análisis por regresión de distintos tipos. Uno de los más habituales es la [regresión lineal](https://es.wikipedia.org/wiki/Regresión_lineal). En este tipo de análisis se busca una relación lineal entre la variables:

$$
\mathbf{y} = \mathbf{X}\beta + \epsilon
$$

Un ejemplo de regresión lineal sería el siguiente: imaginemos un curso universitario que tiene un examen final puntuado de 0 a 10. Para ese examen tenemos la lista de notas sacadas por los alumnos en los últimos años, así como el número de horas que cada alumno empleó preparando la asignatura:
<div style="text-align:center">
    <figure>
        <img alt="Datos de horas estudiadas y notas conseguidas para 50 alumnos de una misma asignatura" src ="/images/pml/3_reg_lineal_1.png" />
        <figcaption>Datos de horas estudiadas y notas conseguidas para 50 alumnos de una misma asignatura</figcaption>
    </figure>
</div>

En este caso tenemos dos variables: las horas empleadas en el estudio (el predictor), y la nota conseguida en el alcance (la respuesta). Llamamos predictor a la primera variable porque la regresión lineal nos permitirá calcular una función (lineal) que prediga la nota de un estudiante a partir de las horas estudiadas, con un cierto margen de error. Este ejemplo constituye además una regresión lineal simple, ya que sólo tiene una variable predictora. 

El propósito de la regresión lineal es obtener una línea recta que, en cada punto del eje $$X$$ (para cada valor del predictor) tenga un valor medio sobre los datos reales de la muestra. Como es lógico, esto no es posible para cada conjunto de datos. Existen una serie de condiciones que los datos deben cumplir para que esto sea posible:
* La media de las respuestas debe ser una función lineal de la variable predictora
* Los errores de cada muestra (la cantidad que cada muestra se desvía sobre esta media) deben ser independientes
* Los errores de las muestras con un mismo predictor deben seguir una distribución normal 
* Los errores de las muestras de cada predictor deben tener la misma varianza

Calcular la regresión lineal consiste en calcular los valores $$b_0$$ y $$b_1$$ tales que 

$$
\hat{y}_i=b_0+b_1x_i
$$

donde $$x_i$$ es el predictor de la muestra $$i$$, $$y_i$$ es el valor de la muestra $$i$$, y $$\hat{y}$$ es el valor esperado (según la regresión calculada) de la muestra $$i$$. El cálculo de $$b_0$$ y $$b_1$$ se realiza minimizando el error de cada error $$e_i=y_i-\hat{y}_i$$. Una forma de conseguir esto, como ya vimos anteriormente, es minimizar la suma del cuadrado de los errores. Es decir, minimizamos

$$
Q=\sum_{i=1}^{n}(y_i-(b_0+b_1x_i))^2,
$$

lo que nos da 

$$
b_0=\bar{y}-b_1\bar{x} 
$$ 

y

$$
b_1=\frac{\sum_{i=1}^{n}(x_i-\bar{x})(y_i-\bar{y})}{\sum_{i=1}^{n}(x_i-\bar{x})^2}.
$$

En estas ecuaciones $$\bar{y}$$ y $$\bar{x}$$ representan la media de los valores $$y_i$$ y $$x_i$$, respectivamente.

Para nuestro ejemplo, la recta resultante es 

$$
\hat{y}_i=2.37+0.39x_i
$$

<div style="text-align:center">
    <figure>
        <img alt="Datos de horas estudiadas y notas conseguidas para 50 alumnos de una misma asignatura, y regresión calculada" src ="/images/pml/3_reg_lineal_2.png" />
        <figcaption>Datos de horas estudiadas y notas conseguidas para 50 alumnos de una misma asignatura, y regresión calculada</figcaption>
    </figure>
</div>
