### Fast and simple run :

```sh
docker run -d -v /path/to/root/dir:/var/www/html/  --name nginx-phpfpm -p 80:80 h0perium/nginx-phpfpm
```

** you just replace the path with your own root web folder , by default the nginx accept any domain or address on specified port (80) , you can set your own nginx config file like bellow

```sh
docker run -d -v /path/to/root/dir:/var/www/html/ -v /path/to/nginx/conf:/etc/nginx/nginx.conf --name nginx-phpfpm -p 80:80 h0perium/nginx-phpfpm
```

here is a nginx.conf example with phpfpm configs ready so you can edit it with your own configs file
```sh
events {
    worker_connections 1024;
}

http {
    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    log_format main '$remote_addr - $remote_user [$time_local] "$request" '
                    '$status $body_bytes_sent "$http_referer" '
                    '"$http_user_agent" "$http_x_forwarded_for"';

    access_log /var/log/nginx/access.log main;

    sendfile on;
    keepalive_timeout 65;

    include /etc/nginx/conf.d/*.conf;

    server {
        listen 80;
        server_name -;

        root /var/www/html;
        index index.php;

        location / {
            try_files $uri $uri/ /index.php?$query_string;
        }

        location ~ \.php$ {
            fastcgi_pass localhost:9000;
            fastcgi_index index.php;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
            include fastcgi_params;
        }
    }
}

```

