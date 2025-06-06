# 📈 Proyecto: Real-Time Stock Forecasting Pipeline (Big Data)

Este repositorio contiene un sistema completo de procesamiento de datos bursátiles en tiempo real utilizando tecnologías Big Data como **Apache Kafka**, **Apache Spark** y **Machine Learning**. Desarrollado como trabajo final del curso **Big Data**.

---

## 🛠️ Tecnologías utilizadas

- **Apache Kafka**: streaming de datos financieros  
- **Apache Spark**: procesamiento ETL en tiempo real  
- **Python**: transformación, modelado y predicción  
- **Power BI**: visualización de KPIs, métricas e insights  
- **Docker**: orquestación de contenedores (Kafka)

## 📁 Estructura general del proyecto

```
├── config/
├── kafka_services/
├── machine_learning/
├── output/                # Datos procesados para usar en Power BI
├── power_bi/              # Reporte Power BI (.pbix)
├── producer/
├── raw_data/              # Datos crudos CSV y PDF
├── spark/
├── static_etl/
├── utils/
├── .env                   # Variables de entorno sensibles
└── requirements.txt
```

## 🧰 Requisitos del sistema

Instala los siguientes componentes antes de ejecutar el proyecto:

- Python 3.8+  
- Java JDK 8 ✅ obligatorio para Spark  
- Apache Hadoop (cliente local)  
- Apache Spark (local)  
- Docker Desktop (para correr Kafka/Zookeeper)  
- Power BI Desktop (para abrir los reportes)

## 🚀 Pasos para ejecutar el proyecto

### 1. Clonar y preparar entorno

```bash
git clone <URL_REPOSITORIO>
cd nombre-del-proyecto
python -m venv venv
source .\venv\Scripts\Activate.ps1 
pip install -r requirements.txt
```

### 2. Configurar variables sensibles

Crea un archivo `.env` en la raíz del proyecto con el siguiente contenido:

```env
API_KEY=tu_api_key_aqui  # (ALPHA VANTAGE API)
KAFKA_TOPIC=nombre_de_tu_topic
KAFKA_BOOTSTRAP_SERVERS=tus_local_host
```

### 3. Levantar servicios Kafka

```bash
cd kafka_services
docker-compose up --build
```

Crear y verificar el tópico:

```bash
# Crear tópico
docker exec -it kafka-broker-1 kafka-topics --create \
  --bootstrap-server kafka-broker-1:29092 \
  --replication-factor 3 --partitions 3 \
  --topic mercados-bursatiles --if-not-exists

# Verificar tópicos
docker exec -it kafka-broker-1 kafka-topics --list \
  --bootstrap-server kafka-broker-1:29092
```

### 4. Ejecutar el flujo de datos

```bash
# a. Enviar datos a Kafka
python producer/api_to_kafka.py

# b. Procesar datos en Spark Streaming
.\run_spark_api.ps1

# c. Conversión Parquet a CSV
.\run_parquet_csv.ps1

# d. ETL estático desde PDF
.\run_static_etl.ps1
```

### 5. Entrenar y usar el modelo de ML

```bash
python machine_learning/model_train.py
python machine_learning/inference.py
```

## 📊 Visualización en Power BI

Los archivos procesados están en `output/dashboard_data/` y pueden ser conectados directamente a Power BI.

📌 *Próximamente se añadirá una imagen de referencia del dashboard final.*


## 👨‍🏫 Autor

**Grupo 3** – Trabajo final para el curso **Big Data** (Año 2025), dictado por el docente **Lira Camacho**.

¡Explora, ejecuta y aprende del flujo completo de datos en tiempo real! 📈

> **Todos los derechos reservados al Grupo 3.**