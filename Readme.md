
# README.md

Implementarea Informațiilor despre Sistem

Acest fișier vine cu instrucțiuni complete pentru implementarea scripturilor **Bash** și **Python** folosind **Docker** și **Docker Compose**. Urmând acești pași, veți putea să implementați și să vizualizați informațiile despre sistem pe mașina dvs. țintă.

## Descrierea Proiectului

Acest proiect conține două scripturi (unul în **Bash** și unul în **Python**) care rulează într-o buclă infinită, afișând la intervale regulate informații despre sistem, incluzând data, ora, detalii despre OS, CPU, RAM și utilizarea discului. Implementarea folosește **Docker** și **Docker Compose**.

## Cerințe preliminare

Asigurați-vă că următoarele sunt instalate pe mașina dvs. locală sau pe mașina țintă:

- **Docker**
- **Docker Compose**

## Scriptul Bash (`system_info.sh`)

Acest script afișează informații despre sistem la fiecare câteva secunde.

### Exemplu de Script Bash




## bash



```bash
  #!/bin/bash

# Set the interval in seconds 
interval=3

# Infinite loop
while true; do
    # Display the current date and time
    echo "Current date and time: $(date)"

    # Operating system information
    echo "Operating System: $(uname -o)"
    echo "Kernel Version: $(uname -r)"
    
    # CPU information
    echo "CPU: $(lscpu | grep 'Model name' | awk -F': ' '{print $2}')"
    
    # RAM information (total and used)
    ram_total=$(free -h | grep 'Mem:' | awk '{print $2}')
    ram_used=$(free -h | grep 'Mem:' | awk '{print $3}')
    echo "RAM - Total: $ram_total, Used: $ram_used"

    # Disk information (total and used)
    disk_total=$(df -h / | grep '/' | awk '{print $2}')
    disk_used=$(df -h / | grep '/' | awk '{print $3}')
    echo "Disk Space - Total: $disk_total, Used: $disk_used"
    
    # Separator line
    echo "**************************************************"
    
    # Wait for the specified interval
    sleep $interval
done
```
## Scriptul Python (system_info.py)
Acest script Python folosește biblioteca psutil pentru a afișa informații similare despre sistem la intervale regulate.
### Exemplu de Script Python



## python


```python
import time
import platform
import psutil
from datetime import datetime

# Interval de așteptare 
interval = 5

# Bucla infinită
while True:
    # Afișăm data și ora curentă
    print("Data și ora curentă:", datetime.now().strftime("%Y-%m-%d %H:%M:%S"))

    # Informații despre sistemul de operare
    print("Sistem de operare:", platform.system())
    print("Versiune kernel:", platform.release())
    
    # Informații despre CPU
    print("CPU:", platform.processor())
    
    # Informații despre RAM (total și utilizat)
    ram_total = psutil.virtual_memory().total / (1024**3)  # GB
    ram_used = psutil.virtual_memory().used / (1024**3)    # GB
    print(f"Memorie RAM - Total: {ram_total:.2f} GB, Utilizat: {ram_used:.2f} GB")
    
    # Informații despre disk (total și disponibil)
    disk_total = psutil.disk_usage('/').total / (1024**3)  # GB
    disk_used = psutil.disk_usage('/').used / (1024**3)    # GB
    print(f"Spațiu disk - Total: {disk_total:.2f} GB, Utilizat: {disk_used:.2f} GB")
    
    # Linie de separare
    print("-------------------------------------------")
    
    # Așteptăm pentru intervalul specificat
    time.sleep(interval)
```

## Configurarea Docker
### Dockerfile pentru Scriptul Bash (Dockerfile.bash)
Acest Dockerfile creează o imagine Docker care rulează scriptul Bash.
```Dockerfile
# Dockerfile.bash
FROM ubuntu:latest

# Install necessary packages to run the Bash script
RUN apt-get update && \
    apt-get install -y bash lsb-release procps

# Create and copy the Bash script into the container
COPY system_info.sh /system_info.sh

# Ensure the script has execute permissions
RUN chmod +x /system_info.sh

# Run the script as the main command
CMD ["/system_info.sh"]
```

### Dockerfile pentru Scriptul Python (Dockerfile.python)
Acest Dockerfile creează o imagine Docker pentru scriptul Python.
## Dockerfile
```Dockerfile
# Dockerfile.python
FROM python:3

# Install the psutil package required by the Python script
RUN pip install psutil

# Create and copy the Python script into the container
COPY system_info.py /system_info.py

# Run the Python script as the main command
CMD ["python", "/system_info.py"]
```

## Construiți imaginile Docker
Pentru a construi imaginea Docker pentru scriptul Bash, rulați:

## bash
```bash
docker build -f Dockerfile.bash -t bash-system-info
```

Pentru a construi imaginea Docker pentru scriptul Python, rulați:

## python
```python
docker build -f Dockerfile.python -t python-system-info
```

## Porniți containerele
## bash
```bash
docker run --name bash-container -d bash-system-info
```

## python
```python
docker run --name python-container -d python-system-info
```
## Verificați logurile pentru fiecare container
###  Pentru containerul Bash:
## bash
```bash
docker logs -f bash-container
```
### Pentru containerul Python:
## python
```python
docker logs -f python-container
```
## Opriți și ștergeți containerele
### Când doriți să opriți și să ștergeți containerele, folosiți următoarele comenzi:
## bash
```bash
docker stop bash-container python-container
docker rm bash-container python-container
```
## Construiți și porniți containerele folosind Docker Compose
### Creați fișierul docker-compose.yml
În același director, creați un fișier docker-compose.yml cu următorul conținut:
## yaml
```yaml
version: '3.8'

services:
  bash-service:
    build:
      context: .
      dockerfile: Dockerfile.bash
    container_name: bash-container-v2
    
  python-service:
    build:
      context: .
      dockerfile: Dockerfile.python
    container_name: python-container-v2
```


## Construiți și porniți containerele folosind Docker Compose

Executați următoarele comenzi din directorul unde ați creat fișierele:
# Construiți containerele
## docker-compose
```docker-compose
 docker-compose build
 ```

# Porniți containerele în fundal
## docker-compose 
```docker-compose
docker-compose up -d
```

## Verificați starea containerelelor

### Pentru a verifica dacă containerele rulează, folosiți comanda:
## docker
```docker
docker ps
```


## Vizualizați logurile din containere
Pentru a vedea ieșirea din fiecare container, folosiți:
## docker-compose
```docker
docker-compose logs -f
```
## Opriți și eliminați containerele
### Când doriți să opriți serviciile și să eliberați resursele, folosiți:
## docker-compose
```docker
docker-compose down
```
















