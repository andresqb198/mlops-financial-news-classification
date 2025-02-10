import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
from pyspark.sql.functions import lower, col, regexp_replace

args = getResolvedOptions(sys.argv, ['JOB_NAME'])
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

raw_df = spark.read.option("header", "true").csv("s3://amazon-reviews-raw/train.csv")

filtered_df = raw_df.filter(raw_df.polarity != 3)
clean_df = filtered_df.withColumn("text_clean", lower(col("text")))
clean_df = clean_df.withColumn("text_clean", regexp_replace(col("text_clean"), "[^a-zA-Z0-9\\s]", ""))

clean_df.write.mode("overwrite").parquet("s3://amazon-reviews-transformed/train_transformed.parquet")

job.commit()
