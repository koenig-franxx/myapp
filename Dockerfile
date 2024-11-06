# Imagen base
FROM python:3.9-slim

# Directorio de trabajo
WORKDIR /app

# Copia el código fuente
COPY src/ /app

# Instala las dependencias
RUN pip install -r requirements.txt

# Exponer el puerto de la aplicación
EXPOSE 80

# Ejecuta la aplicación
CMD ["python", "app.py"]
