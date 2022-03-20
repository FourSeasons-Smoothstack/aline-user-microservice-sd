FROM openjdk:8-alpine
EXPOSE 8070
WORKDIR /app
COPY ./user-microservice/target/*.jar /app/application.jar
ENTRYPOINT ["java", "-jar", "application.jar"]