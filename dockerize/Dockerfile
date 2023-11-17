FROM golang:1.21 AS build

WORKDIR /build-app

COPY . ./

ENV CGO_ENABLED=0 GOOS="linux"

RUN go build -o golang ./webserver.go
