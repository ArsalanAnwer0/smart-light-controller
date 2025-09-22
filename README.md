# Smart Light Controller

## Overview

The Smart Light Controller is a beginner-friendly project that demonstrates how to integrate a simple Flask web application with modern DevOps tools such as Docker, Terraform, Ansible, and GitHub Actions.

The project allows a user to toggle a virtual light on or off through a web interface. While the application logic is simple, the project demonstrates a complete workflow that includes:

- A Flask web application
- Docker containerization
- Terraform for provisioning AWS infrastructure
- Ansible for configuration management and deployment
- GitHub Actions for continuous integration and continuous deployment (CI/CD)

This project provides a good foundation for understanding how code, infrastructure, and automation work together in real-world DevOps environments.

## Project Structure

```
.
├── Dockerfile               # Defines the container image for the Flask app
├── ansible
│   └── playbook.yml         # Ansible playbook for configuring EC2 and running Docker
├── app
│   ├── __init__.py          # Flask app factory
│   └── main.py              # Routes and application logic
├── requirements.txt         # Python dependencies
├── static
│   └── style.css            # Stylesheet for the frontend
├── templates
│   └── index.html           # HTML template for the web interface
└── terraform
    └── main.tf              # Terraform configuration for AWS infrastructure
```

## Technologies Used

### Flask
- A lightweight Python web framework
- Hosts the web application with routes for toggling the light state

### Docker
- Packages the application into a container image
- Ensures consistent runtime environments across local machines and cloud servers

### Terraform
- Automates the provisioning of AWS EC2 instances and security groups
- Defines infrastructure as code (IaC)

### Ansible
- Configures the EC2 instance
- Installs Docker and runs the application container

### GitHub Actions
- Automates build, testing, and deployment pipelines
- Integrates Docker, Terraform, and Ansible into a CI/CD workflow

## How the Application Works

1. The application maintains a variable called `light_state`
2. When the user clicks the **Toggle Light** button, a request is sent to the server
3. The server updates `light_state` to the opposite value (ON if it was OFF, and vice versa)
4. The page updates dynamically to show the new state
5. The state is stored in memory, which means it resets if the container is restarted

## Running Locally

### Prerequisites
- Python 3.9+
- Pip (Python package manager)
- Git

### Steps

1. **Clone the repository:**
   ```bash
   git clone https://github.com/<your-username>/smart-light-controller.git
   cd smart-light-controller
   ```

2. **Create and activate a virtual environment (recommended):**
   ```bash
   python3 -m venv venv
   source venv/bin/activate   # On macOS/Linux
   venv\Scripts\activate      # On Windows
   ```

3. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

4. **Run the application:**
   ```bash
   flask --app app:create_app run
   ```

5. **Open the application in your browser:**
   ```
   http://127.0.0.1:5000
   ```

## Running with Docker

### Prerequisites
- Docker installed on your system

### Steps

1. **Build the Docker image:**
   ```bash
   docker build -t smart-light-controller .
   ```

2. **Run the container:**
   ```bash
   docker run -p 5000:5000 smart-light-controller
   ```

3. **Open the application in your browser:**
   ```
   http://127.0.0.1:5000
   ```

## Deploying to AWS

This project uses Terraform and Ansible to deploy to AWS.

### Prerequisites
- An AWS account with programmatic access enabled
- AWS CLI installed and configured (`aws configure`)
- Terraform installed
- Ansible installed

### Steps

1. **Navigate to the Terraform directory:**
   ```bash
   cd terraform
   ```

2. **Initialize Terraform:**
   ```bash
   terraform init
   ```

3. **Apply Terraform configuration to provision infrastructure:**
   ```bash
   terraform apply -auto-approve -var="key_name=your-ec2-keypair"
   ```
   > Note the public IP output by Terraform.

4. **Run the Ansible playbook to configure the instance and deploy the app:**
   ```bash
   ansible-playbook -i <public-ip>, ansible/playbook.yml --extra-vars "docker_image=yourusername/smart-light-controller:latest"
   ```

5. **Access the application in your browser:**
   ```
   http://<public-ip>:5000
   ```

## CI/CD with GitHub Actions

### Automated Workflows

**On every push to the main branch:**
- A Docker image is built and pushed to Docker Hub

**On manual trigger or release:**
- Terraform provisions infrastructure
- Ansible configures the instance and deploys the application

### Required GitHub Secrets

Configure the following secrets in your GitHub repository:

- `DOCKER_USERNAME`
- `DOCKER_PASSWORD`
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_KEY_NAME` (for EC2 key pair)

## Limitations

 **Important Considerations:**

- The light state is stored in memory, so it resets on container restart
- Security group currently allows traffic from all IPs on port 5000, which is fine for testing but not for production
- The project is designed for learning purposes.


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.