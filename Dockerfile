FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY kinder-app-1.0.1-SNAPSHOT.jar /app/kinder-app.jar
CMD ["java", "-jar", "/app/kinder-app.jar"]