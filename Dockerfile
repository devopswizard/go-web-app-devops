FROM golang:1.21 as base

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o main .

# Create a distroless image
FROM gcr.io/distroless/base

WORKDIR /app

COPY --from=base /app/main .
COPY --from=base /app/static ./static

EXPOSE 8080

CMD [ "/app/main" ]