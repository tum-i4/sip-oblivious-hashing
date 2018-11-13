# Running protection 
The recommended way to compile and run our protection is to use Docker container. 

Docker container
--------------------------------------------------
Build a docker image using the provided [DockerFile](https://github.com/tum-i22/sip-oblivious-hashing/tree/acsac/docker).
Run docker container with the following parameters:
```docker run -v /sys/fs/cgroup:/sys/fs/cgroup:rw --security-opt seccomp=unconfined {IMAGEID/IMAGENAME}```


Run experiments
--------------------------------------------------
Visit [```sip-eval```](https://github.com/mr-ma/sip-eval/tree/acsac) project to evaluate OH+SROH and SC protection on with our dataset. 
