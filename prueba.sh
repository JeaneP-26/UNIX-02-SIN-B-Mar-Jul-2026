@JeaneP-26 ➜ /workspaces/UNIX-02-SIN-B-Mar-Jul-2026/nebula (eval_p2_1_v1) $ history
    1  git clone https://github.com/JeaneP-26/UNIX-02-SIN-B-Mar-Jul-2026
    2  git remote -v
    3  git remote rename origin upstream
    4  git remote add origin https://github.com/JeaneP-26/UNIX-02-SIN-B-Mar-Jul-2026
    5  git remote -v
    6  git fetch upstream
    7  git checkout -b feature-x upstream/feature-x
    8  git fetch upstream
    9  cd nebula/
   10  ls
   11  mv registros bitacoras
   12  ls -d */
   13  cd nebula/
   14  git add .
   15  git commit -m "Fix problema 1: estructura de directorios corregida"
   16  pwd
   17  ls
   18  git add .
   19  git status
   20  git commit -m "Fix problema 1: estructura de directorios corregida"
   21  mv cosmos.txt bitacoras/
   22  mv estrella.bak estrella.conf
   23  ls
   24  ls bitacoras
   25  git add .
   26  git commit -m "Fix problema 2: archivos movidos y renombrados"
   27  chmod 640 bitacoras/cosmos.txt
   28  ls -l bitacoras/cosmos.txt
   29  git add .
   30  git commit -m "Fix problema 3: permisos numericos 640 en cosmos.txt"
   31  chmod u+x galaxia.sh
   32  chmod o-w estrella.conf
   33  ls -l galaxia.sh
   34  ls -l estrella.conf
   35  git add .
   36  git commit -m "Fix problema 4: permisos simbolicos corregidos"
   37  chmod u+s galaxia.sh
   38  ls -l galaxia.sh
   39  git add .
   40  git commit -m "Fix problema 5: SUID activado en galaxia.sh"
   41  history