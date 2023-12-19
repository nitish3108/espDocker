FROM espressif/idf

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing \
	vim 

WORKDIR /opt/esp/idf
ENTRYPOINT ["sleep", "infinity"]
