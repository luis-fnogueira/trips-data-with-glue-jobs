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

