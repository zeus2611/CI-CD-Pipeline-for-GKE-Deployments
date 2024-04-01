FROM golang:1.16

# Add a non-root user
RUN useradd -u 1000 -ms  /bin/bash app
RUN mkdir -p /go/src/app && chown -R app:app /go/src/app
USER app

# Cache dependencies
WORKDIR /go/src/app
COPY go.* ./
RUN go mod download

ENV GOTRACEBACK=all
ARG SKAFFOLD_GO_GCFLAGS
# Copy in source files
COPY *.go *.html ./
RUN go build -gcflags="${SKAFFOLD_GO_GCFLAGS}" -o app
CMD ["/go/src/app/app"]
COPY k8s k8s
