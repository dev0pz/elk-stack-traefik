#!/bin/bash

sed -i "s/ELASTICSEARCH_HOSTS/${ELASTICSEARCH_HOSTS}/g" /usr/share/logstash/pipeline/logstash.conf
sed -i "s/ELASTICSEARCH_USER/${ELASTICSEARCH_USER}/g" /usr/share/logstash/pipeline/logstash.conf
ELASTICSEARCH_PASSWORD=$(sed 's|/|\\/|g' <<< $ELASTICSEARCH_PASSWORD)
sed -i "s/ELASTICSEARCH_PASSWORD/${ELASTICSEARCH_PASSWORD}/g" /usr/share/logstash/pipeline/logstash.conf
if [ "$STDOUT" = 'true' ]; then
    sed -i "s/STDOUT/stdout { codec => rubydebug }/g" /usr/share/logstash/pipeline/logstash.conf
else
    sed -i "s/STDOUT//g" /usr/share/logstash/pipeline/logstash.conf
fi
if [ "$DROP_NON_JSON" = 'true' ]; then
    sed -i "s/DROP_NON_JSON/else { drop{} }/g" /usr/share/logstash/pipeline/logstash.conf
else
    sed -i "s/DROP_NON_JSON//g" /usr/share/logstash/pipeline/logstash.conf
fi

COUNTER=1
while ! curl -s "$ELASTICSEARCH_HOSTS" >/dev/null; do
    echo -e "Connection to elasticsearch refused"
    sleep 3
    COUNTER=$[$COUNTER +1]
    if [ $COUNTER -gt 20 ]; then
        echo -e "Unable to connect to elasticsearch!"
        exit 1
    fi
done
echo -e "Connection to elasticsearch succeeded"


/usr/local/bin/docker-entrypoint  "$@"
