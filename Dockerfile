FROM eclipse-temurin:17-jdk-alpine
WORKDIR /opt/app
VOLUME /tmp

COPY .mvn/ .mvn
COPY mvnw pom.xml ./

RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline

COPY ./src ./src
RUN ./mvnw clean install

CMD ["./mvnw", "spring-boot:run"]

ARG JAR_FILE=/opt/app/target/*.jar
COPY --from=builder /opt/app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","opt/app/*.jar"]
