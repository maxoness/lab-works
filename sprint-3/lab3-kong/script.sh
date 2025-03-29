docker run -d --name kong-database   --network=kong-net   -p 5432:5432   -e "POSTGRES_USER=kong"   -e "POSTGRES_DB=kong"   -e "POSTGRES_PASSWORD=kongpass"   postgres:13

docker run --rm --network=kong-net  -e "KONG_DATABASE=postgres"  -e "KONG_PG_HOST=kong-database"  -e "KONG_PG_PASSWORD=kongpass"  -e "KONG_PASSWORD=test" kong/kong-gateway:3.10.0.0 kong migrations bootstrap

docker run -d --name kong-gateway  --network=kong-net  -e "KONG_DATABASE=postgres"  -e "KONG_PG_HOST=kong-database"  -e "KONG_PG_USER=kong"  -e "KONG_PG_PASSWORD=kongpass"  -e "KONG_PROXY_ACCESS_LOG=/dev/stdout"  -e "KONG_ADMIN_ACCESS_LOG=/dev/stdout"  -e "KONG_PROXY_ERROR_LOG=/dev/stderr"  -e "KONG_ADMIN_ERROR_LOG=/dev/stderr"  -e "KONG_ADMIN_LISTEN=0.0.0.0:8001"  -e "KONG_ADMIN_GUI_URL=http://localhost:8002"  -e KONG_LICENSE_DATA  -p 8000:8000  -p 8443:8443  -p 8001:8001  -p 8444:8444  -p 8002:8002  -p 8445:8445  -p 8003:8003  -p 8004:8004  kong/kong-gateway:3.10.0.0

curl -i -X POST   --url http://localhost:8001/services/   --data 'name=weather-service'   --data 'url=http://weather-service:8000'

curl -i -X POST   --url http://localhost:8001/services/weather-service/routes   --data 'paths[]=/weather'

curl -i http://localhost:8000/weather

#



curl -X POST http://localhost:8001/consumers/303a9b34-fee7-4df8-afec-3fc02be62dd1/oauth2 \
  --data "name=Test%20Application" \
  --data "client_id=SOME-CLIENT-ID" \
  --data "client_secret=SOME-CLIENT-SECRET" \
  --data "redirect_uris=http://some-domain/endpoint/" \
  --data "hash_secret=true"
  
  
curl -i -X POST \
--url http://localhost:8001/consumers/303a9b34-fee7-4df8-afec-3fc02be62dd1/oauth2 \
--data 'name=weather-app' \
--data 'client_id=weather-client-id' \
--data 'client_secret=weather-client-secret' \
--data 'redirect_uris=http://localhost/callback'