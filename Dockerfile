# STAGE 1: The Build Environment (The "Heavy" Workshop)
FROM eclipse-temurin:21-jdk-jammy AS build
WORKDIR /app

# Copy and compile
COPY src/main/Application.java ./main/
RUN javac main/Application.java

# STAGE 2: The Runtime Environment (The "Tiny" Delivery Van)
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

# We reach back into the "build" stage and grab ONLY the compiled .class file
COPY --from=build /app/main/Application.class ./main/

# This image doesn't have a compiler, just the Java runner
CMD ["java", "main.Application"]