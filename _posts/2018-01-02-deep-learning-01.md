---
title: Deep learning - Introducción
date: 2018-01-02 22:00:00 +0200
description: Apuntes sobre el libro Deep Learning, de Ian Goodfellow
categories:
  - Libros
  - Deep Learning
image: /images/deep-learning.jpg
comments: true
---

# Capítulo 1 - Introducción

This book is about a solution to these more intuitive problems. This solution isto allow computers to learn from experience and understand the world in terms of ahierarchy of concepts, with each concept deﬁned in terms of its relation to simplerconcepts. By gathering knowledge from experience, this approach avoids the needfor human operators to formally specify all of the knowledge that the computerneeds. The hierarchy of concepts allows the computer to learn complicated conceptsby building them out of simpler ones. If we draw a graph showing how these concepts are built on top of each other, the graph is deep, with many layers. Forthis reason, we call this approach to AI deep learning.

Chess can be completely described by a very brief list of completely formal rules, easily provided ahead of time by the programmer.

A person’s everyday life requires an immense amount of knowledgeabout the world. Much of this knowledge is subjective and intuitive, and thereforediﬃcult to articulate in a formal way.

The difficulties faced by systems relying on hard-coded knowledge suggestthat AI systems need the ability to acquire their own knowledge, by extractingpatterns from raw data. This capability is known asmachine learning.

The performance of these simple machine learning algorithms depends heavily on the representation of the data they are given. For example, when logisticregression is used to recommend cesarean delivery, the AI system does not examinethe patient directly. Instead, the doctor tells the system several pieces of relevantinformation, such as the presence or absence of a uterine scar. Each piece ofinformation included in the representation of the patient is known as afeature.

One solution to this problem is to use machine learning to discover not onlythe mapping from representation to output but also the representation itself.This approach is known asrepresentation learning.

The quintessential example of a representation learning algorithm is theau-toencoder. An autoencoder is the combination of anencoderfunction thatconverts the input data into a diﬀerent representation, and adecoderfunctionthat converts the new representation back into the original format. Autoencodersare trained to preserve as much information as possible when an input is runthrough the encoder and then the decoder, but are also trained to make the newrepresentation have various nice properties. Diﬀerent kinds of autoencoders aim toachieve diﬀerent kinds of properties

Of course, it can be very diﬃcult to extract such high-level, abstract featuresfrom raw data. Many of these factors of variation, such as a speaker’s accent,can be identiﬁed only using sophisticated, nearly human-level understanding ofthe data. When it is nearly as diﬃcult to obtain a representation as to solve theoriginal problem, representation learning does not, at ﬁrst glance, seem to help us.

Deep learningsolves this central problem in representation learning by intro-ducing representations that are expressed in terms of other, simpler representations.Deep learning allows the computer to build complex concepts out of simpler con-cepts. Figure 1.2 shows how a deep learning system can represent the concept ofan image of a person by combining simpler concepts, such as corners and contours,which are in turn deﬁned in terms of edgesç

The quintessential example of a deep learning model is the feedforward deepnetwork ormultilayer perceptron(MLP). A multilayer perceptron is just amathematical function mapping some set of input values to output values. Thefunction is formed by composing many simpler functions. We can think of eachapplication of a diﬀerent mathematical function as providing a new representationof the inpu