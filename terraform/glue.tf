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