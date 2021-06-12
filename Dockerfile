FROM golang:1.16.5-alpine3.13@sha256:5043256adf5a5001e05c591815e988090decd5940ccbcc642f13787364eadb88 as builder

RUN apk update \
    && apk add --no-cache \
      git \
      ca-certificates \
    && update-ca-certificates

ENV USER=user
ENV UID=10001

RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \  
    "${USER}"

WORKDIR $GOPATH/src/crawler
COPY . .

RUN go mod download
RUN go mod verify

RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /usr/local/bin/crawler

FROM scratch

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group

COPY --from=builder /usr/local/bin/crawler /usr/local/bin/crawler

USER ${UID}

ENTRYPOINT ["/usr/local/bin/crawler"]
