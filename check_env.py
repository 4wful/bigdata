import os
import subprocess

def check_var(name):
    value = os.environ.get(name)
    print(f"{name}: {value if value else '[❌ NO DEFINIDA]'}")

print("🔍 Verificando variables de entorno...\n")

vars_to_check = [
    "JAVA_HOME",
    "SPARK_HOME",
    "HADOOP_HOME",
    "PYSPARK_PYTHON",
    "PYSPARK_DRIVER_PYTHON"
]

for var in vars_to_check:
    check_var(var)

print("\n💡 Versión de Python:")
subprocess.run(["python", "--version"])

print("\n💡 Versión de Java:")
subprocess.run(["java", "-version"])

print("\n💡 Versión de Spark (comprobando spark-shell):")

spark_home = os.environ.get("SPARK_HOME")
if spark_home:
    spark_shell_path = os.path.join(spark_home, "bin", "spark-shell.cmd")
    env = os.environ.copy()
    # Agregar spark/bin al PATH temporalmente
    env["PATH"] = os.path.join(spark_home, "bin") + os.pathsep + env.get("PATH", "")
    try:
        subprocess.run([spark_shell_path, "--version"], env=env)
    except FileNotFoundError:
        print("[❌ ERROR] No se encontró spark-shell.cmd en la ruta esperada.")
else:
    print("[❌ ERROR] Variable SPARK_HOME no definida, no se puede verificar spark-shell.")
