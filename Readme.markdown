# 📈 Proyecto: Análisis de Mercados Bursátiles con Big Data y Power BI

Este repositorio presenta un sistema de **procesamiento y análisis de datos financieros en tiempo real**, utilizando tecnologías de **Big Data** como Apache Kafka y Spark, con visualización avanzada en **Power BI**. El enfoque está orientado al curso de **Big Data**, aplicando sus principios al análisis del mercado bursátil para generar insights estratégicos.

✔️ Optimizado para ejecutarse en **WSL2 en modo headless** (sin entorno gráfico).

---

## 🛠️ Tecnologías y herramientas clave

- **WSL2 + UBUNTU** → entorno de trabajo necesario
- **Docker** → contenedores para servicios como Kafka y Zookeeper
- **Apache Kafka** → ingesta de datos en streaming desde APIs bursátiles  
- **Apache Spark** → procesamiento distribuido y ETL en tiempo real  
- **Python** → lógica de negocio, transformación y predicción  
- **Power BI** → visualización de indicadores clave del mercado  

---

## 📁 Estructura del proyecto

```
├── config/ # Configuración del proyecto
├── kafka_services/ # Orquestación Kafka + Zookeeper con Docker
├── machine_learning/ # Entrenamiento y predicción de modelos ML
├── output/ # Resultados (CSV, gráficos, modelos)
├── producer/ # Ingesta de datos bursátiles → Kafka
├── raw_data/ # Archivos CSV y PDF originales
├── spark/ # Lógica de procesamiento con Spark Streaming
├── static_etl/ # ETL tradicional sobre archivos planos
├── utils/ # Funciones auxiliares
├── .env # Variables sensibles (ignorado por Git)
├── .gitignore # Exclusiones de control de versiones
├── run_after_streaming.sh# Pipeline automático post-streaming
├── requirements.txt # Dependencias Python
└── README.md # Documentación del proyecto
```

---

## ⚙️ Requisitos del sistema

- Ubuntu con WSL2 
- Python 3.10 
- Java JDK 11 
- Apache Spark  
- Apache Hadoop 
- Docker Desktop  
- Power BI Desktop  

---

## 🚀 Ejecución del proyecto

### 1. Clonación e instalación de entorno

```bash
git clone https://github.com/4wful/bigdata.git
cd bigdata
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### 2. Configurar archivo

🔐 Este archivo no se sube al repositorio por seguridad.

Crea un archivo `.env` en la raíz del proyecto con el siguiente contenido:

```env
API_KEY=tu_api_key_de_alpha_vantage
KAFKA_TOPIC=nombre_topic
KAFKA_BOOTSTRAP_SERVERS=localhost:9092,localhost:9093,localhost:9094
DEST_WIN_PATH=/mnt/c/Users/TU_USUARIO/Desktop/.../bigdata/data
```

### 3. Levantar servicios Kafka

```bash
cd kafka_services
docker-compose up -d
```

Crear y verificar el tópico:

```bash
# Crear tópico
docker exec -it kafka-broker-1 kafka-topics --create \
  --bootstrap-server kafka-broker-1:29092 \
  --replication-factor 3 --partitions 3 \
  --topic nombre_topic --if-not-exists

# Listar tópicos existentes
docker exec -it kafka-broker-1 kafka-topics --list \
  --bootstrap-server kafka-broker-1:29092
```

### 4. Ejecutar el flujo de datos

```bash
# Asegúrate de que Spark esté instalado localmente
cd spark
spark-submit --packages org.apache.spark:spark-sql-kafka-0-10_2.12:3.5.5 spark_api.py

# Ejecutar procesamiento completo post-streaming
./run_after_streaming.sh

Este script ejecuta:

Envío de datos por producer/api_to_kafka.py

Espera y transformación vía Spark

Conversión Parquet → CSV

Limpieza estática de CSV y PDF

Entrenamiento de modelos ML (Regresión Lineal y Random Forest)

Predicciones e inferencia

Copiado automático a Power BI

```
## 📊 Visualización final en Power BI

Dirígete a la carpeta output conecta Power BI a los archivos CSV necesarios para construir tu dashboard personalizado.

📷 Vista previa del Dashboard

![image](https://github.com/user-attachments/assets/447c18f4-74cf-4cd2-b18a-b46ccbbf313b)

## 📌 Notas adicionales
Los archivos .pkl, .txt y .csv generados automáticamente se excluyen con .gitignore.

El sistema está optimizado para funcionar sin entorno gráfico (modo headless en WSL2).

El flujo completo es reproducible y automatizado desde run_after_streaming.sh.

👨‍🏫 Autoría
Grupo 3 – Trabajo final para el curso de Big Data (2025)
**¡Explora, ejecuta y aprende del flujo completo de datos en tiempo real!**

