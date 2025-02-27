# Dockerfile for Spring Boot application
FROM eclipse-temurin:17-jdk-alpine

# Set working directory
WORKDIR /app

# Copy Maven build files and source code
COPY pom.xml /app/
COPY src /app/src

# Build the application
RUN apk add --no-cache maven && \
    mvn -f /app/pom.xml clean package -DskipTests

# Copy built JAR file
COPY target/kinder-app-1.0.0.jar /app/kinder-app.jar

# Expose application port
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "/app/kinder-app.jar"]


