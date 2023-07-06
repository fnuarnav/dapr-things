FROM golang 
WORKDIR /workspace
COPY src/go.mod go.mod
COPY src/go.sum go.sum
COPY src/app.go app.go

RUN go build .


