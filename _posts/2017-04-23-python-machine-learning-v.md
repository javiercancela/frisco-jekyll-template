---
title: PML T3 - Introducción a Scikit-learn
date: 2017-04-23 03:00:00 +0200
description: Python Machine Learning - Tema 3 - Notas sobre el libro de Sebastian Raschka
categories:
  - python
  - libros
  - machine-learning
  - inteligencia-artificial
image: /images/pml/pml.jpg
comments: true
---

El propósito del tema 3 es revisar algoritmos comunes de aprendizaje máquina. Las diferencias existentes entre estos algoritmos hacen que cada uno sea más adecuado para unas tareas que para otras. En unos casos el criterio de elección será la naturaleza de nuestros datos (número de características, ruido, separabilidad lineal,...), mientras que en otros nos basaremos en la direfencia de rendimientos.

Como paso previo el libro realiza una presentación de [_scikit-learn_](http://scikit-learn.org/stable/index.html), una librería para Python que incluye varios de los algoritmos más usados en _machine learning_. El código de esta librería es abierto y [está disponible en GitHub](https://github.com/scikit-learn/scikit-learn).

## Perceptrón con _scikit-learn_

Para empezar con la librería, el libro vuelve al Perceptrón con el conjunto de datos Iris. La librería _scikit-learn_ incluye varios conjuntos de datos, así que usaremos el conjunto Iris incluido en la librería. Dividiremos el conjunto en un grupo de datos para el entrenamiento y otro para la validación.


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

El método `train_test_split` reparte el 30% de los datos (`test_size=0.3`) para las pruebas, de forma aleatoria (al fijar un _seed_ a través de `random_state=0` garantizamos que el reparto pseudoaleatorio sea el mismo en cada ejecución). El resultado será una matriz `X_test` con 45 elementos, y un array `y_test` con las 45 clases correspondientes. `X_train` e `y_train` contendrán el resto de los datos para el entrenamiento.

### Escalado de características

Como mencionamos en la entrada anterior, el escalado de características es una técnica básica para la optimización del proceso de entrenamiento. El libro utiliza la clase `StandardScaler` para ilustrar esta técnica:


```python
from sklearn.preprocessing import StandardScaler
sc = StandardScaler()
sc.fit(X_train)
X_train_std = sc.transform(X_train)
X_test_std = sc.transform(X_test)
```

La clase `StandardScaler` contiene un método `fit` que permite estimar los parámetros necesarios para la estandarización. A partir de los datos de entrenamiento proporcionados, el método estimará la media ($$\mu$$) y la [desviación estándar](https://es.wikipedia.org/wiki/Desviaci%C3%B3n_t%C3%ADpica) ($$\sigma$$). Con ellas el método `transform` generará nuestros nuevos conjuntos de datos de entrenamiento y de pruebas estandarizados. Tras la estandarización, las características pasan a tener valores positivos y negativos, siguiendo una distribución casi normal centrada en el cero:

```python
max(X_train_std[:,0])
Out[13]: 1.7101884052506424

max(X_train_std[:,1])
Out[14]: 1.6373128028016599

min(X_train_std[:,0])
Out[15]: -1.5192836530366176

min(X_train_std[:,1])
Out[16]: -1.4487217993375945
```

### La clase `Perceptron` con _one-vs.-rest_

Una diferencia de la clase `Perceptron` de `scikit-learn` con la implementada en el capítulo 2 del libro es que la que vamos a ver ahora soporta clasificaciones multiclase. En el capítulo 2 restringimos nuestro conjunto de datos a muestras de solo dos clases, ya que el algoritmo sólo era capaz de distinguir si una muestra pertenecía a una clase o no. Si la función de activación superaba un umbral se asignaba una clase, si no, se asignaba la otra.

Esta función de activación es inherente al Perceptrón. Sin embargo, aun con ella es posible realizar clasificaciones multiclase. Para ello se utiliza una estrategia llamada 'Uno contra los demás' (_one-vs.-rest_, _OvR_). En esta estrategia se entrena un clasificador para cada clase. Es decir, en nuestro conjunto de datos con tres variantes de Iris, en vez de usar el Perceptrón para entrenar un clasificador que nos diga si una muestra es _Iris-setosa_ o _Iris-versicolor_, entrenaremos un clasificador que nos diga si una muestra es _Iris-setosa_ o no, otro que nos diga si una muestra es _Iris-versicolor_ o no, y otro que haga lo mismo con _Iris-virginica_. 

La clasificación se realiza evaluando cada muestra con cada clasificador. Estos nos dirán si la muestra pertenece a su clase o no. Para poder resolver ambigüedades (una muestra que esté en más de una clase, o que no esté en ninguna), los clasificadores no devuelven una etiqueta, sino una puntuación de confianza que indica cómo de seguro está el clasificador de que una muestra pertenece a la clase evaluada. Así, cuando queremos predecir la clase de una muestra nueva nos quedamos con la clase a la que corresponde la puntuación de confianza más alta.

El código Python para hacer esto es muy simple:
```python
from sklearn.linear_model import Perceptron

ppn = Perceptron(n_iter=40, eta0=0.1, random_state=0)
ppn.fit(X_train_std, y_train)
```

La clase `Perceptron` admite muchos parámetros en el constructor. Los parámetros `n_iter` y `eta0` establecen el número de épocas y la tasa de aprendizaje, como ya vimos en entradas anteriores. Por defecto, la clase `Perceptron` baraja los datos de entrenamiento después de cada época. Para ello usa un generador de números pseudoaleatorios, cuya semilla se puede definir con el parámetro `random_state`. Al fijar este parámetro provocamos que los números aleatorios generados sean siempre los mismos en cada ejecución del código, de forma que siempre que los clasificadores obtenidos sean siempre los mismos.

El [código del libro](https://github.com/rasbt/python-machine-learning-book/blob/master/code/ch03/ch03.ipynb) prosigue mostrando los resultados del entrenamiento: de los datos de prueba se clasifican incorrectamente 4 muestras de 45, es decir, un porcentaje de acierto del 91%:

```python
y_pred = ppn.predict(X_test_std)
print('Misclassified samples: %d' % (y_test != y_pred).sum())
# Imprime: Misclassified samples: 4

from sklearn.metrics import accuracy_score
print('Accuracy: %.2f' % accuracy_score(y_test, y_pred))
# Imprime: Accuracy: 0.91
```

Para finalizar este apartado, el autor modifica el método `plot_decision_regions`, visto en entradas anteriores, para que resalte los datos de prueba con círculos. El código se puede ver [aquí](https://github.com/rasbt/python-machine-learning-book/blob/master/code/ch03/ch03.ipynb).

<div style="text-align:center">
    <figure>
        <a href="https://github.com/rasbt/python-machine-learning-book/blob/master/code/ch03/images/03_01.png">
        <img alt="No es posible realizar una separación perfecta de los tres conjuntos de datos" src ="https://raw.githubusercontent.com/rasbt/python-machine-learning-book/master/code/ch03/images/03_01.png" /></a>
        <figcaption>Como se ven en la gráfica, no es posible realizar una separación perfecta de los tres conjuntos de datos (no se puede dibujar una recta que separe todos los círculos verdes de todas las cruces azules)</figcaption>
    </figure>
</div>