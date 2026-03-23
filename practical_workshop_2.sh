uname -a
which gpg
gpg --version
gpg --full-generate-key
gpg --list-keys
gpg --armor --export jeanellaparedes@gmail.com > mi_llave_publica.asc
ls mi_llave_publica.asc
gpg --armor --export
gpg --list-secret-keys --keyid-format=long
gpg --armor --export-secret-keys 3B2DD130907A2F2E
gpg --import mi_compa_llave_publica.asc
gpg --list-keys
$ echo "este mensaje es secreto" > doc_no_cifrado.txt
ls 
cat doc_no_cifrado.txt
gpg --output doc_cifrado.txt --encrypt --recipient laquisnancela@gmail.com doc_no_cifrado.txt