FROM alpine

RUN apk add ca-certificates libstdc++ libgcc libc6-compat


ENV USER=docker
ENV UID=1000
ENV GID=1000

RUN addgroup --gid "$GID" "$USER" \
    && adduser \
    --disabled-password \
    --gecos "" \
    --ingroup "$USER" \
    --no-create-home \
    --uid "$UID" \
    "$USER"

WORKDIR /srv/hugo
VOLUME  /srv/hugo

RUN chown -R docker:docker /srv/hugo

ENTRYPOINT [ "/bin/hugo" ]
CMD [ "help" ]
EXPOSE 1313

RUN wget https://github.com/gohugoio/hugo/releases/download/v0.74.3/hugo_extended_0.74.3_Linux-64bit.tar.gz && \
tar zxvpf hugo_extended_0.74.3_Linux-64bit.tar.gz && \
mv hugo /bin/hugo && \
rm hugo_extended_0.74.3_Linux-64bit.tar.gz README.md LICENSE

USER docker