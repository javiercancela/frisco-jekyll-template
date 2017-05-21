---
title: PML T3 - Algoritmo con regresión logística
date: 2017-05-28 03:00:00 +0200
description: Python Machine Learning - Tema 3 - Notas sobre el libro de Sebastian Raschka
categories:
  - python
  - libros
  - machine-learning
  - inteligencia-artificial
image: /images/pml/pml.jpg
comments: true
---

A partir del concepto de [regresión logística]({% post_url 2017-05-21-python-machine-learning-vii %}) 
podemos ya definir el siguiente algoritmo.

## El modelo para la regresión logística

El libro traza un paralelo con el modelo [ADALINE]({% post_url 2017-04-02-python-machine-learning-iii %}), donde la función indentidad ($$\phi(z)=z$$) es sustituida por la función logística (sigmoidea) en nuestro modelo:

<div style="text-align:center">
    <figure>
        <img alt="El algoritmo de ADALINE con la función identidad sustituida por la función logística o sigmoidea" src ="https://raw.githubusercontent.com/rasbt/python-machine-learning-book/master/code/ch03/images/03_03.png" />
        <figcaption>El algoritmo de ADALINE con la función identidad sustituida por la función logística o sigmoidea</figcaption>
    </figure>
</div>

### Cálculo de los pesos

Cuando hablamos de ADALINE definimos la [función de costos de la suma de los errores cuadrados]({% post_url 2017-04-02-python-machine-learning-iii%}#1) para minimizarla:

$$
J({\mathbf{w}}) = \frac{1}{2} \sum_i \big(y^{(i)} - \phi(z)_{A}^{(i)}\big)^2.
$$



