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

Build on Python 3.11


## Docker Installation
When using Docker, you will need to install it via the [official website](https://www.docker.com/get-started/).

Navigate to the project folder via shell or in your IDE terminal.

Then compose the container by running the following command:

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
        appName("appName").\
        master("spark://spark-master:7077").\
        getOrCreate()
```
