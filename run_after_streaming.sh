#!/bin/bash

# === Asegurarse de estar en la raíz del proyecto ===
cd "$(dirname "$0")"

# === Cargar variables desde el archivo .env ===
if [ -f ".env" ]; then
    set -a
    source .env
    set +a
    echo "🔧 Variables cargadas desde .env"
else
    echo "⚠️ Archivo .env no encontrado. Abortando..."
    exit 1
fi

echo "📤 Enviando datos desde el Producer..."
python3 producer/api_to_kafka.py

echo "⏳ Esperando que Spark termine de procesar los datos..."
sleep 30  # Puedes ajustar esto según el volumen de datos

echo "📦 Convirtiendo Parquet a CSV único y comprimiendo..."
python3 utils/parquet_to_csv.py

echo "🧼 Procesando CSV limpio..."
python3 static_etl/process_csv.py

echo "📑 Procesando PDF extraído..."
python3 static_etl/process_pdf.py

echo "🤖 Entrenando modelo ML..."
python3 machine_learning/model_train.py

echo "🧠 Realizando inferencias..."
python3 machine_learning/inference.py

echo "✅ Proceso completo ejecutado tras el streaming."

# Crear carpeta destino para PowerBi si no existe
mkdir -p "$DEST_WIN_PATH"

# === Función para copiar con validación ===
copiar_con_validacion() {
    origen="$1"
    destino="$2"
    nombre_archivo=$(basename "$origen")

    if [ -f "$origen" ]; then
        cp "$origen" "$destino"
        echo "✅ Copiado: $nombre_archivo"
    else
        echo "❌ No se encontró: $nombre_archivo"
    fi
}

echo "📁 Copiando archivos CSV a Power BI..."

# CSVs de dashboard_data
copiar_con_validacion "output/dashboard_data/csv_procesado.csv" "$DEST_WIN_PATH"
copiar_con_validacion "output/dashboard_data/pdf_procesado.csv" "$DEST_WIN_PATH"

# CSV de entrenamiento
copiar_con_validacion "output/ml_training_data/ml_training_data.csv" "$DEST_WIN_PATH"

# CSV de predicciones
copiar_con_validacion "output/predictions/predicciones_vs_reales.csv" "$DEST_WIN_PATH"

echo "📦 Finalizado el copiado de archivos a Power BI."
