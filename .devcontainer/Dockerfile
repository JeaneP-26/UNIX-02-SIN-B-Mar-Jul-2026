# ============================================================================
#  Dockerfile — Recipe to build the course container image
# ============================================================================
#  A Dockerfile is a plain text file with step-by-step instructions that
#  Docker (or GitHub Codespaces) reads top to bottom to build an "image".
#  An image is a frozen snapshot of a ready-to-use Linux system; every time
#  you open the Codespace, Docker creates a "container" from that snapshot.
#
#  Think of it this way: the image is the BLUEPRINT, the container is the
#  HOUSE built from it. You can build many identical houses from one
#  blueprint, and destroying a house leaves the blueprint intact.
#
#  Each instruction (FROM, ENV, RUN...) adds a new read-only "layer" on top
#  of the previous one. Docker caches every layer: if you have not changed
#  the earlier lines, Docker reuses the cached result and the next build is
#  almost instant. This is why instruction ORDER matters — put things that
#  change rarely (base image, env vars) at the top, and things that change
#  often (app code) at the bottom. — BHB Ch.3 (lab/Docker setup)
# ============================================================================


# ----------------------------------------------------------------------------
# BLOCK a — FROM: the base image we build on top of
# ----------------------------------------------------------------------------
# A base image is a pre-built starting point that already contains an
# operating system and its core tools. Instead of setting up Linux from
# scratch, we simply extend an existing one.
#
# We use the official Kali Linux "rolling" image. "Rolling" means the
# package repositories are updated continuously — there is no fixed version
# like "Kali 2024.1"; the image always tracks the latest packages.
# Kali is chosen because it comes with security and networking tools
# pre-configured, which matches the focus of this course. — BHB Ch.3
FROM kalilinux/kali-rolling:latest


# ----------------------------------------------------------------------------
# BLOCK c — ENV: permanent environment variables inside the container
# ----------------------------------------------------------------------------
# Environment variables are key=value pairs stored in the shell's
# environment and inherited by every child process. Programs read them to
# know how to behave without needing command-line flags every time.
# By convention they are written in UPPER_CASE. — BHB Ch.1 (env vars)
#
#   DEBIAN_FRONTEND=noninteractive
#     Tells apt (the Debian/Kali package manager) to never ask interactive
#     questions during installation. Without this, some packages would pause
#     the build waiting for keyboard input that never comes, hanging forever.
#
#   LANG / LC_ALL=es_ES.UTF-8
#     Set the language and character encoding for the container.
#     UTF-8 is the encoding that supports accented letters, ñ, €, emojis,
#     and virtually every human script. Without it, those characters may
#     display as garbage. — BHB Ch.1 (standard I/O and encoding)
#
#   TERM=xterm-256color
#     Tells terminal programs that the terminal supports 256 colors.
#     Tools like vim, nvim, and htop use this to display their full
#     color schemes instead of falling back to plain black and white.
#
# The trailing backslash "\" is a line-continuation character — it means
# "this logical line continues on the next physical line". It is purely
# for human readability; Docker treats it as one single ENV instruction.
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=es_ES.UTF-8 \
    LC_ALL=es_ES.UTF-8 \
    TERM=xterm-256color


# ----------------------------------------------------------------------------
# Pre-respuesta a una pregunta interactiva de Wireshark
# ----------------------------------------------------------------------------
# Wireshark/tshark PREGUNTA durante su instalación si los usuarios
# normales (no-root) deben poder capturar paquetes. Como en el contenedor
# siempre somos root, respondemos "false" POR ADELANTADO usando
# debconf-set-selections para que no detenga el build esperando input.
RUN echo "wireshark-common wireshark-common/install-setuid boolean false" \
    | debconf-set-selections


