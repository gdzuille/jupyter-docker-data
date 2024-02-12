# Jupyter data tools on Docker
## Description
Running Jupyter Notebook on Docker with the basic data processing tools.
## Tools and frameworks installed
- Pandas
- Matplotlib
- Spark (Docker with master and one worker)
- NumPy
- pytorch

Check (requirements.txt) for extra information.

Build on Python 3.8.10


## Composing the container
```shell
docker-compose up -d --build
```

## Jupyter notebook web server
For accessing jupyter notebook web server, go to [localhost:8888](localhost:8888).
As an example, check the *demo.ipynb* file.

## Starting the Spark Session
For starting the Spark Session on the notebook, start by adding the following code:

```python
from pyspark.sql import SparkSession

spark = SparkSession.\
        builder.\
        appName("pyspark-notebook-1").\
        master("spark://spark-master:7077").\
        config("spark.executor.memory", "512m").\
        getOrCreate()
```
