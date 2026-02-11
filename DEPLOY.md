# 🚀 Deploy Manual en AWS Amplify - emmanuelrodas.com

## ✅ Archivos de configuración listos
- ✓ `amplify.yml` - Configuración de build para AWS Amplify
- ✓ Build exitoso sin errores
- ✓ Sitio bilingüe (EN/ES) funcionando
- ✓ Responsive design implementado

---

## 📦 Deploy Manual en AWS Amplify

### Paso 1: Preparar el build local

```bash
# Asegúrate de estar en el directorio del proyecto
cd /Users/emmanuel/Development/code/emmanuelrodas.com

# Instalar dependencias (si es necesario)
npm install

# Crear build de producción
npm run build

# Esto generará la carpeta 'dist' con todos los archivos estáticos
```

### Paso 2: Comprimir la carpeta dist

```bash
# Crear archivo ZIP del build
cd dist
zip -r ../emmanuelrodas-build.zip .
cd ..

# Ahora tienes 'emmanuelrodas-build.zip' listo para subir
```

### Paso 3: Subir a AWS Amplify

1. **Ir a AWS Amplify Console**
   - Abre [AWS Amplify Console](https://console.aws.amazon.com/amplify/)
   - Selecciona tu región (ej: us-east-1)

2. **Crear nueva app (si es la primera vez)**
   - Click en "New app" → "Host web app"
   - Selecciona "Deploy without Git provider"
   - Nombre de la app: `emmanuelrodas-com`

3. **Deploy manual**
   - En el dashboard de tu app, ve a "Manual deploy"
   - Arrastra y suelta el archivo `emmanuelrodas-build.zip`
   - O usa el botón "Choose files" para seleccionarlo
   - Click en "Save and deploy"

4. **Esperar el deploy**
   - El proceso toma ~1-2 minutos
   - Verás el progreso en tiempo real
   - Una vez completado, tendrás una URL tipo: `https://main.d1234abcd.amplifyapp.com`

### Paso 4: Configurar dominio personalizado (Opcional)

1. **En AWS Amplify Console**
   - Ve a "Domain management"
   - Click en "Add domain"
   - Ingresa: `emmanuelrodas.com`

2. **Configurar DNS**
   - Amplify te dará registros DNS para configurar
   - Ve a tu proveedor de dominios (GoDaddy, Namecheap, etc.)
   - Agrega los registros CNAME que Amplify te proporcione

3. **Verificación SSL**
   - Amplify automáticamente configura HTTPS
   - El certificado SSL se genera automáticamente
   - Espera ~15 minutos para la propagación DNS

---

## 🔄 Actualizaciones futuras

Cada vez que hagas cambios:

```bash
# 1. Hacer cambios en el código
# 2. Crear nuevo build
npm run build

# 3. Crear nuevo ZIP
cd dist && zip -r ../emmanuelrodas-build.zip . && cd ..

# 4. Subir manualmente a Amplify
# Ve a Amplify Console → Manual deploy → Sube el nuevo ZIP
```

---

## 📋 Configuración de amplify.yml

El archivo `amplify.yml` está configurado con:

```yaml
version: 1
frontend:
  phases:
    preBuild:
      commands:
        - npm ci                # Instala dependencias
    build:
      commands:
        - npm run build         # Crea el build
  artifacts:
    baseDirectory: dist         # Carpeta de salida
    files:
      - '**/*'                  # Incluye todos los archivos
  cache:
    paths:
      - node_modules/**/*       # Cachea node_modules
```

---

## 🌍 Configuración de Redirects para i18n

Si necesitas configurar redirects para las rutas de idioma:

1. **En Amplify Console**
   - Ve a "Rewrites and redirects"
   - Agrega estas reglas:

```
Source: /es/<*>
Target: /es/<*>
Type: 200 (Rewrite)

Source: /en/<*>
Target: /en/<*>
Type: 200 (Rewrite)

Source: /<*>
Target: /index.html
Type: 200 (Rewrite)
```

---

## 🔧 Script helper para deploy rápido

Puedes crear un script para automatizar el proceso:

```bash
# Crear archivo deploy.sh
cat > deploy.sh << 'EOF'
#!/bin/bash
echo "🔨 Building project..."
npm run build

echo "📦 Creating ZIP..."
cd dist
zip -r ../emmanuelrodas-build.zip .
cd ..

echo "✅ Build ready: emmanuelrodas-build.zip"
echo "📤 Now upload this file to AWS Amplify Console"
echo "🌐 URL: https://console.aws.amazon.com/amplify/"
EOF

# Dar permisos de ejecución
chmod +x deploy.sh

# Usar el script
./deploy.sh
```

---

## 📊 Checklist de Deploy

- [x] Build local exitoso
- [x] Archivo `amplify.yml` configurado
- [ ] Build comprimido en ZIP
- [ ] Subido a AWS Amplify
- [ ] URL de Amplify funcionando
- [ ] Dominio personalizado configurado (opcional)
- [ ] SSL/HTTPS activo
- [ ] Rutas de idioma funcionando (/, /es, /en)
- [ ] Menú móvil funcional
- [ ] Animaciones cargando correctamente

---

## 🆘 Troubleshooting

**Problema: Build falla en Amplify**
- Verifica que `amplify.yml` esté en la raíz del proyecto
- Asegúrate de que Node.js version sea compatible (v18+)

**Problema: Rutas 404**
- Configura los redirects en Amplify Console
- Verifica que todos los archivos estén en el ZIP

**Problema: Estilos no cargan**
- Verifica que las rutas sean relativas o absolutas correctamente
- Revisa la consola del navegador para errores

---

## 💡 Ventajas de AWS Amplify

- ✅ Deploy manual simple (drag & drop)
- ✅ SSL/HTTPS automático
- ✅ CDN global incluido
- ✅ Dominio personalizado fácil
- ✅ Rollback a versiones anteriores
- ✅ Monitoreo y analytics incluidos

---

**¡Tu sitio está listo para AWS Amplify! 🎉**

Tamaño estimado del build: ~500KB (muy ligero)
Tiempo de deploy: ~1-2 minutos
