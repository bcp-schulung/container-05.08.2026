# --- Starting the stack ---
# compose.yml defines two services (wordpress + db) plus two named volumes
# so data survives container restarts/recreation. Run this from inside the
# exercise-4 directory, since compose looks for ./compose.yml by default.

docker compose up -d

# --- Checking what's running ---

docker compose ps

docker compose logs -f wordpress
# Ctrl+C to stop following logs, the containers keep running in the background

# --- Using WordPress ---
# Open http://<your-vm-ip>:8080 in a browser and finish the WordPress setup
# wizard (choose a site title, admin user, password). The db service is only
# reachable from inside the compose network (service name "db"), not exposed
# to the host.

# --- Inspecting the containers ---

docker compose top

docker compose exec wordpress bash
ls /var/www/html
exit

docker compose exec db mysql -uexampleuser -pexamplepass exampledb
SHOW TABLES;
exit

# --- Proving the volumes persist data ---
# Recreate the containers (drops and rebuilds them) without removing the
# named volumes, then confirm the site is still configured, no setup wizard.

docker compose down
docker compose up -d
# refresh http://<your-vm-ip>:8080 — your site is still there

# --- Scaling the wordpress service ---
# Compose can run multiple replicas of a service behind the scenes (no load
# balancer here, so only one can actually bind port 8080 — remove the fixed
# host port mapping in compose.yml first if you want to try this with more
# than one replica reachable).

docker compose ps

# --- Tearing everything down ---
# 'down' stops and removes the containers + default network, but keeps the
# named volumes (wordpress/db data) around.

docker compose down

docker volume ls

# Add -v to also delete the named volumes, i.e. wipe the database and
# uploaded files for good. Only do this once you're done experimenting.

docker compose down -v

docker volume ls
