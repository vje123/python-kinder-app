FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY kinder-app.jar /app/kinder-app.jar
CMD ["java", "-jar", "/app/kinder-app.jar"]