FROM python:3.9.1

RUN pip install pandas sqlalchemy pyarrow psycopg2-binary
RUN apt-get install wget

WORKDIR / app

COPY ingest.py ingest.py
ENTRYPOINT [ "python", "ingest.py" ]