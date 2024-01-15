---
layout: page
title:  "Lesson 5: T-distributed Stochastic Neighbor Embedding"
order: 5
---

# Lecture 5

## 5.0 Lesson learning objectives

By the end of this lesson, we should understand what is t-distributed stochastic neighbor embedding and how to apply it to our spatial transcriptomic datasets.

---

# Hands-on component 5

Our in-class hands-on component will analyzing our spatial transcriptomics datasets to create a data visualization using tSNE. We will also use `gridExtra` to create a multipanel plot. 

---

# Class Lesson Notes 5

Prof. Fan’s whiteboard notes from class: Please consult Slack and OneDrive

Prof. Fan’s code from class: [code-02-03-2023.R (click to download)]({{ site.baseurl }}/resources/code/code-02-03-2023.R)

---

# Homework Assignment 5

Make a new data visualization of your spatial transcriptomics dataset with a minimum of 2 panels using the dimensionality reduction approaches we have been learning about in class. In particular, use data visualization to explore one of the following questions:
1. Should I normalize and/or transform the gene expression data (e.g. log and/or scale) prior to dimensionality reduction?
2. Should I perform non-linear dimensionality reduction on genes or PCs?
3. If I perform non-linear dimensionality reduction on PCs, how many PCs should I use?
4. What genes (or other cell features such as area or total genes detected) are driving my reduced dimensional components?

Write a description describing your data visualization using vocabulary terms from Lesson 1.

Use the same process from HW1 for what is expected and how to submit your homework to the folder `hw3/`. Additional details:
[genomic-data-visualization-HW_3.pptx (click to download)]({{ site.baseurl }}/resources/hw/genomic-data-visualization-HW_3.pptx)

Make a pull request to submit your HW3 (due Monday Midnight).

HW2 due today at Midnight. 

---

# Additional resources
- [Original paper by Laurens van de Maaten](https://lvdmaaten.github.io/publications/papers/JMLR_2008.pdf)
- [Interactive explorer on how to use t-SNE effectively](https://distill.pub/2016/misread-tsne/)



