# ELK stack with Traefik

## Deploy the ELK stack ready to consume json logs from Traefik 

##### Working Example (with geolocated remote IPs via GeoIP fields)

<br />
##tl;dr :

`$ docker network create -d overlay --attachable my_log_net`

or:

`$ docker network create --opt encrypted --driver overlay --attachable my_log_net`

and then:

`$ docker stack deploy --compose-file=docker-compose.yml elk`



<br />


##### notes:
[Logstash Image at DockHub](https://hub.docker.com/r/devopz/logstash-json-traefik/)

---
<br />
**Traefik:**

[Docs about Traefik, here.](https://docs.traefik.io)


Example: 

`$ touch acme.json ; chmod 0600 acme.json`

<br />

`$ docker run -d -v /var/run/docker.sock:/var/run/docker.sock -v $PWD/traefik.toml:/traefik.toml -v $PWD/acme.json:/acme.json -p 80:80 -p 443:443 --network my_log_net --name traefik traefik --docker`


<br />

> (use `--network my_log_net` for your traefik backends)

<br />

then make a safe ssh tunnel to Kibana:

`$ ssh -L 5601:localhost:5601 user@<swarm manager host>`

open [http://localhost:5601](http://localhost:5601)


