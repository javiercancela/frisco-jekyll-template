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


Para obtener una función de costos que minimizar, el autor empieza definiendo la siguiente función:

$$
L(\mathbf{w}) = P(\mathbf{y} | \mathbf{x}; \mathbf{w}) = \prod_{i=1}^{n} P \big( y^{(i)} | x^{(i)}; \mathbf{w} \big) =  \prod_{i=1}^{n} \bigg( \phi \big(z^{(i)} \big) \bigg) ^ {y^{(i)}} \bigg( 1 - \phi \big( z^{(i)} \big) \bigg)^{1-y^{(i)}},
$$

donde $$y^{(i)}$$ es la clase ($$1$$ o $$0$$) de la muestra $$i$$, y $$\phi \big(z^{(i)} \big)$$ es la probabilidad de que la muestra $$i$$ pertenezca a la clase $$1$$. Como vimos en la entrada anterior, la clase predicha $$\hat y$$ será $$1$$ si la probabilidad de es mayor o igual a $$0.5$$.

Por tanto, la expresión

$$
\bigg( \phi \big(z^{(i)} \big) \bigg) ^ {y^{(i)}} \bigg( 1 - \phi \big( z^{(i)} \big) \bigg)^{1-y^{(i)}}
$$

indica la probabilidad de que la muestra $$i$$ pertenezca a la clase real ($$y^{(i)}$$), ya que si $$y^{(i)} = 1$$, la expresión se simplifica a $$\phi \big(z^{(i)} \big)$$, y si $$y^{(i)} = 0$$ nos queda $$\bigg( 1 - \phi \big( z^{(i)} \big) \bigg)^{1-y^{(i)}}$$, que es la probabilidad de que la muestra sea de clase distinta de $$1$$, es decir, la probabilidad de que se de clase $$0$$.

Entonces, la función $$L(\mathbf{w})$$ es el producto de las probabilidades de que cada muestra sea de su clase real, en función de los pesos $$\mathbf{w}$$ establecidos. Si maximizamos esa función, estaremos maximizando la calidad de la predicción para el conjunto de muestras. 

El siguiente paso que da el libro es calcular el logaritmo de $$L(\mathbf(w))$$. El propósito de esta función es