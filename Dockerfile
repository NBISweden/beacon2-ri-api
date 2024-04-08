##########################
## Build env
##########################

# FROM python:3.12-slim-bookworm AS BUILD
FROM python:3.11-slim-bookworm as build
ENV DEBIAN_FRONTEND noninteractive

# python packages
COPY requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip && pip install --no-cache-dir -r /tmp/requirements.txt

##########################
## Beacon
##########################
FROM gcr.io/distroless/python3-debian12:debug as debug
WORKDIR /beacon
COPY permissions /beacon/permissions
COPY beacon      /beacon/beacon
COPY ui          /beacon/ui
COPY --from=0 /usr/local/lib/python3.11/site-packages /beacon/lib/python3.11/site-packages
USER 65534
ENV PYTHONPATH=/beacon/lib/python3.11/site-packages

ENTRYPOINT ["python","-m","beacon"]


FROM gcr.io/distroless/python3-debian12 as production
WORKDIR /beacon
COPY permissions /beacon/permissions
COPY beacon      /beacon/beacon
COPY ui          /beacon/ui
COPY --from=0 /usr/local/lib/python3.11/site-packages /beacon/lib/python3.11/site-packages
USER 65534
ENV PYTHONPATH=/beacon/lib/python3.11/site-packages

ENTRYPOINT ["python","-m","beacon"]
