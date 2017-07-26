FROM ubuntu:14.04

MAINTAINER Matthew Upson
LABEL date="2017-07-26"
LABEL version="0.0.0.9001"
LABEL description="GOVUK LDA tagger image for parallel execution of LDA tagging"

# Update server and install git 

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y git 

RUN git clone https://github.com/ukgovdatascience/govuk-lda-tagger.git 

# Set working directory

WORKDIR /govuk-lda-tagger

RUN git pull --tags \
    && git checkout v0.0.0.9001

RUN apt-get install python-pip -y
RUN pip install -r requirements.txt

RUN git pull --tags \
    && git checkout v0.0.0.9000

# Make train_lda executable

COPY ./environment_urltext_100.csv /govuk-lda-tagger/

# RUN chmod +x train_lda.py

#ENTRYPOINT ["./train_lda.py"]

# List Arguments for compilation (might be better as a script)

#CMD ["import", "--experiment", "early_years", "input/early-years.csv"]

