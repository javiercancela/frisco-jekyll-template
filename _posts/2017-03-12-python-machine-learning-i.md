---
title: Machine Learning con Python - Tema 1
date: 2017-03-12 03:00:00 +0200
description: Notas sobre el libro "Python Machine Learning", de Sebastian Raschka
categories:
  - python
  - libros
  - machine-learning
  - inteligencia-artificial
image: /images/pml/pml.jpg
comments: true
---

El foco de estas entradas se pondrá en el [código Python publicado en GitHub](https://github.com/rasbt/python-machine-learning-book). El primer tema no incluye código, tan sólo presenta una serie de conceptos que resumo en esta entrada.

## Tipos de _machine learning_

Existen tres estrategias distintas de aprendizaje automático: supervisado, no supervisado y refozado

### Supervisado

En el aprendizaje supervisado se entrena el modelo con datos para los que ya se conoce el resultado correcto. En función del tipo de resultado que esperemos obtener, podemos encontrarnos con que los datos de entrenamiento llevan asociada una etiqueta que indica a qué categoría pertenece, o un valor numérico. En el primer caso hablamos de **clasificación**, y en el segundo de **regresión**.

Un ejemplo de problema de clasificación es el mencionado en la entrada anterior: la clasificación de spam. Al modelo se le presenta con una serie de correos que ya han sido identificados con una etiqueta 'spam' o 'no spam'. El modelo utiliza esos correos para calibrar ciertos valores internos, de forma que pueda identificar correctamente futuros correos sin intervenció humana.

En los problemas de regresión el valor esperado pertenece a un rango continuo. Un ejemplo, [sacado de este post (en inglés)](http://setosa.io/ev/ordinary-least-squares-regression/), sería un modelo para predecir la altura de una persona a partir del tamaño de su mano. Para ello entrenaríamos el modelo con una muestra aleatoria de personas, para las cuales tendríamos tanto el tamaño de su mano como su altura real. El resultado sería una ecuación del tipo 
\begin{equation}
y = A + Bx
\end{equation}
donde _x_ sería el tamaño de la mano, _A_ y _B_ valores definidos tras el proceso de aprendizaje, e _y_ la altura predicha para el valor x.

<div style="text-align:center">
    <figure>
        <img alt="El modelo (agent) cambia el estado a través de una acción. Este cambio nos acerca más o menos al objetivo. Realimentamos el modelo con una recompensa, así como con la acción que generó dicha recompensa" src ="/images/pml/1_refuerzo.png" />
        <figcaption>El modelo (agent) cambia el estado a través de una acción. Este cambio nos acerca más o menos al objetivo. Realimentamos el modelo con una recompensa, así como con la acción que generó dicha recompensa</figcaption>
    </figure>
</div>

### Reforzado

El aprendizaje reforzado entrena un modelo para que consiga un objetivo. Para ello se alimenta el modelo con el resultado de una función que evalúa cómo de cerca estamos del objetivo. Se establece un ciclo en el que el modelo genera una salida, la función evalúa cómo de satisfactoria ha sido esta salida, y la evalucación se utiliza para ajustar el modelo.