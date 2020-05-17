FROM golang:1.11.13-alpine3.10 as builder

RUN apk update && apk add --no-cache git ca-certificates && update-ca-certificates
COPY *.go /src/
COPY go.* /src/
RUN mkdir -p /src/cmd/api
COPY cmd/api/main.go /src/cmd/api
WORKDIR  /src
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -o main ./cmd/api


FROM scratch
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /src/main /
COPY .env  /
CMD ["/main"]
EXPOSE 8080
