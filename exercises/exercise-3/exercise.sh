# --- Logging in to the shared Harbor registry ---
# 'student' is already a member of the docker group, so none of the commands
# below need sudo. Don't add sudo to some of them and not others — 'sudo
# docker login' saves credentials under root's separate ~/.docker/config.json,
# so a later plain 'docker push' (or vice versa) won't find them and fails
# with "no basic auth credentials".

docker login harbor.container.it-scholar.com
# Username: robot$seminar+students
# Password: <ask your instructor>

# --- Tagging a local image for the registry ---
# Images must be tagged as <registry-host>/<project>/<name>:<tag> before they
# can be pushed. Replace <your-name> with your own slug (e.g. ben-coeppicus)
# so everyone's images land under their own repository inside the shared
# 'seminar' project instead of overwriting each other.

docker build -t exercise-2 ../exercise-2

docker images

docker tag exercise-2:latest harbor.container.it-scholar.com/seminar/<your-name>:v1

docker images

# --- Pushing to Harbor ---

docker push harbor.container.it-scholar.com/seminar/<your-name>:v1

# --- Verifying in the Harbor UI ---
# Open https://harbor.container.it-scholar.com, browse to the 'seminar'
# project, and check that your repository and tag show up. Give it a minute
# and refresh — Trivy will scan the image and show a vulnerability report.

# --- Removing the local copy and pulling it back down ---
# Simulates using the image on a different machine.

docker rmi harbor.container.it-scholar.com/seminar/<your-name>:v1

docker images

docker pull harbor.container.it-scholar.com/seminar/<your-name>:v1

docker images

# --- Logging out ---

docker logout harbor.container.it-scholar.com
