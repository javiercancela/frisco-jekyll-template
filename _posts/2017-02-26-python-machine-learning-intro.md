---
title: Machine Learning con Python - Introducción
date: 2017-02-26 03:00:00 +0200
description: Notas sobre el libro "Python Machine Learning", de Sebastian Raschka
categories:
  - python
  - libros
  - machine-learning
  - inteligencia-artificial
image: /images/pml/pml.jpg
comments: true
---

Tengo este blog fundamentalmente para aprender. La forma en la que aprendo alguna cosa es la siguiente: decido sobre qué quiero aprender, decido qué material voy a utilizar para ello (libros, cursos web, blogs,...) y preparo unos apuntes basados en ese material. Esos apuntes consisten en entradas en este blog donde explico aquello que creo haber entendido.

Por lo tanto, en este tipo de entradas hablo sobre cosas de las que sé entre poco y nada, y lo hago resumiendo, traduciendo, y reformulando las explicaciones de alguien que sí sabe de qué habla (o eso espero).

## _Python Machine learning_

Esta entrada es la primera de una serie dedicada a la inteligencia artificial, específicamente a la rama conocida como _machine learning_. La guía para ello va a ser el libro [Python Machine Learning](https://www.amazon.es/Python-Machine-Learning-Sebastian-Raschka/dp/1783555130/), de [Sebastian Raschka](https://sebastianraschka.com/). 

<div style="text-align:center">
    <figure>
        <a href="https://www.packtpub.com/big-data-and-business-intelligence/python-machine-learning"><img style="width:400px" alt="La portada del libro" src ="/images/pml/pymle_cover.jpg" /></a>
        <figcaption>La portada del libro</figcaption>
    </figure>
</div>

Es un libro muy práctico, tiene muchos ejemplos en Python, [todo el código fuente está disponible en GitHub](https://github.com/rasbt/python-machine-learning-book), tiene buenas críticas en Amazon, y está bien escrito. Es un libro muy recomendable para quien quiera iniciarse en el tema.

En GitHub se incluye [una faq](https://github.com/rasbt/python-machine-learning-book/tree/master/faq) en la [se autoriza usar hasta el 10% del contenido del libro](https://github.com/rasbt/python-machine-learning-book/blob/master/faq/copyright.md) siempre que se cite y acredite correctamente, y no se venda o redistribuya la información. Esto me permite incluir imágenes y algún párrafo suelto para ir ilustrando las entradas.

En la próxima entrada de la serie comenzaremos con el tema 1 del libro, con la idea de ir repasando todo el libro por orden. Hasta entonces resumo algunas respuestas de la faq mencionada.

## _Machine Learning_

Ver [What are data science and machine learning?](https://github.com/rasbt/python-machine-learning-book/blob/master/faq/datascience-ml.md)

Casi todas las definiciones de _machine learning_ (prefiero el término inglés a la traducción española, que suele ser 'aprendizaje automático') hacen refencia a los algoritmos empleados, ya que en realidad el _machine learning_ es una forma concreta de programación.

El autor define un algoritmo de _machine learning_ como aquel que aprende, e incluso predice, modelos a partir de datos. 

<div style="text-align:center">
    <figure>
        <img alt="El aprendizaje automático es el campo de estudio que proporciona a los ordenadores la capacidad de aprender sin haber sido explícitamente programados para ello - Arthur Samuel (1959)" src ="https://github.com/rasbt/python-machine-learning-book/raw/master/faq/datascience-ml/ml-overview.jpg" />
        <figcaption>El aprendizaje automático es el campo de estudio que proporciona a los ordenadores la capacidad de aprender sin haber sido explícitamente programados para ello - Arthur Samuel (1959)</figcaption>
    </figure>
</div>

Uno de los ejemplos más clásicos es el filtro de spam. Un programa convencional que tuviese que separar el spam del correo legítimo tendría que incorporar una serie de reglas if/then que comprobasen una serie de términos, especificados por expertos en la materia, y discriminasen los correos en base a esas reglas.

La forma '_machine learning_' de realizar esta tarea comenzaría con una muestra de correos, algunos spam y otros no, a los que unos clasificadores humanos hubiesen etiquetado correspondientemente. El algoritmo de _machine learning_ examinaría estos correos y extraería un conjunto de reglas para clasificar los correos que se le suministrasen en el futuro. A este tipo de aproximación se le llama aprendizaje supervisado.

## _Machine learnign_ e Inteligencia Artificial

Ver [How are Artificial Intelligence and Machine Learning related?](https://github.com/rasbt/python-machine-learning-book/blob/master/faq/ai-and-ml.md)

La inteligencia artificial es la disciplina que se centra en las tareas en las que los humanos son mucho mejor que las máquinas, como detectar spam o identificar objetos en una imagen.

El autor no considera el _machine learning_ como una subdisciplina de la inteligencia artificial. Ambas disciplinas se solapan, pero también tienen áreas de conocimiento independientes. En el caso del _machine learning_ se incluirían las técnicas de _data mining_ (término que se aplica en general a las técnicas de extracción de información a partir de datos en bruto), que no son parte de la inteligencia artificial. 

<div style="text-align:center">
    <figure>
        <img alt="El 'deep learning' sí es una subdisciplina del 'machine learning', pero lo trataremos más adelante " src ="https://raw.githubusercontent.com/rasbt/python-machine-learning-book/master/faq/ai-and-ml/ai-and-ml-1.png" />
        <figcaption>El 'deep learning' sí es una subdisciplina del 'machine learning', pero lo trataremos más adelante</figcaption>
    </figure>
</div>

## Python

Ver [Why did you choose Python for Machine Learning?](https://github.com/rasbt/python-machine-learning-book/blob/master/faq/why-python.md)

<div style="text-align:center">
    <figure>
        <a href="https://xkcd.com/353/"><img alt="Cualquier cosa interesante que quiera decir ya la ha dicho Randall Munroe mejor que yo" src ="https://imgs.xkcd.com/comics/python.png" /></a>
        <figcaption>Cualquier cosa interesante que quiera decir ya la ha dicho Randall Munroe mejor que yo</figcaption>
    </figure>
</div>


