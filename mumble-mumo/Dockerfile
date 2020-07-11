FROM python:2

RUN apt-get update && \
    apt-get install -y git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --no-cache-dir zeroc-ice

COPY entrypoint.sh /entrypoint.sh
RUN git clone https://github.com/mumble-voip/mumo.git /mumo && \
    chmod +x /entrypoint.sh && \
    ln -sf /dev/stdout /mumo/mumo.log

VOLUME ["/data"]


WORKDIR /mumo
ENTRYPOINT [ "/entrypoint.sh" ]

CMD ["/mumo/mumo.py", "--ini", "/data/mumo.ini"]
