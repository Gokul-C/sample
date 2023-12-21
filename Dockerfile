FROM adoptopenjdk/openjdk8:alpine-slim
EXPOSE 8080
ARG JAR_FILE=target/*.jar
RUN addgroup -S devsecops && adduser -S gokul -G devsecops
COPY ${JAR_FILE} /home/k8s-pipeline/app.jar
USER gokul
ENTRYPOINT ["java","-jar","/home/k8s-pipeline/app.jar"]
