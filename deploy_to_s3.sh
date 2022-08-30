set -e

echo "Starting deploy to S3"
hugo # To re-build static pages
hugo deploy -v # Deploy to S3

# Read secret and invalidate cache on cloudfront to resync from S3
dist_id=`cat .secret`
aws cloudfront create-invalidation --distribution-id $dist_id --paths "/*"

echo "Completed deploy"