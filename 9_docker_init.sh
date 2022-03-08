#!/usr/bin/env bash
# set -o xtrace

# Limiting available CPUs
# Let's start by finding out how many available processors, that is CPU cores, Java sees without applying any constraints. We can do this by sending the Java statement Runtime.getRuntime().availableprocessors() to the Java CLI tool jshell.
# We will run jshell in a container using the Docker image that contains the full Java 16 JDK. The Docker tag for this image is adoptopenjdk:16. The command looks like:
# Default number of cpu allocated to docker can be configured form Docker > preferences in my case 6
echo 'Runtime.getRuntime().availableProcessors()' | docker run --rm -i adoptopenjdk:16 jshell -q
# Restrict the Docker container to only be allowed to use three CPU cores using the --cpus 3 Docker option, then ask the JVM about how many available processors it sees:
# The JVM now responds with Runtime.getRuntime().availableProcessors()$1 ==> 3, that is, Java SE 16 honors the settings in the container and will, therefore, be able to configure CPU-related resources such as thread pools correctly!
# Default ram allocated to docker container if flag -m or --memory not provided is ( X / 1024^2 ) MB = 256m
echo 'Runtime.getRuntime().availableProcessors()' | docker run --rm -i --cpus=3 adoptopenjdk:16 jshell -q

# Limiting available memory
# Let's ask the JVM for the maximum size that it thinks it can allocate for the heap.
# We can achieve this by asking the JVM for extra runtime information using the -XX:+PrintFlagsFinal Java option and then using the grep command to filter out the MaxHeapSize parameter.
#echo 'Runtime.getRuntime().maxMemory()' | docker run --rm -i adoptopenjdk:16 jshell -q
# Default ram allocated to docker container if flag -m or --memory not provided is 256m
docker run -it --rm adoptopenjdk:16 java -XX:+PrintFlagsFinal | grep "size_t MaxHeapSize"

# Constrain the Docker container to only use up to 1 GB of memory using the Docker option -m=1024M,
# we expect to see a lower max memory allocation.
# Will result in the response 268,435,456 bytes, which equals 268,435,456 / 10242 = 256 MB. 256 MB is one-quarter of 1 GB, so again, this is as expected.
docker run -it --rm -m=1024M adoptopenjdk:16 java -XX:+PrintFlagsFinal | grep "size_t MaxHeapSize"

# if we want to allow the JVM to use 600 MB of the total 1 GB we have for its heap, we can specify that using the JVM option -Xmx600m like:
docker run -it --rm -m=1024M adoptopenjdk:16 java -Xmx600m -XX:+PrintFlagsFinal -version | grep "size_t MaxHeapSize"

#Let's conclude with an "out of memory" test to ensure that this really works!
#We'll allocate some memory using jshell in a JVM that runs in a container that has been given 1 GB of memory; that is, it has a max heap size of 256 MB.
#First, try to allocate a byte array of 100 MB:
#The command will respond with $1 == X where ( X / 1024^2 ) MB
echo 'new byte[100_000_000]' | docker run -i --rm -m=1024M adoptopenjdk:16 jshell -q


#Now, let's try to allocate a byte array that is larger than the max heap size,
#Exception java.lang.OutOfMemoryError: Java heap space. Great!
echo 'new byte[500_000_000]' | docker run -i --rm -m=1024M adoptopenjdk:16 jshell -q