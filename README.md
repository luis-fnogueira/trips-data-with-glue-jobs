# 1. Glue job with Terraform

The idea of this project is to get files from an S3 bucket, transform it in some way and make it available in another bucket to be analysed using Athena or stored in a Data Warehouse (Redshift) using the [COPY](https://docs.aws.amazon.com/redshift/latest/dg/r_COPY.html) command.

![image](https://i.imgur.com/Mkjczfu.png)

# 2. The data

I found this [dataset](https://www.kaggle.com/datasets/shuhengmo/uber-nyc-forhire-vehicles-trip-data-2021) in Kaggle. You can find the entire documentation following the previous link. But, in short, it contains data about trips in NYC in Uber, taxis, etc.

# Creating buckets using Terraform
