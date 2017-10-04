FROM python:2

LABEL maintainer=jch@honig.net

ENV DEBIAN_FRONTEND noninteractive
ENV TTNCTL ttnctl-linux-amd64

WORKDIR /usr/src/app

COPY requirements.txt bin/monitor ./

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get -qq update \
    && apt-get install -qq -y unzip \
    && rm -rf /var/lib/apt/lists/* \
    && pip -q install --no-cache-dir -r requirements.txt \
    && curl -s -o $TTNCTL.zip "https://ttnreleases.blob.core.windows.net/release/master/$TTNCTL.zip" \
    && unzip -q $TTNCTL.zip \
    && rm $TTNCTL.zip \
    && chmod 755 $TTNCTL \
    && useradd -U -r -l ttn

USER ttn:ttn

VOLUME [ "/data" ]
CMD [ "./monitor", "-d", "--test", "--statusdb=/data/monitor-status.db" ]
