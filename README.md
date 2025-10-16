# QR Code Generator Application

[![Build and Push Docker Image](https://github.com/[YOUR_GITHUB_USERNAME]/qr-code-generator-app/actions/workflows/docker-build.yml/badge.svg)](https://github.com/[YOUR_GITHUB_USERNAME]/qr-code-generator-app/actions)

A simple yet powerful Python application that generates QR codes from URLs. This project is fully containerized using Docker, allowing for easy, consistent deployment and execution in any environment.

***

## 🚀 Features

* **URL to QR Code:** Encodes any valid URL into a `.png` QR code image.
* **URL Validation:** Ensures that only valid URLs are processed.
* **Configurable:** Customize QR code colors and the output directory using environment variables.
* **Timestamped Output:** QR codes are saved with a unique, timestamped filename to prevent overwrites.
* **Dockerized:** Runs in a secure, isolated Docker container with a non-root user for enhanced security.
* **Automated CI/CD:** A GitHub Actions workflow automatically builds and pushes the Docker image to Docker Hub on every push to the `main` branch.

***

## ✅ Prerequisites

Before you begin, ensure you have the following installed on your local machine:

* [Git](https://git-scm.com/)
* [Python 3.10+](https://www.python.org/downloads/)
* [Docker Desktop](https://www.docker.com/products/docker-desktop/)

***

## ⚙️ Local Setup and Usage (Without Docker)

To run the application directly on your machine for testing or development:

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/](https://github.com/)[YOUR_GITHUB_USERNAME]/qr-code-generator-app.git
    cd qr-code-generator-app
    ```

2.  **Create and activate a virtual environment:**
    ```bash
    # Create the environment
    python3 -m venv venv

    # Activate it (on Mac/Linux)
    source venv/bin/activate
    
    # On Windows, use: venv\Scripts\activate
    ```

3.  **Install the required dependencies:**
    ```bash
    pip install -r requirements.txt
    ```

4.  **Run the script:**
    ```bash
    python3 main.py --url "[https://www.njit.edu](https://www.njit.edu)"
    ```
    A new folder named `qr_codes` will be created in your project directory containing the generated image.

***

## 🐳 Docker Usage

The primary way to run this application is through Docker. This ensures a consistent environment and simplifies execution.

1.  **Build the Docker Image:**
    From the root of the project directory, run the `docker build` command.
    ```bash
    docker build -t qr-code-generator-app .
    ```

2.  **Run the Docker Container:**
    Use the `docker run` command to start the container. The `-v` flag is used to mount a local directory, which allows the generated QR code to be saved directly to your computer.
    ```bash
    docker run -d --name qr-generator \
      -v "$(pwd)/qr_codes":/app/qr_codes \
      qr-code-generator-app \
      --url "[https://www.google.com](https://www.google.com)"
    ```
    * `-d`: Runs the container in detached mode (in the background).
    * `--name qr-generator`: Assigns a name to the container for easy reference.
    * `-v "$(pwd)/qr_codes":/app/qr_codes`: Mounts the local `qr_codes` folder to the `/app/qr_codes` folder inside the container.

3.  **Verify Operation:**
    * **Check the logs** to see the application's output:
        ```bash
        docker logs qr-generator
        ```
    * **Check your local folder:** A new `qr_codes` folder will appear in your project directory containing the QR code for `https://www.google.com`.

4.  **Stop and Remove the Container:**
    Once you are finished, you can stop and remove the container to clean up your system.
    ```bash
    docker stop qr-generator
    docker rm qr-generator
    ```

### Using the Pre-built Image from Docker Hub

You can also run this application without building the image yourself by pulling the pre-built image directly from Docker Hub.

1.  **Pull the image:**
    ```bash
    docker pull [YOUR_DOCKERHUB_USERNAME]/qr-code-generator-app:latest
    ```

2.  **Run the container:**
    ```bash
    docker run --rm \
      -v "$(pwd)/qr_codes":/app/qr_codes \
      [YOUR_DOCKERHUB_USERNAME]/qr-code-generator-app:latest \
      --url "[https://github.com](https://github.com)"
    ```
    * `--rm`: This flag automatically removes the container when it exits.

***

## 🔧 Configuration

The application can be configured via command-line arguments or environment variables.

| Method              | Name          | Description                               | Default Value                  |
| ------------------- | ------------- | ----------------------------------------- | ------------------------------ |
| **Argument** | `--url`       | The URL to encode into the QR code.       | `http://github.com/kaw393939`  |
| **Environment Var** | `QR_CODE_DIR` | The directory to save the QR code images. | `qr_codes`                     |
| **Environment Var** | `FILL_COLOR`  | The fill color of the QR code.            | `red`                          |
| **Environment Var** | `BACK_COLOR`  | The background color of the QR code.      | `white`                        |

**Example using environment variables:**
```bash
docker run --rm \
  -v "$(pwd)/my_images":/app/qr_codes \
  -e FILL_COLOR=blue \
  -e QR_CODE_DIR=qr_codes \
  [YOUR_DOCKERHUB_USERNAME]/qr-code-generator-app:latest \
  --url "[https://www.docker.com](https://www.docker.com)"
```

***

## 🤖 Automation (CI/CD)

This repository is configured with a GitHub Actions workflow defined in `.github/workflows/docker-build.yml`. This workflow automatically triggers on any push to the `main` branch to:
1.  Check out the latest code.
2.  Log in to Docker Hub using secure secrets.
3.  Build the Docker image.
4.  Push the newly built image to Docker Hub, tagged as `latest`.


## Author
Name: Rajat Pednekar
Module: Assignment No. 7
