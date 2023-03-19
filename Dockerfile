FROM eclipse-temurin:17-jdk-alpine AS build
WORKDIR /opt/app
VOLUME /tmp

COPY .mvn/ ./
COPY mvnw pom.xml ./

RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline

COPY ./src ./
RUN ./mvnw clean install

ARG JAR_FILE=./opt/app/target/*.jar
COPY ${JAR_FILE} app.jar
EXPOSE 8080
CMD ["./mvnw", "spring-boot:run"]
ENTRYPOINT ["java","-jar","opt/app/*.jar"]
