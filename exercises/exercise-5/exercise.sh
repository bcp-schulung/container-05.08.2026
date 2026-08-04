# --- Creating a Deployment ---
# Creates a Deployment named 'ben-coeppicus' running 3 replicas of the
# stock nginx image. Kubernetes' ReplicaSet controller keeps 3 pods
# running at all times, rescheduling them if one dies or a node fails.

kubectl create deployment ben-coeppicus --image=nginx --replicas=3

# --- Checking what got created ---
# A Deployment creates a ReplicaSet, which in turn creates the Pods.

kubectl get deployments
kubectl get replicasets
kubectl get pods -o wide

# --- Exposing the Deployment ---
# Creates a Service of type NodePort in front of the 3 pods. Kubernetes
# picks a random port from the NodePort range (30000-32767 by default)
# and forwards traffic on that port, on every node, to port 80 on
# whichever pod it load-balances the request to.

kubectl expose deployment ben-coeppicus --type=NodePort --port=80

# --- Finding the NodePort and testing it ---
# The PORT(S) column looks like 80:3XXXX/TCP — the number after the
# colon is the NodePort. It's reachable on any node's IP, not just the
# one a particular pod happens to be running on.

kubectl get service ben-coeppicus

curl http://<any-node-ip>:<node-port>

# --- Scaling the Deployment ---
# Change the replica count on the fly; the Service keeps working and
# automatically load-balances across however many pods currently exist,
# no need to touch the Service at all.

kubectl scale deployment ben-coeppicus --replicas=5
kubectl get pods -o wide

# --- Inspecting things further ---

kubectl describe deployment ben-coeppicus
kubectl describe service ben-coeppicus
kubectl logs -l app=ben-coeppicus --prefix

# --- Cleaning up ---

kubectl delete service ben-coeppicus
kubectl delete deployment ben-coeppicus