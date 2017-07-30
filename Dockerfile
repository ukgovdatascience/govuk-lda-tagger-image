FROM python:2.7

MAINTAINER Matthew Upson
LABEL date="2017-07-30"
LABEL version="0.0.0.9012"
LABEL description="GOVUK LDA tagger image for parallel execution of LDA tagging"

# Update server and install git 

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y git

COPY ./govuk-lda-tagger-lite govuk-lda-tagger-lite

# Set working directory

WORKDIR /govuk-lda-tagger-lite

# Install python requirements

RUN pip install -r requirements.txt

# Copy in input data 

COPY ./bigrams.csv /govuk-lda-tager-lite/input/
COPY ./environment_urltext_100.csv /govuk-lda-tagger-lite/input/

RUN ./run.sh
#
##ENTRYPOINT ["./train_lda.py"]
#
## List Arguments for compilation (might be better as a script)
#
##CMD ["import", "--experiment", "early_years", "input/early-years.csv"]
#
#
