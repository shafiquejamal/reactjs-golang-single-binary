# syntax=docker/dockerfile:1

FROM golang:1.17.1-alpine3.14

WORKDIR /application

COPY go.mod ./
COPY go.sum ./

RUN go mod download

COPY main.go ./
COPY app ./app

RUN apk --no-cache add nodejs yarn --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community && cd app && yarn build && cd .. && \
    CGO_ENABLED=0 go build -ldflags "-w" -a -o react-go . && \
    go install github.com/GeertJohan/go.rice/rice && \
    rice append -i . --exec react-go

EXPOSE 8080    

CMD ["./react-go"]