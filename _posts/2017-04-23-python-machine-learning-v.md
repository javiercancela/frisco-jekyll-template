---
title: Machine Learning con Python - Tema 3 - Introducción a Scikit-learn
date: 2017-04-23 03:00:00 +0200
description: Notas sobre el libro "Python Machine Learning", de Sebastian Raschka
categories:
  - python
  - libros
  - machine-learning
  - inteligencia-artificial
image: /images/pml/pml.jpg
comments: true
---

El propósito del tema 3 es revisar algoritmos comunes de aprendizaje máquina. Las diferencias existentes entre estos algoritmos los hacen más adecuados a unas tareas que a otras. En unos casos nos intererarán por la naturaleza de nuestros datos (número de características, ruido, separabilidad lineal,...), mientras que en otros tendremos que comparar el rendimiento para sacar conclusiones.

Como paso previo el libro realiza una presentación de [_scikit-learn_](http://scikit-learn.org/stable/index.html), una librería para Python que incluye varios de los algoritmos más usados en _machine learning_. El código de esta librería es abierto y [está disponible en GitHub](https://github.com/scikit-learn/scikit-learn).

## Perceptrón con _scikit-learn_

Para empezar con la librería, el libro vuelve al Perceptrón con el conjunto de datos Iris. La librería _scikit-learn_ incluye varios conjuntos de datos, así que usaremos ya el conjunto Iris incluido en la librería. Dividiremos el conjunto en un grupo de datos para el entrenamiento y otro para la validación.


```python
from sklearn import datasets
from sklearn.model_selection import train_test_split
import numpy as np
iris = datasets.load_iris()
X = iris.data[:, [2, 3]]
y = iris.target
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3,
                                                    random_state=0)
```

Cargamos los datos de la librería y hacemos un _slice_ de dos de las columnas (dos caracterísiticas) para cargar los datos en la matriz `X`. La librería nos permite acceder directamente a las clases reales de cada muestra a través de `iris.target`, donde los valores para _Iris-Setosa_, _Iris-Versicolor_ e _Iris-Virginica_ están almacenados como 0, 1 y 2.  

El método `train_test_split` reparte el 30% de los datos (`test_size=0.3`) para las pruebas, de forma aleatoria. El resultado será una matriz `X_test` con 45 elementos, y un array `y_test` con las 45 clases correspondientes. `X_train` e `y_train` contendrán el resto de los datos para el entrenamiento.

### Escalado de características

Como mencionamos en la entrada anterior, el escalado de características es una técnica básica para la optimización del proceso de entrenamiento. El libro utiliza la clase `StandardScaler` para ilustrar esta técnica:


```python

```





