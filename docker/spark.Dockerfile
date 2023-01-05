FROM datamechanics/spark:3.2.1-latest

ENV PYSPARK_MAJOR_PYTHON_VERSION=3

WORKDIR /opt/app

# RUN wget  https://jdbc.postgresql.org/download/postgresql-42.2.5.jar
# RUN mv postgresql-42.2.5.jar /opt/spark/jars

# Install dependencies
COPY src/requirements.txt .
RUN pip3 install -r requirements.txt

COPY src/main.py .
