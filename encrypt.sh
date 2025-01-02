#!/bin/bash
# This is a simple file encryptor/decryptor
# Options for select
options=("Encrypt" "Decrypt")
echo "What would you like to do?:"
select option in "${options[@]}"; do
    case $option in
        "Encrypt")
            read -p "Please enter the file name: " file
            gpg -c "$file"
            echo "The file has been encrypted."
            break
            ;;
        "Decrypt")
            read -p "Please enter the file name: " file2
            gpg "$file2"
            echo "The file has been decrypted."
            break
            ;;
        *)
            echo "Invalid option."
            ;;
    esac
done
