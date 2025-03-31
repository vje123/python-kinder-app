FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# COPY pom.xml /app/
# COPY src /app/src

# RUN apk add --no-cache maven && \
#     mvn -f /app/pom.xml clean package -DskipTests


COPY target/kinder-app-1.0.1.jar /app/kinder-app.jar


EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/kinder-app.jar"]


