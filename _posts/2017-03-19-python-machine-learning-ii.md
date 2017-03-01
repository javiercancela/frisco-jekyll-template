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
        <img alt="En este modelo se emite una señal de salida si el resultado de aplicar una función a la suma de las entradas supera cierto umbral" src ="/images/pml/2_MCP.png" />
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
x = \begin{bmatrix}
x_1 \cr
\vdots \cr
x_m \cr
\end{bmatrix}, w = \begin{bmatrix}
w_1 \cr
\vdots \cr
w_m \cr
\end{bmatrix}
$$

Y la entrada resultante $$z$$ será la suma de cada entrada ponderada:

$$
z = \sum{w_ix_i} = w_1x_1 + \cdots + w_mx_m
$$

Ya tenemos la entrada $$z$$ a la función de activación $$\phi(z)$$. Para nuestro caso vamos a usar como función de activación la [función escalón](https://es.wikipedia.org/wiki/Funci%C3%B3n_escal%C3%B3n_de_Heaviside). Esta función se define de la siguiente forma:

$$
\phi(z) = \begin{cases}
\text{1 si } z \ge \theta \\
\text{-1 en otro caso}
\end{cases}
$$

Ese valor $$\theta$$ es el umbral que tiene que superar $$z$$ para disparar la señal. Para simplificar los cálculos, definimos un peso 0 con $$w_0 = -\theta$$ y $$x_0 = 1$$, de esta forma podemos escribir:

$$
z = w_0x_0 + w_1x_1 + \cdots + w_mx_m
$$

y 

$$
\phi(z) = \begin{cases}
\text{1 si } z \ge 0 \\
\text{-1 en otro caso}
\end{cases}
$$

El valor de $$z$$ se puede escribir también como $$z = \mathbf{w}^T\bf x$$. El superíndice T indica que la matriz (en este caso un array, que tratamos como una matriz de 1 columna y n filas) está traspuesta, o lo que es lo mismo, se han convertidos sus columnas en filas. Por lo tanto:

$$
\mathbf{w}^T\bf x = \begin{bmatrix} w_0 & w_1 & \cdots & w_m \end{bmatrix} \begin{bmatrix}
x_1 \cr
\vdots \cr
x_m \cr
\end{bmatrix}
$$

Esto nos permite usar la operación de producto escalar entre matrices. En una operación entre matrices, si la primera tiene es de dimensiones $$n \times m$$, la segunda debe tener $$m \times p$$, dando resultado una matriz $$n \times p$$. En nuestro caso, la dimensiones serían $$1 \times n$$ y $$n \times 1$$, dando como resultado una matriz $$1 \times 1$$, es decir, un escalar. Por ello esta operación es realmente un producto escalar entre vectores, cuyo resultado es la ya conocida expresión

$$
z = w_0x_0 + w_1x_1 + \cdots + w_mx_m
$$

## Entrenando el modelo

Recapitulando, lo que pretendemos es ir modificando los valores de los pesos ($$\mathbf{w}$$) de forma que las salidas del preceptrón se vayan acercando a los valores esperados. Para ello se inicializan los pesos a cero, o a un valor muy pequeño, se obtiene la salida, y se actualizan los pesos.

¿Cómo se actualizan los pesos? Pues sumándoles una cantidad (positiva o negativa) que depende de la entrada, de la diferencia entre la salida real y la salida esperada, y de la tasa de aprendizaje, que es una constante que vale entre 0 y 1, denotada por la letra $$\eta$$:

$$
\Delta w_j = \eta(y^{(i) - \hat y^{(i)})x_j^{(i)}
$$

En esta fórmula, a demás de la ya mencionada tasa de aprendizaje $$\eta$$, $$y^{(i)$$ es la clase a la que pertenece la muestra (i), $$\hat y^{(i)}$$ es la clase predicha por el perceptrón, y $$x_j^{(i)}$$ es la entrada de la característica j para la muestra (i). Todo esto se multiplica para calcular la variación en la característica j: $$\Delta w_j$$. Para la siguiente muestra, se recalcularán los pesos:

$$
w_j := w_j + \Delta w_j
$$

