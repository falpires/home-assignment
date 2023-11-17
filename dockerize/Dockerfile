FROM golang:1.21 AS build

WORKDIR /build-app

COPY . ./

ENV CGO_ENABLED=0 GOOS="linux"

RUN go mod init main

RUN go mod tidy

RUN go build -o webserver ./webserver.go
