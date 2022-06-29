# Mini Cluster

## Details
- The Docker file in the project creates a docker instance that builds the sample-app and sets the app to execute as its entry point.

- The sample-app-deployment yaml is configured to create pods for the application and expose them on port 8080 in the cluster. It is also set to start with 2 replicas. It also sets a cpu limitation on the pods which is not required but was done to help with testing.

- The ingress yaml creates an ingress for the application traffic and gives it the name simple.app to be used as a domain on the host machine.

- The scale-sample-app yaml adds scalability to the pods by setting a rule that defines a min of 2 replicas and a maximum of 10 replicas for the app. It also sets the control for scaling to be if the existing pods are averaging 75% cpu usage.

- The load-test-deployment yaml creates 2 stress testing pods that curl the sample app instances contantly in order to see if the extra load triggeres the scaling setup.

- The install script can be used to deploy the sample application using the docker image i have uploaded.

- The following command will deploy the stress test pods.
    - ```kubectl apply -f load-test-deployment.yaml```

- The following command can be used to increase the number of replicas for the stress testers.
    - ``` kubectl scale deployment/infinite-calls --replicas 8 ```

- With the moniter-server paket installed we can now see the cpu usage and replicas of the app using the following command
    - ``` kubectl get hpa ```