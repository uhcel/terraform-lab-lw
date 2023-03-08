# Import the necessary libraries
from google.cloud import storage

# Set the bucket and file names
bucket_name = "my-new-bucket1231123"
file_name = "plik1.txt"

# Create a client for interacting with the Cloud Storage API
storage_client = storage.Client()

# Get the bucket and file objects
bucket = storage_client.get_bucket(bucket_name)
blob = bucket.get_blob(file_name)

# Read the contents of the file into memory
content = blob.download_as_string().decode("utf-8")

# Split the content into lines and sort them
lines = content.split("\n")
lines.sort()

blob = bucket.blob("sorted.txt")

# Save the sorted lines back to the file
blob.upload_from_string("\n".join(lines))
