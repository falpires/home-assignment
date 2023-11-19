FROM golang:1.21 AS build

WORKDIR /usr/local/go/src/dockerize/

COPY . ./

ENV CGO_ENABLED=0 GOOS="linux"

RUN go build -o /usr/local/go/src/dockerize/golang ./webserver.go

FROM scratch AS final

LABEL maintainer="falpires"
COPY --from=build /usr/local/go/src/dockerize/golang ./golang
COPY ./src ./src

ENTRYPOINT ["./golang"]