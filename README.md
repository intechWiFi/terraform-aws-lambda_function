# terraform-aws-lambda_copy_dbsnapshot

Creates a lambda function to copy AWS RDS snapshots

Code taken from https://github.com/yo61/lambda-copy-db-snapshot

Create the zip file using something like this:

```bash
commit=fd93300
mkdir -p tmp && \
rm -rf tmp/* && \
pushd tmp && \
curl -O https://raw.githubusercontent.com/yo61/lambda-copy-db-snapshot/$commit/index.js && \
file="../files/lambda-copy-db-snapshot-$commit.zip" && \
( [[ -e $file ]] && rm "$file" || : ) && \
zip -9 "$file" * && \
popd
```