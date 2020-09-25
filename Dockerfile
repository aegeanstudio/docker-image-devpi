FROM python:3.8.6
LABEL maintainer='M@gicAgCl(DEAD) <wyqsmith@aegeanstudio.com>'

ENV PYTHONUNBUFFERED=true \
    DEVPI_INIT_CONFIGFILE=None \
    DEVPI_INIT_ROLE=auto \
    DEVPI_INIT_MASTER_URL=None \
    DEVPI_INIT_SERVERDIR=/root/.devpi/server \
    DEVPI_INIT_STORAGE=None \
    DEVPI_INIT_KEYFS_CACHE_SIZE=16384 \
    DEVPI_INIT_NO_ROOT_PYPI=False \
    DEVPI_INIT_ROOT_PASSWD='' \
    DEVPI_INIT_ROOT_PASSWD_HASH=None

COPY requirements.txt /root/requirements.txt
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /root/.
RUN pip install -r requirements.txt

EXPOSE 3141/tcp
HEALTHCHECK --interval=60s CMD ["curl", "-s", "-o", "/dev/null", "http://127.0.0.1:3141/+status" ]
ENTRYPOINT ["/entrypoint.sh"]
CMD ["devpi-server", "--host", "0.0.0.0", "--request-timeout", "30"]
