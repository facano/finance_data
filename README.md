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

y añade a este archivo la API Key para consumir la API de la SBIF en la variable `SBIF_KEY`

### Iniciar los servicios

```
docker-compose up
```

### TODO
* Detalles en gráficos (leyendas, estilos, etc)
* Persistencia de data, para evitar consultas constantes a API
* Autenticación con User y Pass (para evitar usos no autorizados de la API)
* Testing
