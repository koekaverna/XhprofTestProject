# XhprofTestProject
There is **502 Bad gateway** problem only when `php-profiler` flush enabled `$profiler->start(true)` with `xhprof` extension.  
This problem only with `xhprof` and `tideways_xhprof` works fine.

## Setup
```bash
docker-compose up -d --build

cd symfony
docker-compose exec php composer install
docker-compose exec php bin/console doctrine:database:create --no-interaction
```

## Testing with apache benchmark
Install `apache2-utils` if not installed
```bash
ab -v 2 -n 50 -T application/json http://127.0.0.3/
```

Output:
```
Complete requests:      50
Failed requests:        23
```
