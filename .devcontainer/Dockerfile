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
# BLOCK h — SHELL: switch from sh to bash for subsequent RUN steps
# ----------------------------------------------------------------------------
# By default Docker executes RUN commands with /bin/sh, a minimal POSIX
# shell that lacks many Bash features (arrays, [[ ]], process substitution,
# here-strings, etc.). Switching to bash here means any RUN instruction
# that follows can use full Bash syntax safely. — BHB Ch.1 (sh vs bash)
SHELL ["/bin/bash", "-c"]



# ----------------------------------------------------------------------------
# BLOCK i — WORKDIR: set the default working directory
# ----------------------------------------------------------------------------
# WORKDIR sets the directory that subsequent RUN, COPY, and CMD
# instructions use, and also the directory where a terminal opens when
# you attach to the container. GitHub Codespaces always mounts the
# repository at /workspaces/<repo-name>, so starting at /workspaces puts
# us one level above our course files — convenient for navigation.
WORKDIR /workspaces


# ----------------------------------------------------------------------------
# BLOCK j — Git global configuration and LFS setup
# ----------------------------------------------------------------------------
# These git config --system lines write to /etc/gitconfig, which applies
# to every user and every repository inside this container.
#
#   safe.directory '*'
#     Codespaces mounts /workspaces with a different UID than the root
#     user inside the container. By default Git refuses to operate on
#     directories owned by a different user. This setting disables that
#     check for all directories so Git works without "dubious ownership"
#     errors.
#
#   init.defaultBranch main
#     Sets "main" as the default branch name for new repositories,
#     avoiding the deprecation warning about "master".
#
#   pull.rebase false
#     When "git pull" finds diverging histories, use merge (not rebase)
#     by default. Merge is more intuitive for beginners.
#
#   git lfs install --system
#     Registers Git LFS hooks globally so that any repository that uses
#     large file storage works automatically without per-repo setup.
RUN git config --system --add safe.directory '*' \
 && git config --system init.defaultBranch main \
 && git config --system pull.rebase false \
 && git lfs install --system



# ----------------------------------------------------------------------------
# BLOCK k — Change the default shell for root to bash
# ----------------------------------------------------------------------------
# chsh -s changes the login shell for the specified user.
# Here we set /usr/bin/bash as the default shell for root, so that when
# Codespaces opens a terminal it starts bash.
# Bash is the standard shell for most Linux systems and the main shell
# used throughout this course. — BHB Ch.1 (the bash shell)
RUN chsh -s /usr/bin/bash root


# ----------------------------------------------------------------------------
# BLOCK l — Here-document: append custom prompt to .bashrc
# ----------------------------------------------------------------------------
# A here-document (heredoc) is a way to feed multiple lines of text
# directly into a command without creating a separate file. The syntax is:
#   command <<'EOF'
#   ...lines of text...
#   EOF
# Everything between the two EOF markers is passed as standard input to
# the command ("cat >>"). Using single-quoted 'EOF' tells the shell NOT
# to expand variables inside the block — the text is written literally.
# — BHB Ch.1 (redirection and standard input)
#
# We append to /root/.bashrc (the bash startup file) a function that
# customizes the prompt via PROMPT_COMMAND. The prompt shows:
#   [Jeanella-Paredes]  — student name in cyan
#   current directory   — in yellow (last component only, \W)
#   ✓ or ✗ <code>       — green checkmark if last command succeeded,
#                         red cross with exit code if it failed
#   $                   — the prompt character
RUN cat >> /root/.bashrc <<'EOF'
__set_prompt(){
    local ec=$?
    local mark
    if [ $ec -eq 0 ]; then
        mark='\[\e[32m\]✓\[\e[0m\]'
    else
        mark="\[\e[31m\]✗ $ec\[\e[0m\]"
    fi
    PS1="\[\e[36m\][Jeanella-Paredes]\[\e[0m\] \[\e[33m\]\W\[\e[0m\] $mark \$ "
}
PROMPT_COMMAND=__set_prompt
EOF