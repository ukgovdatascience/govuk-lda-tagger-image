#!/bin/bash

docker run -i --rm -v ${PWD}/output:/mnt/output \
    ukgovdatascience/govuk-lda-tagger-image:latest python train_lda.py \
    --output-topics /mnt/output/topics.csv \
    --output-tags /mnt/output/tags.csv \
    --vis-filename /mnt/output/vis.html \
    --numtopics 3 \
    --passes 1 \
    import input/environment_urltext_100.csv
