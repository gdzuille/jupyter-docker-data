from pyspark.sql import SparkSession

def create_sparksession():
    """
    Initialize Spark Session
    """
    return SparkSession.builder \
        .appName('notebook') \
        .master('spark://spark-master:4040') \
        .config('spark.sql.sources.partitionColumnTypeInference.enabled', 'false') \
        .config('spark.sql.parquet.compression.codec', 'snappy') \
        .getOrCreate()
