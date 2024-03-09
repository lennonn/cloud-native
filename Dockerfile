# Use a base image with JDK 17 installed
FROM openjdk:17-jdk

# 作者
MAINTAINER zlennon@163.com


# Set the working directory in the container
WORKDIR /app

# Copy the JAR file of your Spring Boot application into the container
COPY target/springboot-k8s.jar /app/springboot-k8s.jar

# Expose the port your Spring Boot application runs on
EXPOSE 8080

# Define the command to run your application using java -jar
CMD ["java", "-jar", "springboot-k8s.jar"]
