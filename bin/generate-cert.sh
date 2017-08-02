
echo -n 'Domain: '
read domain

openssl req \
    -new \
    -newkey rsa:4096 \
    -days 365 \
    -nodes \
    -x509 \
    -subj "/C=CA/ST=Ontario/L=Toronto/O=CareGuide/CN=$domain" \
    -reqexts SAN \
    -extensions SAN \
    -config <(cat /etc/ssl/openssl.cnf \
        <(printf "\n[SAN]\nsubjectAltName=DNS:$domain")) \
    -keyout "$domain.key" \
    -out "$domain.cert"

certutil -d sql:$HOME/.pki/nssdb -A -t 'CT,c,c' -n $domain -i "$domain.cert"
