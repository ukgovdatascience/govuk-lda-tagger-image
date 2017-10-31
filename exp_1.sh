#!/bin/bash

docker run -i --rm -v ${PWD}/output:/mnt/output \
    -v ${PWD}/experiments:/mnt/experiments \
    ukgovdatascience/govuk-lda-tagger-image:latest python train_lda.py \
    --output-topics /mnt/output/topics.csv \
    --output-tags /mnt/output/tags.csv \
    --vis-filename /mnt/output/vis.html \
    --numtopics 10000 \
    --passes 50 \
    import /mnt/input/govuk_urltext.csv

