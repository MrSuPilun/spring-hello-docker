FROM eclipse-temurin:17-jdk-alpine
WORKDIR /opt/app
VOLUME /tmp

COPY .mvn/ .mvn
COPY mvnw pom.xml ./

RUN./mvnw dependency:resolve

COPY ./src ./src
RUN ./mvnw clean install

CMD ["./mvnw", "spring-boot:run"]

ARG JAR_FILE=target/helloworld-0.0.1-SNAPSHOT.jar
COPY ${JAR_FILE} app.jar
EXPOSE=8080
ENTRYPOINT ["java","-jar","/app.jar"]
