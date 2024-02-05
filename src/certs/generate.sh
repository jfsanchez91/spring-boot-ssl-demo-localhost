#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <keystore_password>"
    exit 1
fi

# Set variables
keystore_password=$1
csr_file="mycert.csr"
cn="prod.mydomain.example.com"

# Generate a keypair
keytool -genkeypair -alias mykey -keyalg RSA -keystore keystore.jks -keysize 2048 -storepass "$keystore_password" -keypass "$keystore_password" -dname "CN=$cn"

# Generate a CSR
keytool -certreq -alias mykey -keyalg RSA -file "$csr_file" -keystore keystore.jks -storepass "$keystore_password" -keypass "$keystore_password"

# Create a configuration file for OpenSSL
cat <<EOF >openssl.cnf
[req]
distinguished_name = req_distinguished_name
x509_extensions = v3_req
prompt = no

[req_distinguished_name]
CN = $cn

[v3_req]
subjectAltName = @alt_names

[alt_names]
DNS.1 = $cn
DNS.2 = localhost
EOF

# Generate the certificate
openssl x509 -req -in "$csr_file" -signkey keystore.jks -out mycert.crt -days 365 -sha256 -extfile openssl.cnf -extensions v3_req

# Import the certificate into the keystore
keytool -import -trustcacerts -alias mykey -file mycert.crt -keystore keystore.jks -storepass "$keystore_password" -noprompt -keypass "$keystore_password" -noprompt -storetype JKS

# Clean up temporary files
rm openssl.cnf
#rm "$csr_file"
