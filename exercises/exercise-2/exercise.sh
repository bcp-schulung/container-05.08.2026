sudo docker build -t exercise-2 .

sudo docker images

sudo docker run -d -p 3000:80 exercise-2

sudo docker ps -a
sudo docker logs $(sudo docker ps -q -l)

sudo docker ps
sudo docker exec -it $(sudo docker ps -q -l) /bin/sh

exit

sudo docker stop $(sudo docker ps -q -l)

sudo docker rm $(sudo docker ps -q -l)


# --- Persisting index.html with a volume ---
# Instead of baking index.html into the image, mount it from the host so we
# can edit it locally and the running container picks up the change.

sudo docker run -d -p 3000:80 -v $(pwd)/index.html:/usr/share/nginx/html/index.html exercise-2

sudo docker ps

# edit index.html on the host, then just refresh the page in the browser,
# no rebuild or restart needed
nano index.html

sudo docker stop $(sudo docker ps -q -l)

sudo docker rm $(sudo docker ps -q -l)
