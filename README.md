# 1. Glue Job with Terraform

The idea of this project is to get files from an S3 bucket, transform it in some way and make it available in another bucket to be analysed using Athena or stored in a Data Warehouse (Redshift) using the [COPY](https://docs.aws.amazon.com/redshift/latest/dg/r_COPY.html) command.

![image](https://i.imgur.com/Mkjczfu.png)

# 2. The data

I found this [dataset](https://www.kaggle.com/datasets/shuhengmo/uber-nyc-forhire-vehicles-trip-data-2021) in Kaggle. You can find the entire documentation following the previous link. But, in short, it contains data about trips in NYC in Uber, taxis, etc.


# 3. The infrastructure

## 3.1 Terraform
In order to use Terraform firsly I went to my account, by console, and created an S3 bucket to save the `tfstate`. This is necessary to keep sensitive data regarding the infrastructure outside the repository. I wrote all the backend configuration in a `hcl` file entitled `backend.hcl`.

Then I ran `terraform init -backend=true -backend-cofig=backend.hcl` and all the buckets were set up.


 Then I created the S3 buckets that sliced data was supposed to be saved and where I wanted to save the `ipynb` file to be ran in Glue.

    resource "aws_s3_bucket" "source-bucket" {
    bucket = "903442739132-source-bucket-trips-data/year=2021/"

    }

    resource "aws_s3_bucket" "type-of-license-bucket" {
    bucket = "903442739132-type-of-license-bucket/"
    }

    resource "aws_s3_bucket" "trips-not-shared-bucket" {
    bucket = "903442739132-trips-not-shared-bucket/"
    }

    resource "aws_s3_bucket" "trips-more-than-10-dollars-bucket" {
    bucket = "903442739132-trips-more-than-10-dollars-bucket/"
    }

    resource "aws_s3_bucket" "notebooks-source" {
    bucket = "903442739132-notebooks-source/"
    }

After setting the buckets up uploaded the code into `903442739132-notebooks-source` and lastly I created the Glue Job, in the `glue.tf` file. 

    resource "aws_glue_job" "trips-etl" {
    name     = "trips-etl"
    role_arn = "glue2"

    command {
        script_location = "s3://903442739132-notebooks-source/prod.ipynb"
    }

    default_arguments = {
        "--job-language" = "python"
    }
    }


## 3.2 "Raw" data

To send the data that are saved in Kaggle into S3 as fast as possible I created a `t2.micro` EC2 instance and downloaded the parquet files using [Kaggle's API](https://www.kaggle.com/docs/api). After downloading everything I uploaded them using AWS CLI, which was pretty fast. I did everything in the console because it was a transitory process.

# 4. The code

Firstly I created a code in plain PySpark to better understand the data itself and just after I changed to a more Glue Job bound code, using dynamic dataframe. During development I used the Glue Jobs [Docker image](https://aws.amazon.com/pt/blogs/big-data/develop-and-test-aws-glue-version-3-0-jobs-locally-using-a-docker-container/).


The notebook can be found in this [link](https://github.com/luis-fnogueira/trips-data-with-glue-jobs/blob/main/jupyter_notebooks/prod.ipynb). The idea was to group all files in one dataframe (to get data from the entire year) and then slice it accordingly to some rule.