---
title: Machine Learning con Python - Tema 2 - El perceptrón
date: 2017-03-19 03:00:00 +0200
description: Notas sobre el libro "Python Machine Learning", de Sebastian Raschka
categories:
  - python
  - libros
  - machine-learning
  - inteligencia-artificial
image: /images/pml/pml.jpg
comments: true
---

Empezamos con los algoritmos. Vamos a implementar un perceptrón en Python, y entrenarlo para que sepa clasificar las diferentes especies de flores en Iris. El libro comienza mostrando el [modelo de neurona de McCulloch-Pitts](https://es.wikipedia.org/wiki/Neurona_de_McCulloch-Pitts):

<div style="text-align:center">
    <figure>
        <a href="https://www.packtpub.com/big-data-and-business-intelligence/python-machine-learning"><img alt="En este modelo se emite una señal de salida si el resultado de aplicar una función a la suma de las entradas supera cierto umbral" src ="/images/pml/2_MCP.png" /></a>
        <figcaption>En este modelo se emite una señal de salida si el resultado de aplicar una función a la suma de las entradas supera cierto umbral</figcaption>
    </figure>
</div>

## Perceptrón

El [perceptrón](https://es.wikipedia.org/wiki/Perceptr%C3%B3n) es un algoritmo de aprendizaje supervisado para realizar tareas de clasificación binaria, es decir, para determinar si una muestra pertenece o no a una clase.

<div style="background-color: #EEEEEE; padding: 1em">
El libro asume cierta familiaridad trabajando con vectores y matrices. Para refrescar conceptos recomiendo revisar los <a href="https://es.wikipedia.org/wiki/%C3%81lgebra_lineal#Enlaces_externos">enlaces externos referenciados en la página de la Wikipedia dedicada al Álgebra Linea</a>.
</div>

<div style="text-align:center">
    <figure>
        <a href="https://commons.wikimedia.org/wiki/File:Perceptr%C3%B3n_5_unidades.svg#/media/File:Perceptr%C3%B3n_5_unidades.svg"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Perceptr%C3%B3n_5_unidades.svg/1200px-Perceptr%C3%B3n_5_unidades.svg.png" alt="Perceptrón 5 unidades.svg"></a>
        <figcaption>
            De <a href="//commons.wikimedia.org/w/index.php?title=User:Alejandro.cartas&amp;action=edit&amp;redlink=1" class="new" title="User:Alejandro.cartas (page does not exist)">Alejandro Cartas</a> - <span class="int-own-work" lang="es">Trabajo propio</span>, <a href="http://creativecommons.org/licenses/by-sa/4.0" title="Creative Commons Attribution-Share Alike 4.0">CC BY-SA 4.0</a>, <a href="https://commons.wikimedia.org/w/index.php?curid=41534843">Enlace</a>
        </figcaption>
    </figure>
</div>

Como podemos ver en la figura anterior, la señal de entrada está compuesta por un array $$\bf x$$ al que se aplica una serie de pesos definidos por un array $$\bf w$$. Es decir, cada elemento $$x_i$$ se multiplica por $$w_i$$, y se suma el resultado de cada uno de estos productos. De una manera más formal, definimos
$$
\begin{align}
x = \begin{bmatrix}
x_1 \cr
\vdots \cr
x_m \cr
\end{bmatrix}, w = \begin{bmatrix}
w_1 \cr
\vdots \cr
w_m \cr
\end{bmatrix}
\end{align}
$$

Y la entrada resultante $$z$$ será la suma de cada entrada ponderada:
$$
\begin{align}
z = \sum{w_ix_i} = w_1x_1 + \cdots + w_mx_m
\end{align}
$$

Ya tenemos la entrada $$z$$ a la función de activación $$\phi(z)$$. Para nuestro caso vamos a usar como función de activación la [función escalón](https://es.wikipedia.org/wiki/Funci%C3%B3n_escal%C3%B3n_de_Heaviside). Esta función se define de la siguiente forma:
$$
\begin{align}
\phi(z) = \begin{cases}
\text{1 si } z \ge \theta \\
\text{-1 en otro caso}
\end{cases}
\end{align}
$$

