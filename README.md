# pycket-docker

In the beginning, there were tests. To build pycket and run its tests,
clone this repository and build the image specified by the Dockerfile
inside.

```
git clone github.cs.tufts.edu:blachanc/pycket-docker
docker build pycket-docker
```

For now, this just verifies that I can build and run pycket inside a
container. At some point, it might be useful to be able to feed racket
files pycket via `docker run`.