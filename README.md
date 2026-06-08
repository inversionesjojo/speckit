# Spec-kit Docker Image

Este repositorio contiene los archivos necesarios para construir y ejecutar una imagen de Docker para [Specify CLI](https://github.com/github/spec-kit), una herramienta para el Desarrollo Orientado a Especificaciones (Spec-Driven Development) con agentes de IA.

## Archivos

### Dockerfile
El `Dockerfile` define el entorno en el cual se ejecutará la CLI de Specify:
- Utiliza una imagen base de Python (`python:3.15.0b2-trixie`).
- Instala `uv`, un gestor de paquetes y dependencias rápido para Python.
- Utiliza `uv` para instalar `specify-cli` directamente desde el repositorio de GitHub oficial de `spec-kit`, utilizando la versión especificada en el argumento `SPECIFY_VERSION`.
- Configura el `PATH` para asegurar que el comando `specify` esté disponible.

### Makefile
El `Makefile` automatiza las tareas de construcción y ejecución del contenedor:
- Define variables por defecto como `SPECIFY_VERSION="v0.9.5"`, `TAG="v1.0.0"`, `PROJECT_NAME?=speckit`, e `INTEGRATION?=agy`.
- **`make build`**: Construye la imagen de Docker pasándole la versión de `specify` deseada. La imagen se etiqueta como `spectkit:v1.0.0`.
- **`make run`**: Ejecuta un contenedor interactivo a partir de la imagen construida. Mapea el directorio actual (`$(PWD)`) dentro del contenedor en `/app`, de modo que los archivos generados por `specify init` persistan en tu máquina local. Ejecuta el comando para inicializar el proyecto con la integración configurada.

## Integraciones de Agentes de IA
La herramienta `specify` soporta una amplia variedad de agentes de programación por IA. Cuando se ejecuta `specify init`, la CLI configura los archivos de comandos, reglas de contexto y estructuras de directorios apropiados para el agente seleccionado.

De acuerdo con la [Documentación de Integraciones de Spec Kit](https://github.github.io/spec-kit/reference/integrations.html), algunos de los agentes soportados incluyen:
- **Antigravity (`agy`)** - El valor por defecto en el Makefile.
- **GitHub Copilot (`copilot`)**
- **Claude Code (`claude`)**
- **Cline (`cline`)**
- **Cursor (`cursor-agent`)**
- **Devin (`devin`)**
- **Gemini (`gemini`)**
- **Goose (`goose`)**

Puedes cambiar la integración ejecutando:
```bash
make run INTEGRATION=copilot PROJECT_NAME=mi-proyecto
```

## CI/CD: Publicación en Docker Hub
Este proyecto cuenta con un flujo de trabajo de GitHub Actions (`.github/workflows/docker-publish.yml`) que construye y publica la imagen automáticamente en Docker Hub.

### Configuración requerida
Para que el pipeline funcione correctamente, debes configurar los siguientes **Secrets de repositorio** en GitHub (`Settings` -> `Secrets and variables` -> `Actions`):

- `DOCKERHUB_USERNAME`: Tu nombre de usuario en Docker Hub.
- `DOCKERHUB_TOKEN`: Un token de acceso personal (PAT) generado en Docker Hub con permisos de lectura y escritura.

El flujo de trabajo se dispara automáticamente al hacer push a la rama `main` o al crear un tag (ej: `v1.0.0`), construyendo la imagen y subiéndola a `<tu-usuario>/speckit`.
