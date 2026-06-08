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
# BLOCK d — Pre-answering Wireshark's interactive prompt
# ----------------------------------------------------------------------------
# When tshark/wireshark-common is installed, the package asks:
# "Should non-superusers be able to capture packets?"
# Because we run as root inside this container, the answer is "false".
# We inject that answer in advance with debconf-set-selections so the
# installer never pauses to wait for user input. The pipe "|" connects
# the output of echo directly into debconf-set-selections as its stdin.
# — BHB Ch.1 (pipes and standard input/output)
RUN echo "wireshark-common wireshark-common/install-setuid boolean false" \
    | debconf-set-selections



# ----------------------------------------------------------------------------
# BLOCK e — RUN: the big install step
# ----------------------------------------------------------------------------
# RUN executes a shell command during the image build. The result is
# saved as a new layer. Here we install all course software in ONE single
# RUN instruction.
#
# Why one big RUN instead of many small ones?
# Every RUN creates a separate layer. Layers are additive: even if you
# delete a file in a later RUN, the bytes are still stored in the earlier
# layer, making the final image larger. Doing everything in one RUN keeps
# the image as small as possible. — BHB Ch.3 (Docker image size)
#
# Key flags:
#   apt-get update              -> refreshes the list of available packages
#                                  from the Kali repositories
#   apt-get install -y          -> installs packages; -y auto-answers "yes"
#                                  to all confirmation prompts
#   --no-install-recommends     -> installs only strictly required
#                                  dependencies, skipping optional extras
#                                  (saves hundreds of MB)
#
# The "&&" operator chains commands: the next command only runs if the
# previous one succeeded (exit code 0). If apt-get update fails, the
# install step never starts, giving us a clear error instead of a
# silently broken image. — BHB Ch.1 (exit codes) / BHB Ch.2 (flow control)
#
# The trailing "\" after each package name is line continuation — it keeps
# the list readable without breaking the single RUN instruction.
RUN apt-get update && apt-get install -y --no-install-recommends \
    \
    # === Text editors and shells ===
    # neovim / vim: terminal text editors used throughout the course.
    # zsh: Z shell, a more feature-rich alternative to bash.
    # bash-completion: adds Tab-completion hints for bash commands.
    neovim \
    vim \
    zsh \
    bash-completion \
    \
    # === Classic UNIX text-processing tools (BHB Ch.2) ===
    # These are the core of Chapter 2 — text processing in the shell.
    # perl:  scripting language with powerful regex support.
    # make:  build automation tool that reads Makefiles.
    # gawk:  GNU awk — processes structured text column by column;
    #        e.g. "awk '{print $1}'" prints the first field of each line.
    # sed:   stream editor — edits text line by line using regex;
    #        e.g. "sed 's/foo/bar/'" replaces foo with bar. — BHB Ch.2
    # grep:  searches lines matching a pattern; the most-used filter
    #        in shell pipelines. — BHB Ch.2
    perl \
    make \
    gawk \
    sed \
    grep \
    \
    # === Core UNIX utilities ===
    # coreutils: provides cat, ls, cp, mv, head, tail, sort, cut, tr...
    #            the everyday building blocks of shell scripting. — BHB Ch.1
    # findutils: provides find (search files by name/type/date) and xargs.
    # procps:    provides ps, top, kill — process management commands.
    # less:      a pager for reading long files one screen at a time.
    # tree:      displays directory contents as a visual tree.
    # jq:        parses and queries JSON from the command line;
    #            useful for working with API responses. — BHB Ch.2
    coreutils \
    findutils \
    procps \
    less \
    tree \
    jq \
    \
    # === Manual pages (the "man" command) ===
    # The base Kali image strips documentation to save space. We reinstall
    # it because "man bash", "man grep", etc. are essential references
    # during the course. — BHB Ch.1 (using man pages)
    man-db \
    manpages \
    manpages-posix \
    \
    # === Network and download utilities ===
    # curl / wget: download files or make HTTP requests from the terminal.
    # git / git-lfs: version control and large-file support for repos.
    # ca-certificates: trusted TLS certificate authorities so HTTPS works.
    # locales: the package that provides locale-gen (used further below).
    curl \
    wget \
    git \
    git-lfs \
    ca-certificates \
    locales \
    \
    # === Shell script linter ===
    # shellcheck analyzes Bash scripts and reports common mistakes,
    # bad practices, and portability issues before you even run the script.
    shellcheck \
    \
    # === Network reconnaissance and scanning ===
    # nmap:    the most widely used port and service scanner. — BHB Ch.3
    # masscan: ultra-fast scanner for large IP ranges.
    nmap \
    masscan \
    \
    # === Packet capture and analysis ===
    # tcpdump: classic command-line packet capture tool. — BHB Ch.3
    # tshark:  terminal version of Wireshark; richer protocol decoding.
    tcpdump \
    tshark \
    \
    # === Miscellaneous network utilities ===
    # netcat-traditional: reads/writes raw data over TCP/UDP ("nc").
    # socat:    like netcat but supports more protocols and options.
    # dnsutils: provides dig and nslookup for DNS queries.
    # whois:    queries domain registration information.
    # traceroute / mtr-tiny: trace the network path to a host.
    # iproute2: modern "ip" command (replaces ifconfig/route).
    # net-tools: legacy tools: ifconfig, netstat, route.
    # iputils-ping: the ping command.
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
    # === Anonymity and traffic obfuscation ===
    # tor:         connects to the Tor anonymity network.
    # torsocks:    wrapper that routes any command's traffic through Tor.
    # proxychains4: chains multiple proxies together for traffic routing.
    # obfs4proxy:  obfuscates Tor traffic to bypass censorship/blocking.
    tor \
    torsocks \
    proxychains4 \
    obfs4proxy \
    \
    # === Human-friendly HTTP client ===
    # httpie ("http" command) is easier to read than curl for learning
    # how HTTP requests and responses work.
    httpie \
    \



# --------------------------------------------------------------------------
 # BLOCK f — Enable the Spanish locale
 # --------------------------------------------------------------------------
 # /etc/locale.gen lists all available locales, each commented out by
 # default with a leading "# ". We use sed to remove that comment marker
 # from the es_ES.UTF-8 line, activating it. Then locale-gen compiles
 # the actual locale data files that programs use. — BHB Ch.2 (sed)
 && sed -i 's/# es_ES.UTF-8/es_ES.UTF-8/' /etc/locale.gen \
 && locale-gen \
 \
 # --------------------------------------------------------------------------
 # BLOCK g — Clean up cache to reduce image size
 # --------------------------------------------------------------------------
 # apt stores downloaded package files (.deb) and index lists on disk.
 # After installation those files are no longer needed, but they still
 # take up space inside the image layer.
 # "apt-get clean" removes the cached .deb files.
 # "rm -rf /var/lib/apt/lists/*" removes the package index files.
 # Doing this in the SAME RUN instruction is critical: if we did it in a
 # separate RUN, Docker would save the large files in the install layer
 # and the cleanup would only add a tiny new layer on top — the total
 # image size would not shrink. Combining them in one RUN means only the
 # final, cleaned state is stored. — BHB Ch.3 (Docker layer optimization)
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




