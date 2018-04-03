# Finance Data

## Instalación

### Crear volumen para almacenar las gems instaladas

```
docker volume create --name finance_gems
```


### Build de los distintos containers

```
docker-compose build
```

### Bundle Install

```
docker-compose run app bundle install
```

### Crear y migrar base de datos

```
docker-compose run app rails db:create
docker-compose run app rails db:migrate
docker-compose run app rails db:seed
```


### Crear archivo .env desde .env.example

```
cp .env.example .env
```

y añade la API Key para consumir la API de la SBIF en la variable `SBIF_KEY`

### Iniciar los servicios

```
docker-compose up
```
