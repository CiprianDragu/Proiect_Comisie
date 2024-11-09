 Acest fisier vine cu instrucțiuni complete pentru implementarea scripturilor Bash și Python folosind Docker, Docker Compose  Urmând acești pași, veți putea să implementați și să vizualizați informațiile despre sistem pe mașina dvs. țintă:
  
  #Implementarea Informațiilor despre Sistem

Acest proiect conține două scripturi (unul în **Bash** și unul în **Python**) care rulează într-o buclă infinită, afișând la intervale regulate informații despre sistem, incluzând data, ora, detalii despre OS, CPU, RAM și utilizarea discului. Implementarea folosește **Docker**, **Docker Compose**.

##Cerințe preliminare

Asigurați-vă că următoarele sunt instalate pe mașina dvs. locală sau pe mașina țintă:


- **Docker**
- **Docker Compose**


Scriptul Bash (`system_info.sh`)

Acest script afișează informații despre sistem la fiecare câteva secunde.

#!/bin/bash

interval=5

while true; do
    echo "Data și ora curentă: $(date)"
    echo "Sistem de operare: $(uname -o)"
    echo "Versiune kernel: $(uname -r)"
    echo "CPU: $(lscpu | grep 'Model name' | awk -F': ' '{print $2}')"
    ram_total=$(free -h | grep 'Mem:' | awk '{print $2}')
    ram_used=$(free -h | grep 'Mem:' | awk '{print $3}')
    echo "RAM - Total: $ram_total, Utilizat: $ram_used"
    disk_total=$(df -h / | grep '/' | awk '{print $2}')
    disk_used=$(df -h / | grep '/' | awk '{print $3}')
    echo "Spațiu disk - Total: $disk_total, Utilizat: $disk_used"
    echo "-------------------------------------------"
    sleep $interval
done


Scriptul Python (system_info.py)
Acest script Python afișează informații similare folosind biblioteca psutil.

import os
import time
import psutil
from datetime import datetime

interval = 5

while True:
    print(f"Data și ora curentă: {datetime.now()}")
    print(f"Sistem de operare: {os.uname()}")
    print(f"CPU: {os.popen('lscpu | grep "Model name"').read().strip()}")
    mem = psutil.virtual_memory()
    print(f"RAM - Total: {mem.total / (1024 ** 3):.2f} GB, Utilizat: {mem.used / (1024 ** 3):.2f} GB")
    disk = psutil.disk_usage('/')
    print(f"Spațiu Disk - Total: {disk.total / (1024 ** 3):.2f} GB, Utilizat: {disk.used / (1024 ** 3):.2f} GB")
    print("-------------------------------------------")
    time.sleep(interval)




    Configurarea Docker
Dockerfile pentru Scriptul Bash (Dockerfile.bash)


FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    bash \
    coreutils \
    procps \
    util-linux

COPY system_info.sh /system_info.sh

CMD ["/bin/bash", "/system_info.sh"]



Dockerfile pentru Scriptul Python (Dockerfile.python)


FROM python:3

RUN apt-get update && apt-get install -y \
    procps \
    lscpu \
    psutil

COPY system_info.py /system_info.py

CMD ["python", "/system_info.py"]



Configurația Docker Compose (docker-compose.yml)


version: '3'

services:
  bash-service:
    build:
      context: .
      dockerfile: Dockerfile.bash
    container_name: bash-container-v2
    restart: always
    volumes:
      - ./system_info.sh:/system_info.sh
    command: /system_info.sh

  python-service:
    build:
      context: .
      dockerfile: Dockerfile.python
    container_name: python-container-v2
    restart: always
    volumes:
      - ./system_info.py:/system_info.py
    command: python /system_info.py






    - name: Clonează Repozitoriul (înlocuiți cu URL-ul dvs. Git)
      git:
        repo: 'https://your-repository-url.git'
        dest: /opt/system-info
        version: master
        force: yes

    - name: Rulează Docker Compose
      ansible.builtin.shell: "cd /opt/system-info && docker-compose up -d"
      args:
        chdir: /opt/system-info

    - name: Asigură-te că containerele rulează
      docker_compose:
        project_src: /opt/system-info
        restarted: yes



Pași pentru Implementare
 1:Clonați proiectul pe mașina locală:

git clone https://link-repozitoriu-git
cd /calea/spre/proiect

2:Construiți și porniți containerele folosind Docker Compose:
docker-compose up -d

3:Verificați implementarea: Rulați următoarea comandă pentru a vedea dacă containerele sunt active:
docker ps

 4: Vizualizați Logurile
Verificați logurile cu:
docker-compose logs -f

5: Opriți Implementarea
Pentru a opri containerele, rulați:
docker-compose down
