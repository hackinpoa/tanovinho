require "refile/backend/s3"

aws = {
  access_key_id: ENV["AWS_KEY_ID"],
  secret_access_key: ENV["AWS_ACCESS_KEY"],
  bucket: "tanovinho",
}
Refile.cache = Refile::Backend::S3.new(prefix: "cache", **aws)
Refile.store = Refile::Backend::S3.new(prefix: "store", **aws)