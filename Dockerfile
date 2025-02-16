# Stage 1: Build the Go application
FROM golang:1.22.5 as base

# Set the working directory inside the container
WORKDIR /app

# Copy the Go module files
COPY go.mod .

# Download dependencies
RUN go mod download

# Copy the rest of the application source code
COPY . .

RUN go build -o main . 

# Stage 2: Create a minimal runtime image
FROM gcr.io/distroless/base

# Copy the compiled binary from the builder stage
COPY --from=base /app/main .

COPY --from=base /app/static ./static

# Expose the port the app runs on
EXPOSE 8080

# Command to run the application
CMD ["./main"]