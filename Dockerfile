FROM eclipse-temurin:17-jdk-alpine AS build
WORKDIR /opt/app
VOLUME /tmp

COPY .mvn/ .mvn
COPY mvnw pom.xml ./

RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline

COPY src ./src
CMD ["./mvnw", "spring-boot:run"]
RUN ./mvnw clean install

ARG JAR_FILE=/opt/app/target/helloworld-0.0.1-SNAPSHOT.jar
COPY ${JAR_FILE} app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/*.jar"]
