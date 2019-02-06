#!/usr/bin/env bash

cat > index.html <<EOF
<h1>Hello, Terraform!</h1>
<p>DB address: ${db_address}</p>
<p>DB portL ${db_port}</p>
EOF

hostname >> index.html

nohup busybox httpd -f -p "${server_port}" &
