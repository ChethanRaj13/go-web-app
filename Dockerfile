<<<<<<< HEAD
# Containerize the go application that we have created
# This is the Dockerfile that we will use to build the image
# and run the container

# Start with a base image
FROM golang:1.21 as base
=======
# Stage 1: Build the Go application
FROM golang:1.22.5 as base
>>>>>>> c20dfaba8f4895bea9b316cb4636374c2d10cb9c

# Set the working directory inside the container
WORKDIR /app

<<<<<<< HEAD
# Copy the go.mod and go.sum files to the working directory
COPY go.mod ./

# Download all the dependencies
RUN go mod download

# Copy the source code to the working directory
COPY . .

# Build the application
RUN go build -o main .

#######################################################
# Reduce the image size using multi-stage builds
# We will use a distroless image to run the application
FROM gcr.io/distroless/base

# Copy the binary from the previous stage
COPY --from=base /app/main .

# Copy the static files from the previous stage
COPY --from=base /app/static ./static

# Expose the port on which the application will run
=======
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
>>>>>>> c20dfaba8f4895bea9b316cb4636374c2d10cb9c
EXPOSE 8080

# Command to run the application
CMD ["./main"]