# Towards an MLOps ready ML pipeline

![MLOps pipeline graph view](https://live.staticflickr.com/65535/51786424000_445a7e975a_o.jpg)

## Setting up the environment
### - Weights & Biases API key
Follow these steps to get a wandb API key
* Open an account if necessary. You can easily create one using your github credentials
* Got to the "User settings" (top right corner in the Web UI)
* Scroll down to the "API keys" section. Create or use an existing API key. 

Next, create the ```environment.env``` file with the following contents:

```WANDB_API_KEY=<YOUR API KEY>```

Keep track of where you place the ```environment.env```. We will use this environment file to run our MLflow pipeline from 
a docker container. 

### The docker siblings set-up (dind/docker-in-docker alternative)

![Docker-in-Docker](https://live.staticflickr.com/65535/51787916879_c90c62e497_o.jpg)

#### - Docker image - Pipe (mlops/pipe)
```docker build --build-arg "working_directory=$PWD" -t mlops/pipe .```
#### - Docker image - Run (mlops/run)
```docker build -t mlops/run ./base_docker```



## Pipeline steps

1. **download**.
2. **preprocess**.
3. **check_data**.
4. **segregate**.
5. **random_forest**.
6. **evaluate**.


## Run the MLflow pipeline
### Run the end-to-end pipeline
```docker run --env-file ./environment.env --rm -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):$(pwd) mlops/pipe```

### Run selected steps in the pipeline
```docker run --env-file ./environment.env --rm -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):$(pwd) -e MLFLOW_RUN_PARAMS=hydra_options="main.execute_steps='download, preprocess, check_data'" mlops/pipe```