# ----------------------------------------------------------------------------
# RUN: ejecutar comandos durante la construcción de la imagen
# ----------------------------------------------------------------------------
# Aquí instalamos TODO el software del curso en un solo RUN.
#
#   apt-get update          -> actualiza la lista de paquetes disponibles
#   apt-get install         -> descarga e instala los paquetes listados
#     -y                    -> responde "sí" automáticamente
#     --no-install-recommends -> instala SOLO lo esencial (no los extras
#                                sugeridos). Ahorra cientos de MB.
#
# ¿Por qué un solo RUN gigante y no 10 RUN pequeños?
# Porque CADA RUN crea una capa nueva en la imagen. Menos capas = imagen
# más pequeña, más rápida de construir y de descargar.
#
# El "&&" encadena comandos: ejecuta el siguiente SOLO SI el anterior
# terminó bien. Si algo falla, el build se detiene con error (que es lo
# que queremos: mejor un error claro que una imagen rota).
RUN apt-get update && apt-get install -y --no-install-recommends \
    \
    # === Editores de texto y shells (intérpretes de comandos) ===
    neovim \
    vim \
    zsh \
    bash-completion \
    \
    # === Herramientas de 4ta generación ===
    # Estas son las protagonistas de las Unidades 2, 3 y 4:
    perl \
    make \
    gawk \
    sed \
    grep \
    \
    # === Utilidades básicas de UNIX ===
    # coreutils trae cat, ls, head, tail, sort, cut, tr, etc.
    # findutils trae find y xargs.
    # procps trae ps, top, kill (gestión de procesos).
    # less = paginador para leer archivos largos.
    # tree = muestra directorios como árbol.
    # jq = procesa JSON desde la línea de comandos.
    coreutils \
    findutils \
    procps \
    less \
    tree \
    jq \
    \
    # === Páginas de manual (comando `man`) ===
    # La imagen base de Kali viene sin documentación para
    # ahorrar espacio. La reinstalamos porque en el curso "man bash" o
    # "man grep" es material de consulta obligada.
    man-db \
    manpages \
    manpages-posix \
    \
    # === Red básica y utilidades de descarga ===
    curl \
    wget \
    git \
    git-lfs \
    ca-certificates \
    locales \
    \
    # === Linter (revisor automático de errores) para scripts Bash ===
    shellcheck \
    \
    # === Reconocimiento y escaneo de red ===
    # nmap = el escáner de puertos más famoso.
    # masscan = escaneo masivo de rangos grandes de IPs.
    nmap \
    masscan \
    \
    # === Captura y análisis de paquetes de red ===
    # tcpdump = capturador clásico por terminal.
    # tshark = versión de terminal de Wireshark.
    tcpdump \
    tshark \
    \
    # === Utilidades de red variadas ===
    netcat-traditional \
    socat \
    dnsutils \
    whois \
    traceroute \
    mtr-tiny \
    iproute2 \
    net-tools \
    iputils-ping \
    \
    # === Anonimato: Tor y similares ===
    # tor = cliente de la red Tor.
    # torsocks = "envoltorio" que hace pasar cualquier comando por Tor.
    # proxychains4 = encadena múltiples proxies.
    # obfs4proxy = ofusca el tráfico de Tor para evadir bloqueos.
    tor \
    torsocks \
    proxychains4 \
    obfs4proxy \
    \
    # === Cliente HTTP más legible que curl para aprender ===
    httpie \
    \
 # --- Después de instalar, activamos el idioma español ---
 # sed busca "# es_ES.UTF-8" en /etc/locale.gen y le quita el "#" para
 # activar esa línea. Luego locale-gen compila los archivos de idioma.
 && sed -i 's/# es_ES.UTF-8/es_ES.UTF-8/' /etc/locale.gen \
 && locale-gen \
 \
 # --- Limpieza final: reducir el tamaño de la imagen ---
 # apt deja archivos de caché que ya no necesitamos después de instalar.
 # Borrarlos aquí (en el mismo RUN) hace la capa final más pequeña.
 # Si los borráramos en otro RUN, seguirían ocupando en la capa anterior.
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*


# ----------------------------------------------------------------------------
# SHELL: qué intérprete usar en los siguientes RUN
# ----------------------------------------------------------------------------
# Por defecto Docker usa /bin/sh (un shell más limitado y antiguo). Lo
# cambiamos a bash por si agregamos más instrucciones con sintaxis
# moderna (arrays, [[ ]], etc.).
SHELL ["/bin/bash", "-c"]


# ----------------------------------------------------------------------------
# WORKDIR: directorio de trabajo al entrar al contenedor
# ----------------------------------------------------------------------------
# Codespaces siempre monta el código del repositorio en
# /workspaces/<nombre-del-repo>. Establecer /workspaces aquí hace que las
# terminales se abran cerca de nuestros archivos del curso.
WORKDIR /workspaces

# Configuración de Git para el contenedor:
# - safe.directory *: confía en cualquier repo montado (necesario porque
#   /workspaces/... tiene un UID distinto al de root dentro del container).
# - init.defaultBranch main: evita warnings de "master vs main" en git init.
# - pull.rebase false: merge por defecto al hacer pull (más intuitivo)
# - git lfs install --system: registra los hooks de LFS globalmente para
#   que, si un repo los necesita, funcionen sin sorpresas.
RUN git config --system --add safe.directory '*' \
 && git config --system init.defaultBranch main \
 && git config --system pull.rebase false \
 && git lfs install --system

# ----------------------------------------------------------------------------
# CMD: comando que se ejecuta por defecto al arrancar el contenedor
# ----------------------------------------------------------------------------
# Lanza una shell bash interactiva. Codespaces la sobrescribe con su
# propia terminal integrada de VS Code, pero es buena práctica dejarla
# definida para que la imagen sea usable también con Docker puro.
# Prompt del curso para bash
RUN chsh -s /usr/bin/zsh root

RUN cat >> /root/.zshrc <<'EOF'

PROMPT='%F{cyan}[Jeanella-Paredes]%f &F{yellow}%1~%f %(?.%F{green}✓.%F{red}x %?)%f %# '
EOF

CMD ["/bin/zsh"]




