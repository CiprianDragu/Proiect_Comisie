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
