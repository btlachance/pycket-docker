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

To expose the resulting benchmark data to your host, here's the flag I
had to add to the above command (at least for the macOS version of
docker)

``-v /tmp/pycket-data:/pycket-bench/output``

But heads up: since the path in the container (i.e. the second path)
already exists, the contents the path on the host (the first path)
will be what's visible inside the container. The original files at the
path in the container aren't gone, they're just inaccessible.
