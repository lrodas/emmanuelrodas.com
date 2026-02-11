#!/bin/bash

echo "🚀 Emmanuel Rodas - Deploy Script para AWS Amplify"
echo "=================================================="
echo ""

# Limpiar build anterior
echo "🧹 Limpiando build anterior..."
rm -rf dist
rm -f emmanuelrodas-build.zip

# Instalar dependencias
echo "📦 Verificando dependencias..."
npm install

# Crear build
echo "🔨 Creando build de producción..."
npm run build

# Verificar que el build fue exitoso
if [ ! -d "dist" ]; then
    echo "❌ Error: Build falló. No se encontró la carpeta 'dist'"
    exit 1
fi

# Crear ZIP
echo "📦 Comprimiendo archivos..."
cd dist
zip -r ../emmanuelrodas-build.zip . -q
cd ..

# Verificar tamaño del ZIP
SIZE=$(du -h emmanuelrodas-build.zip | cut -f1)
echo ""
echo "✅ Build completado exitosamente!"
echo "📊 Tamaño del archivo: $SIZE"
echo "📁 Archivo: emmanuelrodas-build.zip"
echo ""
echo "📤 Próximos pasos:"
echo "1. Ve a AWS Amplify Console: https://console.aws.amazon.com/amplify/"
echo "2. Selecciona tu app o crea una nueva"
echo "3. Ve a 'Manual deploy'"
echo "4. Sube el archivo: emmanuelrodas-build.zip"
echo ""
echo "🌐 ¡Listo para deploy!"
