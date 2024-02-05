## How to run:
```bash
./gradlew bootRun
```

## How to test the SSL Handshake (using curl)
_**NOTE**: you may need to modify your /etc/hosts files and add the entry: `127.0.0.1   prod.mydomain.example.com` so the DNS resolution works :)_

```bash
# prod scenario
curl -v --cacert src/certs/mycert.crt https://prod.mydomain.example.com:8443/greet/test
```
output:
```text
*   Trying 127.0.0.1:8443...
* Connected to prod.mydomain.example.com (127.0.0.1) port 8443 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
*  CAfile: src/certs/mycert.crt
*  CApath: /etc/ssl/certs
* TLSv1.0 (OUT), TLS header, Certificate Status (22):
* TLSv1.3 (OUT), TLS handshake, Client hello (1):
* TLSv1.2 (IN), TLS header, Certificate Status (22):
* TLSv1.3 (IN), TLS handshake, Server hello (2):
* TLSv1.2 (IN), TLS header, Finished (20):
* TLSv1.2 (IN), TLS header, Supplemental data (23):
* TLSv1.3 (IN), TLS handshake, Encrypted Extensions (8):
* TLSv1.3 (IN), TLS handshake, Certificate (11):
* TLSv1.3 (IN), TLS handshake, CERT verify (15):
* TLSv1.3 (IN), TLS handshake, Finished (20):
* TLSv1.2 (OUT), TLS header, Finished (20):
* TLSv1.3 (OUT), TLS change cipher, Change cipher spec (1):
* TLSv1.2 (OUT), TLS header, Supplemental data (23):
* TLSv1.3 (OUT), TLS handshake, Finished (20):
* SSL connection using TLSv1.3 / TLS_AES_256_GCM_SHA384
* ALPN, server did not agree to a protocol
* Server certificate:
*  subject: CN=prod.mydomain.example.com
*  start date: Feb  5 14:03:12 2024 GMT
*  expire date: Feb  4 14:03:12 2025 GMT
*  subjectAltName: host "prod.mydomain.example.com" matched cert's "prod.mydomain.example.com"
*  issuer: CN=prod.mydomain.example.com
*  SSL certificate verify ok.
* TLSv1.2 (OUT), TLS header, Supplemental data (23):
> GET /greet/jorge HTTP/1.1
> Host: prod.mydomain.example.com:8443
> User-Agent: curl/7.81.0
> Accept: */*
> 
* TLSv1.2 (IN), TLS header, Supplemental data (23):
* TLSv1.3 (IN), TLS handshake, Newsession Ticket (4):
* TLSv1.2 (IN), TLS header, Supplemental data (23):
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 
< Content-Type: text/plain;charset=UTF-8
< Content-Length: 13
< Date: Mon, 05 Feb 2024 14:04:36 GMT
< 
* Connection #0 to host prod.mydomain.example.com left intact
Hello: test.
```

```bash
# localhost scenario
curl -v --cacert src/certs/mycert.crt https://localhost:8443/greet/test
```
output:
```text
*   Trying 127.0.0.1:8443...
* Connected to localhost (127.0.0.1) port 8443 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
*  CAfile: src/certs/mycert.crt
*  CApath: /etc/ssl/certs
* TLSv1.0 (OUT), TLS header, Certificate Status (22):
* TLSv1.3 (OUT), TLS handshake, Client hello (1):
* TLSv1.2 (IN), TLS header, Certificate Status (22):
* TLSv1.3 (IN), TLS handshake, Server hello (2):
* TLSv1.2 (IN), TLS header, Finished (20):
* TLSv1.2 (IN), TLS header, Supplemental data (23):
* TLSv1.3 (IN), TLS handshake, Encrypted Extensions (8):
* TLSv1.3 (IN), TLS handshake, Certificate (11):
* TLSv1.3 (IN), TLS handshake, CERT verify (15):
* TLSv1.3 (IN), TLS handshake, Finished (20):
* TLSv1.2 (OUT), TLS header, Finished (20):
* TLSv1.3 (OUT), TLS change cipher, Change cipher spec (1):
* TLSv1.2 (OUT), TLS header, Supplemental data (23):
* TLSv1.3 (OUT), TLS handshake, Finished (20):
* SSL connection using TLSv1.3 / TLS_AES_256_GCM_SHA384
* ALPN, server did not agree to a protocol
* Server certificate:
*  subject: CN=prod.mydomain.example.com
*  start date: Feb  5 14:03:12 2024 GMT
*  expire date: Feb  4 14:03:12 2025 GMT
*  subjectAltName: host "localhost" matched cert's "localhost"
*  issuer: CN=prod.mydomain.example.com
*  SSL certificate verify ok.
* TLSv1.2 (OUT), TLS header, Supplemental data (23):
> GET /greet/test HTTP/1.1
> Host: localhost:8443
> User-Agent: curl/7.81.0
> Accept: */*
> 
* TLSv1.2 (IN), TLS header, Supplemental data (23):
* TLSv1.3 (IN), TLS handshake, Newsession Ticket (4):
* TLSv1.2 (IN), TLS header, Supplemental data (23):
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 
< Content-Type: text/plain;charset=UTF-8
< Content-Length: 12
< Date: Mon, 05 Feb 2024 14:16:01 GMT
< 
* Connection #0 to host localhost left intact
Hello: test.
```
