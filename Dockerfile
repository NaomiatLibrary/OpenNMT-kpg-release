#FROM pytorch/pytorch:latest
FROM python:3.8
#RUN git clone https://github.com/OpenNMT/OpenNMT-py.git && cd OpenNMT-py && pip install -r requirements.txt && python setup.py install
WORKDIR /usr/src/app

COPY ./requirements.txt ./
COPY ./requirements.opt.txt ./
COPY ./setup.py ./

RUN apt update
RUN apt-get install -y tzdata
RUN  apt-get install -y libsqlite3-dev libbz2-dev libncurses5-dev libgdbm-dev liblzma-dev libssl-dev tcl-dev tk-dev libreadline-dev git cmake\
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ENV PYTHONUNBUFFERED 1
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir -r requirements.opt.txt
COPY ./README.md ./
RUN python setup.py install

CMD bash
