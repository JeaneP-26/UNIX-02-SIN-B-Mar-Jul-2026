    1  cd nebula/
    2  ls
    3  ls 'l
    4  q
    5  ls nebula/
    6  cd nebula/
    7  ls nebula/
    8  cd nebula/
    9  ls -l
   10  mkdir registros
   11  mv registros bitacoras
   12  ls
   13  mkdir borradores
   14  ls
   15  git add .
   16  git commit -m "Fix problema 1: estructura de directorios corregida"
   17  git status
   18  git log --oneline
   19  ls -la
   20  git add .
   21  git commit -m "Fix problema 1: estructura de directorios corregida"
   22  mv cosmos.txt bitacoras/
   23  mv estrella.bak estrella.conf
   24  ls
   25  ls bitacoras/
   26  git add .
   27  git commit -m "Fix problema 2: archivos movidos y renombrados"
   28  chmod 640 bitacoras/cosmos.txt
   29  ls -l bitacoras/cosmos.txt
   30  git add .
   31  git commit -m "Fix problema 3: permisos numericos 640 en cosmos.txt"
   32  ls -l galaxia.sh
   33  chmod u+x galaxia.sh
   34  ls -l galaxia.sh
   35  ls -l estrella.conf 
   36  chmod o-w estrella.conf
   37  ls -l estrella.conf 
   38  git add .
   39  git commit -m "Fix problema 4: permisos simbolicos corregidos"
   40  ls -l galaxia.sh
   41  chmod u+s galaxia.sh
   42  ls -l galaxia.sh
   43  git add .
   44  git commit -m "Fix problema 5: SUID activado en galaxia.sh"
   45  git add .
   46  git commit -m "Fix problema 5: SUID activado en galaxia.sh"
   47  sudo chmod +t /tmp/nebula_zone
   48  ls -ld /tmp/nebula_zone
   49  mkdir -p /tmp/nebula_zone
   50  chmod +t /tmp/nebula_zone
   51  ls -ld /tmp/nebula_zone
   52  git add .
   53  git commit -m "Fix problema 6: sticky bit en /tmp/nebula_zone"
   54  git add .
   55  git commit -m "Fix problema 6: sticky bit en /tmp/nebula_zone"
   56  gpg --full-generate-key
   57  cd nebula
   58  gpg --full-generate-key
   59  gpg --list-keys
   60  gpg --encrypt --recipient aurora@nebula.lab bitacoras/cosmos.txt
   61  ls bitacoras
   62  git add .
   63  git commit -m "Fix problema 7: llave GPG generada y cosmos.txt cifrado"
   64  gpg --clearsign estrella.conf
   65  ls
   66  gpg --verify galaxia.sh.sig galaxia.sh
   67  gpg --detach-sign galaxia.sh
   68  gpg --verify galaxia.sh.sig galaxia.sh
   69  git add .
   70  git commit -m "Fix problema 8: firmas GPG corregidas y creadas"
   71  cd ..
   72  pwd
   73  history > prueba_history.sh
