sudo docker run -d -p 3000:80 nginx

sudo docker ps -a
sudo docker logs $(sudo docker ps -q -l)

sudo docker ps
sudo docker exec -it 38d3fa5d51b2 /bin/bash

apt update
apt install -y curl nano
nano /usr/share/nginx/html/index.html

exit

sudo docker stop 38d3fa5d51b2

sudo docker rm 38d3fa5d51b2