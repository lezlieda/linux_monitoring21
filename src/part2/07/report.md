## Part 7. **Prometheus** и **Grafana**

### 7.1. **Prometheus**

Скачиваем последнюю версию Prometheus с github.com/prometheus/prometheus/releases

![](img/01.JPG)(prometheus_download)

Распаковываем архив:

![](img/02.JPG)(prometheus_unpack)

Копируем распакованные файлы на устройство:

![](img/03.JPG)(prometheus_copy)

Создаём системного пользователя prometheus без домашней папки и без логина, и меняем владельца файлов на него:

![](img/04.JPG)(prometheus_user)

Поскольку, мы будем использовать **systemd**, то создаём файл конфигурации **prometheus.service** в директории **/etc/systemd/system**:

![](img/05.JPG)(prometheus_service)

Теперь можно запустить **Prometheus**:

![](img/06.JPG)(prometheus_start)

Проверяем, что **Prometheus** запустился:

![](img/07.JPG)(prometheus_check)

### 7.2. **Node exporter**

Скачиваем последнюю версию Node exporter с github.com/prometheus/node_exporter/releases

![](img/08.JPG)(node_exporter_download)

Распаковываем архив:

![](img/09.JPG)(node_exporter_unpack)

Копируем распакованные файлы на устройство:

![](img/11.JPG)(node_exporter_copy)

Создаём системного пользователя node_exporter без домашней папки и без логина, и меняем владельца файлов на него:

![](img/100.jpg)(node_exporter_user)

Поскольку, мы будем использовать **systemd**, то создаём файл конфигурации **node_exporter.service** в директории **/etc/systemd/system**:

![](img/10.JPG)(node_exporter_service)

Теперь можно запустить **Node exporter**:

![](img/12.JPG)(node_exporter_start)

Необходимо создать статическую цель **Node exporter** в конфигурационном файле **prometheus.yml**:

![](img/13.JPG)(prometheus_config)

Теперь цели отображаются в веб-интерфейсе **Prometheus**:

![](img/15.JPG)(prometheus_targets)

### 7.3. **Grafana**

Устанавливаем **Grafana** по инструкции с официального сайта. Устанавливаем необходимые пакеты:

![](img/16.JPG)(grafana_install)

Скачиваем последнюю версию и устанавливаем **Grafana**:

![](img/17.JPG)(grafana_download)

Запускаем **Grafana**:

![](img/18.JPG)(grafana_start)

Подключаемся к веб-интерфейсу **Grafana** и создаём дашборд с нужными метриками - **CPU**, **Memory**, **Disk**:

![](img/22.JPG)(grafana_dashboard)

Запускаем скрипт из второй части, отмечаем изменение метрик в **Grafana**:

![](img/23.JPG)(script_start)

Установливаем утилиту **stress** и запускаем команду `stress -c 2 -i 1 -m 1 --vm-bytes 32M -t 60s`. Здесь стоит **60s** для более яркой иллюстрации. Отмечаем изменение метрик в **Grafana**:

![](img/24.JPG)(stress_start)