# 📈 Proyecto: Análisis Financiero con Streaming y Power BI (Business Analytics)

Este repositorio contiene un sistema de análisis de datos bursátiles con procesamiento en tiempo real y visualización avanzada en **Power BI**. Está orientado al curso de Business Analytics, con foco en generar insights útiles para la toma de decisiones empresariales.

✔️ Adaptado para funcionar en **WSL2 sin entorno gráfico (headless)**.

---

## 🛠️ Tecnologías utilizadas

- **Apache Kafka** → streaming de datos financieros  
- **Apache Spark** → procesamiento ETL en tiempo real  
- **Python** → transformación, modelado y predicción  
- **Scikit-learn** → regresión lineal y random forest  
- **Power BI** → visualización de KPIs e insights  
- **Docker** → orquestación de contenedores (Kafka + Zookeeper)

---

## 📁 Estructura del proyecto

```
├── config/ # Configuración central (paths, constantes)
├── kafka_services/ # Docker Compose para Kafka y Zookeeper
├── machine_learning/ # Entrenamiento y predicción ML
├── output/ # Archivos finales CSV, gráficos, modelos
├── producer/ # API → Kafka (streaming)
├── raw_data/ # CSV y PDF crudos
├── spark/ # Lógica de Spark Streaming
├── static_etl/ # ETL estático (CSV/PDF)
├── utils/ # Scripts auxiliares
├── .env # Variables sensibles (no incluido en Git)
├── .gitignore # Archivos y carpetas excluidos
├── run_after_streaming.sh # Script automatizado del flujo completo
├── requirements.txt # Dependencias del proyecto
└── README.md # Documentación general
```

## 🧰 Requisitos del sistema

- Ubuntu + WSL2 (opcional pero compatible y probado)
- Python 3.10 
- Java JDK 11 
- Apache Spark  
- Apache Hadoop 
- Docker Desktop  
- Power BI Desktop  

---

## 🚀 Pasos para ejecutar el proyecto

### 1. Clonar y preparar entorno

```bash
git clone https://github.com/4wful/business-analytics.git
cd business-analytics
python -m venv venv
source venv/bin/activate      # En Linux o WSL2
pip install -r requirements.txt
```

### 2. Configurar archivo

🔐 Este archivo no se sube al repositorio por seguridad.

Crea un archivo `.env` en la raíz del proyecto con el siguiente contenido:

```env
API_KEY=tu_api_key_de_alpha_vantage
KAFKA_TOPIC=nombre_topic
KAFKA_BOOTSTRAP_SERVERS=localhost:9092,localhost:9093,localhost:9094
DEST_WIN_PATH=/mnt/c/Users/TU_USUARIO/Desktop/.../BusinessAnalytics/data
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

![image](https://github.com/user-attachments/assets/1a1e4ade-ba48-49ef-80ea-af239573d592)

**KPIs sugeridos:**

- Precio real vs. predicho

- Volumen total negociado

- Tendencia por sector / región

- Errores de predicción (R², MSE)

## 📌 Notas adicionales
Los archivos .pkl, .txt y .csv generados automáticamente se excluyen con .gitignore.

El sistema está optimizado para funcionar sin entorno gráfico (modo headless en WSL2).

El flujo completo es reproducible y automatizado desde run_after_streaming.sh.

👨‍🏫 Autoría
Grupo 4 – Trabajo final para el curso Business Analytics (2025)
**¡Explora, ejecuta y aprende del flujo completo de datos en tiempo real!**

