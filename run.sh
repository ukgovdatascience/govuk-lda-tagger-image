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
    import /mnt/input/url_text.csv
