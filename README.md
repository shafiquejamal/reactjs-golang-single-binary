# Introduction

This project shows how to:
- create a front-end React Js app and a back-end Go app and package into a single binary
- Dockerize the combined applications
- Use docker-compose to run the application, so that you can run mulitple applications on EC2

References:

- https://levelup.gitconnected.com/combine-a-react-js-and-go-app-into-a-single-binary-file-1260a109dd90

## Steps

### Create the Go binary

1. Create a project directory, e.g. `my-project`, and `cd` into it.
2. Run `nnpx create-react-app app --template typescript`
3. `cd` into the `./app` directory.
4. Run `yarn build`.
5. `cd` back into the `my-project` directory.
6. Copy the `main.go` file from the above link into this directory (it is also [here](https://gist.githubusercontent.com/chanioxaris/e0eff65c0d87862801a74fffc17fae99/raw/87ccf5e1bc907d65dd72e7feafb3445c8bfb47f0/golang-react-binary-main.go)). 
7. In this directory, run 
```
go mod init [your module name goes here]
go get github.com/GeertJohan/go.rice
go mod tidy 
```
8. Run `CGO_ENABLED=0 go build -ldflags "-w" -a -o react-go .` to build the binary file.
9. Install rice: `go install github.com/GeertJohan/go.rice/rice`.
10. At this point the `rice` executable should be on your path. Run `$ rice append -i . --exec react-go` to embed the build folder into the binary.
11. Test that the binary works by running `./react-go`. The app shoud run on port 8080. 
12. Type Ctrl+c to stop the app. 

### Crate the Dockerfile

### Build the Docker image

### Create the docker-compose.yml file

