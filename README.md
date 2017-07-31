# Tag GOV.UK content using LDA in a docker container 

Tag GOV.UK content with topics generated using Latent Dirichlet Allocation ([govuk-lda-tagger-lite](https://github.com/ukgovdatascience/govuk-lda-tagger-lite)) in a [Docker](https://www.docker.com) container. 

## Getting started

### Automatic build

The easiest way to get started with this image is to run the following command from a terminal (ensuring that docker is installed):

```
docker run -i --rm -v ${PWD}/output:/mnt/output \
    ukgovdatascience/govuk-lda-tagger-image:latest python train_lda.py \
    --output-topics /mnt/output/topics.csv \
    --output-tags /mnt/output/tags.csv \
    --vis-filename /mnt/output/vis.html \
    --numtopics 7 \
    --passes 1 \
    import input/url_text.csv

```

This will download the pre-built container from [DockerHub](https://hub.docker.com/r/ukgovdatascience/govuk-lda-tagger-image/), and run and test based on data included in the [govuk-lda-tagger-lite](https://github.com/ukgovdatascience/govuk-lda-tagger-lite) repository.

Output files will be produced in a new directory called `output/`, so ensure that you run the command from a working directory.

### Gotchas

Note that the [govuk-lda-tagger-lite](https://github.com/ukgovdatascience/govuk-lda-tagger-lite) repository is a submodule of this repository. This means that it is a git repository within a git repository. When pulling this repo for the first time, you must run the commands:

```
git submodule init
git submodule update
```
This will pull the govuk-lda-tagger-lite repository to version specified in the last commit. Note that you can interact with the submodule like any other git repository, and so it is possible to change branch, checkout a commit, etc. which will change the version of the repo available to the parent repo. Running `git status` will advise on the status of the submodule.

More information about submodules is available here: https://git-scm.com/book/en/v2/Git-Tools-Submodules.

### Building from the Dockerfile

Once you have cloned the repository, and initiated the submodules, you can build the image from the local directory with:

```
docker build -t ukgovdatascience/govuk-lda-tagger-image:latest .
```

Note that the `:latest` part can be substituted for another tag (e.g. a version number) for development purposes.
