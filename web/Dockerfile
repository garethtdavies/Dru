FROM python:3.7

COPY requirements.txt ./

RUN pip install --no-cache-dir -r /requirements.txt

WORKDIR /app

# Server
EXPOSE 8000
STOPSIGNAL SIGINT
CMD ["bash", "start.sh"]