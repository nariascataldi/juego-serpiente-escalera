# Instalación de Flutter en macOS

## Opción 1: Homebrew (Recomendado)

### 1. Instalar Homebrew (si no lo tenés)
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Instalar Flutter
```bash
brew install flutter
```

### 3. Verificar instalación
```bash
flutter --version
```

---

## Opción 2: Descarga manual

### 1. Descargar Flutter SDK
Ve a: https://docs.flutter.dev/get-started/install/macos

Descarga el archivo `.zip`

### 2. Extraer y colocar
```bash
# Suponiendo que lo descargaste en Descargas
cd ~/Downloads
unzip flutter_macos_*.zip
mv flutter ~/Developer/flutter
```

### 3. Agregar al PATH
Agregar esta línea a `~/.zshrc` o `~/.bash_profile`:
```bash
export PATH="$PATH:$HOME/Developer/flutter/bin"
```

### 4. Aplicar cambios
```bash
source ~/.zshrc
```

### 5. Verificar
```bash
flutter --version
```

---

## Configuración de Android Studio (requerido para APK)

### 1. Descargar Android Studio
https://developer.android.com/studio

### 2. Instalar componentes
```bash
# Abrir Android Studio y seguir el asistente de configuración
# Luego en terminal:
flutter doctor --android-licenses
```

### 3. Verificar todo
```bash
flutter doctor
```

---

## Verificar entorno

```bash
flutter doctor
```

Deberías ver:
```
✓ Flutter is installed
✓ Android toolchain is configured
```

---

## Primer Build

```bash
cd ~/Projects/Juego\ serpiente\ y\ escalera/snakes_and_ladders

flutter pub upgrade
flutter build apk --debug
```

El APK se generará en:
```
build/app/outputs/flutter-apk/app-debug.apk
```

---

## Solución de problemas

### "flutter: command not found"
```bash
# Verificar que está instalado
which flutter

# Si no está, agregar al PATH
echo 'export PATH="$PATH:$HOME/Developer/flutter/bin"' >> ~/.zshrc
source ~/.zshrc
```

### "Android toolchain is not configured"
```bash
flutter doctor --android-licenses
flutter config --android-sdk ~/Library/Android/sdk
```

---

## Instalar APK en teléfono

### Opción 1: Por cable USB
```bash
# Conectar teléfono y habilitar "Depuración USB" en settings
adb install build/app/outputs/flutter-apk/app-debug.apk
```

### Opción 2: Transferir archivo
1. Copiar `app-debug.apk` a tu teléfono
2. Abrir el archivo APK en el teléfono
3. Instalar (puede pedir permisos)

---

¡Listo! Una vez instalado Flutter, ejecutás los comandos de build del DOC.md.