FROM maven:3.6.0-jdk-8-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

FROM openjdk:8-jre-slim
COPY --from=build /home/app/target/api-gateway-0.0.1-SNAPSHOT.jar /usr/local/lib/api-gateway.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/api-gateway.jar"]