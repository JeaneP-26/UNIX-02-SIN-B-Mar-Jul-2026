uname -a # Displays complete system information
which gpg  # Indicates the path where the gpg command is installed on the system
gpg --version # Shows the installed GPG version
gpg --full-generate-key # Starts the full process to create a key pair (public and private)
gpg --list-keys # Lists all public keys stored in the system
gpg --armor --export jeanellaparedes@gmail.com > mi_llave_publica.asc #Exports the public key in a readable format and saves it to a file
ls mi_llave_publica.asc # Verifies that the public key file has been created
gpg --armor --export # Displays all public keys in the terminal
gpg --list-secret-keys --keyid-format=long # Lists the private keys
gpg --armor --export-secret-keys 3B2DD130907A2F2E # Exports the private key
gpg --import mi_compa_llave_publica.asc # Imports my partner public key into my system
gpg --list-keys # Verifies that the imported key is in the list of public keys
$ echo "este mensaje es secreto" > doc_no_cifrado.txt # Creates a text file with an unencrypted message
ls # Lists all files
cat doc_no_cifrado.txt # Displays the content of the file without encryption
gpg --output doc_cifrado.txt --encrypt --recipient laquisnancela@gmail.com doc_no_cifrado.txt # Encrypts the file using the recipient’s public key and generates an encrypted file
gpg --decrypt doc_cifrado_1.txt #Decrypts the document sent by my partner
gpg --output doc_no_cifrado_firmado.txt --clearsign doc_no_cifrado.txt #Signs the file using GnuPG with clearsign
ls # Lists all files
cat doc_no_cifrado_firmado.txt # Displays the content of the file on screen along with its digital signature in the text.
gpg --verify doc_no_cifrado_firmado_1.txt #Verify the signature of our partner 
gpg --edit-key 9B13E2392E210FF7A3A0EF4BDFA1A9B4A5C355EE #Web of Trust to our partner
gpg --sign-key DFA1A9B4A5C355EE #Sign the key of our decision
gpg --verify doc_no_cifrado_firmado_1.txt #Return to verify the signature of our partner
gpg --output doc_no_cifrado_firmado_binario.txt --sign doc_no_cifrado.txt #Sign the document in binary
gpg --verify doc_no_cifrado_firmado_binario_1.txt #Verify the signature in binary of our partner
gpg --output firma_separada_doc_no_cifrado.sig --detach-sign doc_no_cifrado.txt #Sign a document with a separate document
gpg --verify firma_separado_doc_no_cifrado_1.sig doc_no_cifrado_1.txt #Verify the separate signature of our partner