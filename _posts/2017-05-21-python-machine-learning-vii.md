---
title: PML T3 - Regresión logística
date: 2017-05-21 03:00:00 +0200
description: Python Machine Learning - Tema 3 - Notas sobre el libro de Sebastian Raschka
categories:
  - python
  - libros
  - machine-learning
  - inteligencia-artificial
image: /images/pml/pml.jpg
comments: true
---

Seguimos con algunos conceptos estadísticos útiles para estudiar el modelo de regresión logística.

### Predicción de categorías

La principal característica de la regresión logística es que la variable respuesta es una categoría, no un valor continuo. Siguiendo con el ejemplo de la entrada anterior, la regresión logística nos permitiría relacionar las horas dedicadas al estudio con la categoría final de la nota: suspenso o aprobado. Este tipo de regresión logística, con dos posibles categorías para el resultado, se llama regresión logística binaria.

La regresión logística estima la probabilidad de que una característica esté presente en la muestra para los valores de las variables predictoras dadas. Estos valores pueden ser continuos, discretos, categóricos o una mezcla de varios. En el caso de que queramos estimar la probabilidad de que una persona desarrolle cáncer de pulmón (y por lo tanto predecir, por ejemplo, si lo va a desarrollar en los próximos 5 años), podríamos utilizar como factores predictores el tiempo que lleva fumando (una variable continua), la cantidad de cigarrillos (una variable discreta), y si tiene o no antecedentes familiares (una categoría con dos posibles valores). 

Todos esos factores se incorporarían al modelo de la siguiente forma. Sea $$Y$$ la variable respuesta. Para una persona (muestra) $$i$$, existen dos posibles valores:

$$
Y_i = 1 \rightarrow \text{  la persona desarrollará la enfermedad}
$$

$$
Y_i = 0 \rightarrow \text{  la persona no desarrollará la enfermedad}
$$

El conjunto de variables predictoras lo modelaremos a través de $$X = (X_1, X_2, ..., X_k)$$, donde $$x_i$$ es el valor observado para la persona (muestra) $$i$$. Para simplificar el modelo, nos centraremos en una única variable predictora $$X$$. El modelo intentará encontrar la probabilidad de que la persona desarrolle la enfermedad ($$Y_i=1$$) para un valor predictor concreto ($$X_i=x_i$$):

$$
\pi_i=Pr(Y_i=1|X_i=x_i) \text{  (1)}
$$


### La función logística

La [función logística](https://es.wikipedia.org/wiki/Funci%C3%B3n_log%C3%ADstica) es la curva definida por la siguiente ecuación:

$$
f(x)=\dfrac{L}{1+e^{-k(x-x_0)}}
$$

Un caso especial de esta función es la [función sigmoidea](https://es.wikipedia.org/wiki/Funci%C3%B3n_sigmoide), donde $$L=1$$, $$k=1$$ y $$x_0=0$$:

$$
f(x)=\dfrac{1}{1+e^{-x}} \text{  (2)}
$$

<div style="text-align:center">
    <figure>
        <img alt="Función sigmoidea sacada de la wikipedia" src ="https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/Logistic-curve.svg/600px-Logistic-curve.svg.png" />
        <figcaption>Función sigmoidea sacada de la wikipedia</figcaption>
    </figure>
</div>

Este tipo de función tiene múltiples usos en distintas disciplinas científicas. En nuestro caso, nos interesa porque los valores de $$f(x)$$ tienen a $$L$$ o $$-L$$ según $$x$$ tiene a $$\infty$$ o $$-\infty$$. Si $$L=1$$, se puede interpretar que esta funcion asigna una probabilidad a un suceso en función de $$x$$. En el caso de una red neuronal, la entrada neta al sistema no será $$x$$, sino $$z=w_0x_0+w_1x_1$$ (para el caso de una única variable predictora), que podemos simplificar como $$\beta_0 + \beta_1x$$. Por tanto, de $$\text{(1)}$$ y $$\text{(2)}$$:

$$
Pr(Y_i=1|Z_i=z_i)=\phi(z)=\dfrac{1}{1+e^{-z}} 
$$

y multiplicando arriba y abajo por $$e^z$$:

$$
\phi(z)=\dfrac{e^z}{1+e^z}
$$

Como los valores de $$\phi(z)$$ van a variar entre 0 y 1, podemos establecer como regla para categorizar muestras que la categoría predicha $$\hat y$$ valdrá:

$$
\hat y = \begin{cases}
\text{1 si } \phi(z) \ge 0.5 \cr
\text{-1 en otro caso}
\end{cases}
$$

Utilizaremos estas ideas en la siguiente entrada para plantear el algoritmo de regresión lineal.

