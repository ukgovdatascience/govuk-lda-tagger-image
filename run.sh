#!/bin/bash

docker run -i --rm -v ${PWD}/output:/mnt/output \
    -v ${PWD}/experiments:/mnt/experiments \
    -v ${PWD}/input:/mnt/input \
    ukgovdatascience/govuk-lda-tagger-image:latest python train_lda.py \
    --output-topics /mnt/output/topics.csv \
    --output-tags /mnt/output/tags.csv \
    --vis-filename /mnt/output/vis.html \
    --numtopics 7 \
    --passes 1 \
    # See http://radimrehurek.com/gensim/wiki.html#latent-dirichlet-allocation
    # for information on switching between batch and online mode using
    # chunksize and update_every.
    --chunksize 1000 \
    --update_every 1 \
    import /mnt/input/url_text.csv
