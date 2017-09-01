# Getting LDA started using the databox

1. Run the insructions in the [https://github.com/ukgovdatascience/databox](https://github.com/ukgovdatascience/databox) folder to set up your databox with docker.
2. Get the docker image with: `docker pull ukgovdatascience/govuk-lda-tagger-image`.
3. Run `git clone https://www.github.com/ukgovdatascience/govuk-lda-tagger-image` to get a copy of the input data.

## Run the tests

```
pip install pytest

pytest
```

## Fixing problems with the docker container

You may need to gain access to the docker container itself for dbugging purposes. This can be achieved with:

```
docker run -i -t ukgovdatascience/govuk-uk-lda-tagger-image /bin/bash
```

This will open a bash shell to the container.
