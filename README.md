# Finance Data
## Descripción
Aplicación que prueba la conexión a la API de la SBIF http://api.sbif.cl/, preguntando por indicadores asociados a UF, Dolar y TCM para un período de tiempo arbitrario.

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
* Persistencia de data, para evitar consultas constantes a API
* Autenticación con User y Pass (para evitar usos no autorizados de la API)
* Mejorar usabilidad
* Testing
