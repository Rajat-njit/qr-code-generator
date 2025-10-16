# Use the official Python image from DockerHub as the base image
FROM python:3.12-slim-bullseye

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements.txt file and install dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Create a non-root user and directories for logs and QR codes
# Set ownership to the non-root user for security
RUN useradd -m myuser && mkdir logs qr_codes && chown myuser:myuser logs qr_codes

# Copy the rest of the application’s source code into the container
# Set ownership of the copied files to the non-root user
COPY --chown=myuser:myuser . .

# Switch to the non-root user
USER myuser

# Set the default command to run when the container starts
ENTRYPOINT ["python3", "main.py"]
CMD ["--url", "https://github.com/Rajat-njit"]