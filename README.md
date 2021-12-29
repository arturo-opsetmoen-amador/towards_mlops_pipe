# Towards an MLOps ready ML pipeline

![MLOps pipeline graph view](https://live.staticflickr.com/65535/51784630642_39857a6b9e_o.png)

## Setting up the environment
### - Weights & Bias API key
* Get it from wandb --> image
* write it to environment.env file
* place environment.env file in root folder
### - Docker image - Pipe
```docker build --build-arg "working_directory=$PWD" -t mlops/pipe .```
### - Docker image - Run
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
```docker run --env-file ../environment.env --rm -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):$(pwd) mlops/pipe```

### Run selected steps in the pipeline
```docker run --env-file ../environment.env --rm -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):$(pwd) -e MLFLOW_RUN_PARAMS=hydra_options="main.execute_steps='download, preprocess, check_data'" mlops/pipe```
