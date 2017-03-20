---
title: Machine Learning con Python - Tema 2 - Adaline
date: 2017-04-02 03:00:00 +0200
description: Notas sobre el libro "Python Machine Learning", de Sebastian Raschka
categories:
  - python
  - libros
  - machine-learning
  - inteligencia-artificial
image: /images/pml/pml.jpg
comments: true
---

El perceptrón visto en el post anterior es una red neuronal de una sola capa. Otro ejemplo de este tipo de redes es la llamada **neurona lineal adaptativa**, en inglés _ADAptative LIneal NEuron_, o [_ADALINE_](https://es.wikipedia.org/wiki/Adaline). Nos dice el libro que la importancia de este algoritmo se debe a que muestra con claridad la definición y minimización de las funciones de costos (_cost functions_). 

## Función de costos
**Función de costos** es un término que procede de la economía, y hace referencia a la función que expresa los costes de producción en términos de la cantidad conocida. En el campo de las redes neuronales la función de costos devuelve un número que determina indica lo bien que el algoritmo genera las salidas correctas para las muestras de entrenamiento. Este número es mejor cuanto más bajo, por eso se busca minimizar el valor de la función. Esta minimización de la función de costos supone la base de técnicas de clasificación más avanzadas.

La diferencia básica entre Adaline y el perceptrón está en la función de activación, que pasa de ser una función escalón a ser una función lineal.


<div style="text-align:center">
    <figure>
        <a href="https://github.com/rasbt/python-machine-learning-book/blob/master/code/ch02/images/02_09.png"><img alt="Actualizamos los pesos con una función lineal de la entrada" src ="https://raw.githubusercontent.com/rasbt/python-machine-learning-book/master/code/ch02/images/02_09.png" /></a>
        <figcaption>Actualizamos los pesos con una función lineal de la entrada</figcaption>
    </figure>
</div>

En concreto, la función lineal de activación de Adaline es la función identidad $$\phi(z) = z$$, con lo que $$\phi(\mathbf{w}^T\bf x) = \mathbf{w}^T\bf x$$. Como vemos en la gráfica superior, se sigue usando un cuantizador para clasificar la muestra, aunque no se use ya para corregir los pesos.

## Minimización de funciones de costos

Como vimos en el caso del perceptrón, la actualización de pesos se realiza calculando $$w_j := w_j + \eta(y^{(i)} - \hat y^{(i)})x_j^{(i)}$$. Para el perceptrón tanto $$y^{(i)}$$ como $$\hat y^{(i)}$$ son etiquetas de clases con solo dos posibles valores. En el caso de Adaline se usan valores continuos.

