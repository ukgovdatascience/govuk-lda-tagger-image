FROM ubuntu:14.04

MAINTAINER Matthew Upson
LABEL date="2017-07-26"
LABEL version="0.0.0.9004"
LABEL description="GOVUK LDA tagger image for parallel execution of LDA tagging"

# Update server and install git 

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y git \
    && apt-get install python-dev -y

RUN git clone https://github.com/ukgovdatascience/govuk-lda-tagger-lite.git 

# Set working directory

WORKDIR /govuk-lda-tagger-lite

RUN git checkout v0.0.0.9004

RUN apt-get install python-pip -y
#RUN pip install -r requirements.txt

# Make train_lda executable

COPY ./environment_urltext_100.csv /govuk-lda-tagger-lite/

# RUN chmod +x train_lda.py

#ENTRYPOINT ["./train_lda.py"]

# List Arguments for compilation (might be better as a script)

#CMD ["import", "--experiment", "early_years", "input/early-years.csv"]

