---
layout: page
title:  "Lesson 5: T-distributed Stochastic Neighbor Embedding"
order: 5
---

# Lecture

## Learning objectives

By the end of this lesson, we should understand what is t-distributed stochastic neighbor embedding and how to apply it to our spatial transcriptomic datasets.

---

# Hands-on Component

Our in-class hands-on component will analyzing our spatial transcriptomics datasets to create a data visualization using tSNE. We will also use `gridExtra` to create a multipanel plot. 

---

# Class Notes

Prof. Fan’s whiteboard notes from class: 

Prof. Fan’s code from class: [code-lesson-5.R (click to download)]({{ site.baseurl }}/resources/code/code-lesson-5.R)

---

# Homework Assignment

Make a new data visualization of your spatial transcriptomics dataset with a minimum of 2 panels using the dimensionality reduction approaches we have been learning about in class. In particular, use data visualization to explore one of the following questions:
1. Should I normalize and/or transform the gene expression data (e.g. log and/or scale) prior to dimensionality reduction?
2. Should I perform non-linear dimensionality reduction on genes or PCs?
3. If I perform non-linear dimensionality reduction on PCs, how many PCs should I use?
4. What genes (or other cell features such as area or total genes detected) are driving my reduced dimensional components?

Write a description describing your data visualization using vocabulary terms from Lesson 1.

Use the same process from `HW_1` for what is expected and how to submit your homework to the folder `hw3/`. Additional details:
[genomic-data-visualization-HW_3.pptx (click to download)]({{ site.baseurl }}/resources/hw/genomic-data-visualization-HW_3.pptx)

---

# Additional resources
- [Original paper by Laurens van de Maaten](https://lvdmaaten.github.io/publications/papers/JMLR_2008.pdf)
- [Interactive explorer on how to use t-SNE effectively](https://distill.pub/2016/misread-tsne/)



