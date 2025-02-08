import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
from pyspark.sql.functions import col, lower, trim

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)

args = getResolvedOptions(sys.argv, ['S3_INPUT_PATH', 'S3_OUTPUT_PATH'])
S3_INPUT_PATH = args['S3_INPUT_PATH']
S3_OUTPUT_PATH = args['S3_OUTPUT_PATH']

print('Reading data from', S3_INPUT_PATH)
df = spark.read.option("header","true").csv(S3_INPUT_PATH)

print('Transforming data')
df_transformed = df.dropna()
df_transformed = df_transformed.withColumn('text', lower(trim(col('text'))))

print('Writing data to', S3_OUTPUT_PATH)
df_transformed.write.mode('overwrite').parquet(S3_OUTPUT_PATH)


job.commit()
print('Job finished')
