sudo docker run -d -p 3000:80 nginx

sudo docker ps -a
sudo docker logs $(sudo docker ps -q -l)
