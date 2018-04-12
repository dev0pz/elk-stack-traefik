FROM docker.elastic.co/logstash/logstash:6.2.3
MAINTAINER devopz <el.mapreducer@email.com>

ENTRYPOINT ["/usr/share/logstash/run.sh"]
EXPOSE 5000/tcp 5000/udp
ENV LOGSPOUT ignore
ENV ELASTICSEARCH_HOSTS elasticsearch:9200
ENV ELASTICSEARCH_USER logstash_system
ENV ELASTICSEARCH_PASSWORD changeme

ADD logstash.conf /usr/share/logstash/pipeline/logstash.conf
ADD run.sh /usr/share/logstash/run.sh

