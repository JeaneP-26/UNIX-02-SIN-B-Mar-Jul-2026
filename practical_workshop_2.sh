uname -a # Muestra información completa del sistema
which gpg  # Indica la ruta donde está instalado el comando gpg en el sistema
gpg --version # Muestra la versión de GPG instalada
gpg --full-generate-key # Inicia el proceso completo para crear claves (pública y privada)
gpg --list-keys # Lista todas las claves públicas almacenadas en el sistema
gpg --armor --export jeanellaparedes@gmail.com > mi_llave_publica.asc # Exporta la clave pública en formato legible y la guarda en un archivo
ls mi_llave_publica.asc # Verifica que el archivo de la clave pública se haya creado
gpg --armor --export # Muestra todas las claves públicas en la terminal
gpg --list-secret-keys --keyid-format=long # Lista las claves privadas
gpg --armor --export-secret-keys 3B2DD130907A2F2E # Exporta la clave privada 
gpg --import mi_compa_llave_publica.asc # Importa la clave pública mi companero en mi sistema
gpg --list-keys # Verifica que la clave importada esté en la lista de claves públicas
$ echo "este mensaje es secreto" > doc_no_cifrado.txt # Crea un archivo de texto con un mensaje sin cifrar
ls # Lista los archivos
cat doc_no_cifrado.txt # Muestra el contenido del archivo sin cifrar
gpg --output doc_cifrado.txt --encrypt --recipient laquisnancela@gmail.com doc_no_cifrado.txt # Cifra el archivo usando la clave pública del destinatario y genera un archivo cifrado
gpg --decrypt doc_cifrado_1.txt #Decifra el documento enviado por mi companero
gpg --output doc_no_cifrado_firmado.txt --clearsign doc_no_cifrado.txt #Firma el archivo con gnupg/clearsign
ls # Lista todos los archivos
cat doc_no_cifrado_firmado.txt # Muestra en pantalla el contenido del archivo y su firma digital en el texto

