# Tag GOV.UK content using LDA in a docker container 

Tag GOV.UK content with topics generated using Latent Dirichlet Allocation ([govuk-lda-tagger-lite](https://github.com/ukgovdatascience/govuk-lda-tagger-lite)) in a [Docker](https://www.docker.com) container. 

## Getting started

### Automatic build

The easiest way to get started with this image is to run the following command from a terminal (ensuring that docker is installed):

```

#!/bin/bash

docker run -i --rm -v ${PWD}/output:/mnt/output \
    -v ${PWD}/experiments:/mnt/experiments \
    ukgovdatascience/govuk-lda-tagger-image:latest python train_lda.py \
    --output-topics /mnt/output/topics.csv \
    --output-tags /mnt/output/tags.csv \
    --vis-filename /mnt/output/vis.html \
    --numtopics 7 \
    --passes 1 \
    import input/url_text.csv

```

This will download the pre-built container from [DockerHub](https://hub.docker.com/r/ukgovdatascience/govuk-lda-tagger-image/), and run and test based on data included in the [govuk-lda-tagger-lite](https://github.com/ukgovdatascience/govuk-lda-tagger-lite) repository.

Output files and experiment data will be produced in new directories called `./output/` and `./experiments` respectively, so ensure that you run the command from a working directory.

To run the container on real data, a mount point can be set up to access local files, for example:

```
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
```

New data files can then be added to the local `./input` folder, and can be found in the container at `/mnt/input`.

### Testing

Tests that the container will produces the expected output can be run from the project root with the command `pytest`.

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

## Running on a databox

1. Run the insructions in the [https://github.com/ukgovdatascience/databox](https://github.com/ukgovdatascience/databox) folder to set up your databox with docker.
2. Run `git clone https://www.github.com/ukgovdatascience/govuk-lda-tagger-image %%%% cd govuk-lda-tagger-image` to get a copy of the input data and to navigate to that folder.
3. Run `./run.sh` to run a test script.
4. Note that you can also build the image locally (rather than pulling it docker hub) with the following commands:
    * Initialise and update the submodule from the govuk-lda-tagger-image directory: `git submodule init && git submodule update`.
    * Build the image locally from instructions in the Dockerfile: `docker build -t ukgovdatascience/govuk-lda-tagger-image:latest .`

### Run the tests

If you want to verify that the docker contaien ris working as expected, you can run the tests which are written in python with pytest. Note that this contains a `docker run` command, so will pull the image from docker hub if it is not available locally.

```
# Install pytest with pip

sudo apt install python-pip
pip install pytest

# Run tests

cd /home/ubuntu/govuk-lda-tagger-image/
sudo python -m pytest
```

Note the need to call pytest with sudo, to enable the removal of test files.

### Fixing problems with the docker container

You may need to gain access to the docker container itself for dbugging purposes. This can be achieved with:

```
docker run -i -t ukgovdatascience/govuk-uk-lda-tagger-image /bin/bash
```

This will open a bash shell to the container.
