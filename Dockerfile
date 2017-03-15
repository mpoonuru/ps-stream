FROM ucalgary/python-librdkafka:3.6.0-0.9.4

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app
RUN apk add --no-cache --virtual .build-deps \
      gcc \
      git \
      musl-dev && \
    pip install -r requirements.txt && \
    apk del .build-deps

COPY setup.py /usr/src/app
COPY ps_stream /usr/src/app/ps_stream
RUN python setup.py install

ENTRYPOINT ["/usr/local/bin/ps-stream"]
CMD ["--help"]

LABEL maintainer="King Chung Huang <kchuang@ucalgary.ca>" \
      org.label-schema.vcs-url="https://github.com/ucalgary/ps-stream"
