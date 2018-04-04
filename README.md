# pycket-docker

## Getting started

To build a pycket binary, clone this repository and build the image
specified by the Dockerfile inside.

```
git clone github.cs.tufts.edu:blachanc/pycket-docker
docker build pycket-docker
```

With the base Docker image already on my machine, building takes
upward of 30 minutes on my moderately-powered laptop.

## Running benchmarks

When running benchmarks, the ReBench tool tries to use `nice` on
programs it measures. Running an image that uses ReBench then needs
the `SYS_NICE` capability. If you built the image and tagged it as
`pycket-bench`, passing the `--cap-add=SYS_NICE` flag as below lets
ReBench do its job:

```
docker run --cap-add=SYS_NICE -it pycket-bench
```
