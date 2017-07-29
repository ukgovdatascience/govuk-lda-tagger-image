FROM ubuntu:14.04

MAINTAINER Matthew Upson
LABEL date="2017-07-28"
LABEL version="0.0.0.9007"
LABEL description="GOVUK LDA tagger image for parallel execution of LDA tagging"

# Update server and install git 

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y git


# Split these apart for now to speed up development

RUN apt-get install -y python3 \
    python3-dev \
    python3-pip \
    python3-setuptools
#RUN apt-get install -y python-numpy
#RUN apt-get install -y python-scipy
#RUN apt-get install -y python-tk
#RUN apt-get install -y libxml2
RUN apt-get install -y libxslt1.1 libxslt1-dev
RUN apt-get install build-essential checkinstall -y
RUN apt-get install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev -y
RUN apt-get install libxml2-dev libxslt1-dev -y
#RUN apt-get install build-essential autoconf libtool pkg-config python-opengl python-imaging python-pyrex python-pyside.qtopengl idle-python2.7 qt4-dev-tools qt4-designer libqtgui4 libqtcore4 libqt4-xml libqt4-test libqt4-script libqt4-network libqt4-dbus python-qt4 python-qt4-gl libgle3 python-dev libssl-dev -y
RUN apt-get install gfortran -y
RUN apt-get install gcc-4.6-base cpp-4.6 libgomp1 libquadmath0 libc6-dev -y
RUN apt-get install libffi-dev libffi6 -y
RUN apt-get autoremove
RUN apt-get clean

COPY ./govuk-lda-tagger-lite govuk-lda-tagger-lite
#RUN git clone https://github.com/ukgovdatascience/govuk-lda-tagger-lite.git 

# Set working directory

WORKDIR /govuk-lda-tagger-lite

# Allow the first attempt at installing requirements to fail

RUN echo python --version
RUN pip3 install -r requirements.txt || true

# Then try again

RUN pip3 install -r requirements.txt

# Make train_lda executable

COPY ./environment_urltext_100.csv /govuk-lda-tagger-lite/
COPY ./run.sh /govuk-lda-tagger-lite/

# RUN chmod +x train_lda.py

#ENTRYPOINT ["./train_lda.py"]

# List Arguments for compilation (might be better as a script)

#CMD ["import", "--experiment", "early_years", "input/early-years.csv"]


