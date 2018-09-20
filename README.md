# Run using within a docker container
Build a docker image using the provided [DockerFile](https://github.com/tum-i22/sip-oblivious-hashing/tree/acsac/docker).
Run docker container with the following parameters:
 ``docker run -v /sys/fs/cgroup:/sys/fs/cgroup:rw --security-opt seccomp=unconfined {IMAGEID/IMAGENAME}``

