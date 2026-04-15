echo '#!bin/sh' > hola.sh
#echo '#!bin/sh' → writes literally #!bin/sh
#> → creates the file hola.sh or overwrites its content
#Result:
#cat hola.sh
# #!bin/sh

echo 'echo "Hola desde mi primer script"' >> hola.sh
#echo 'echo "Hola desde mi primer script"' → writes that line of code exactly as it is
#>> hola.sh → appends that line to the end of the hola.sh file
cat hola.sh
#Result:
# !bin/sh
# echo "Hola desde mi primer script"

./hola.sh 
#It executes the hola.sh script located in the current directory.
#Result:
#bash: ./hola.sh: Permission denied