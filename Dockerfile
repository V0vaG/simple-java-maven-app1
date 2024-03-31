# Use Maven as the base image
FROM maven:openjdk as base

# Pass the build num argument from the workflow to the dockerfile
ARG MAJOR_NUM
ARG MINOR_NUM
ARG PATCH_NUM

# Copy the Maven project into the Docker image
COPY . .

# Run script to set the version number to the pom.xml
RUN bash update_patch.sh $MAJOR_NUM $MINOR_NUM $PATCH_NUM

# Use the same Maven as the base image
FROM base as builder

# Copy the Maven project into the Docker image
COPY --from=base . .

# Run the build
RUN mvn package

# Use Java 17 as the base for the 2nd stage build
FROM openjdk:17-jdk-slim

# Pass the build num argument from the workflow to the dockerfile
ARG MAJOR_NUM
ARG MINOR_NUM
ARG PATCH_NUM

# Copy Artifact .jar file from 1st build
COPY --from=builder /target/myapp-$MAJOR_NUM.$MINOR_NUM.$PATCH_NUM.jar .

# Add new user
RUN adduser vova-kepler

# Set the non-root user as the default user
USER vova-kepler

# Run the .jar file
CMD java -jar *.jar

