# Introduction

This project shows how to:
- create a front-end React Js app and a back-end Go app and package into a single binary
- Dockerize the combined applications
- Use docker-compose to run the application, so that you can run mulitple applications on EC2

# References:

- https://levelup.gitconnected.com/combine-a-react-js-and-go-app-into-a-single-binary-file-1260a109dd90

## Example

- https://github.com/shafiquejamal/reactjs-golang-example


## Steps

### Create the Go binary

1. Create a project directory, e.g. `my-project`, and `cd` into it.
2. Run `nnpx create-react-app app --template typescript`. Optionally, you can replace the `app/src/App.tsx` file with the `App.tsx` in this repository, and copy `./ping/Ping.tsx` from this repository into your `app/src/` directory.
3. `cd` into the `./app` directory.
4. Run `yarn add axios` if you copied the Ping files over. In any case, run `yarn build`.
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

### Create the Dockerfile

13. Use the Dockerfile in this project. Optionally, you can build the image. The command could be something like:
```
sudo docker build -t foo/react-go:0.0.1 .
```
14. Optionally, test by running a container using the image, and navigating to localhost:3021 in the browser:
```
sudo docker run foo/react-go:0.0.1 --name my-react-go -p 3012:8080
```
15. Stop and remove the container, and then remove the image.

### Create the docker-compose.yml file

16. Use the `docker-compose.yml` file in this project. 
17. You can run `docker-compose up -d --build` to run the application, and test by navigating to the browser as before.

### Make the application a Systemd service

TODO

### Create an Nginx service using a docker container to forward requests to the above service, and make this a Systemd service also

TODO
