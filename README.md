# Automated Pipeline Project

The **Automated Pipeline Project** is a web application I made to demonstrate the use of basic DevOps principles in a web development workflow. The project automates testing, building, deployment, and monitoring, integrating tools like Jenkins, Nginx, Flask, Prometheus, and Grafana to have a repeatable pipeline for a web application.

This project was developed as part of my **DEPI DevOps Training by the Egyptian Ministry of ICT**. My goal was to become familiar with DevOps practices and tools, particularly since I am interested in web development, where DevOps intersects to improve the development lifecycle.

## Project Overview

The **Automated Pipeline Project** consists of several components:

1. **Web Application (Flask App)** – A simple web app implemented using Flask.
2. **CI/CD Pipeline (Jenkins)** – Automates testing, building, and deployment.
3. **Deployment Automation** – Automates Nginx configuration, installation of dependencies, and app deployment.
4. **Monitoring** – Integrates Prometheus and Grafana to monitor the app's performance.

### How the Project Works

It integrates different processes for automating the deployment and monitoring of the Flask web application.

1. **Flask Web Application**:
   
   - The `app.py` file contains the core Flask web application with routes for the homepage and processing user input.
   - Static assets like CSS, images, and JavaScript are served from the `static/` directory.
   - Templates are stored in the `templates/` folder and rendered dynamically using Flask's `render_template` function.

2. **CI/CD Pipeline (Jenkins)**:
   
   - The `Jenkinsfile` defines a CI/CD pipeline that automates the testing, building, and deployment of the application.
   - The pipeline includes the following stages:
     - Checkout Code
     - Run Tests
     - Build App
     - Deploy
     - Clean Up

3. **Deployment Automation**:
   
   - The `deploy.sh` script automates the deployment process, including installing Nginx, setting up the Flask app, and configuring the Nginx server to serve the app.

4. **Monitoring**:
   
   - The monitoring, set up with Prometheus and Grafana, provides real-time monitoring of the app's performance.
   - The `setup_monitoring.sh` script installs and configures Prometheus and Grafana for the application.

### Folder Structure

The project is organized into the following folder structure:

```
└───AutomatedPipelineProject
    │   LICENSE
    │   README.md
    │
    ├───app
    │   │   app.py
    │   │   config.py
    │   │   requirements.txt
    │   │
    │   ├───static
    │   │   ├───css
    │   │   │       styles.css
    │   │   │
    │   │   ├───images
    │   │   │       logo.png
    │   │   │
    │   │   └───js
    │   │           scripts.js
    │   │
    │   ├───templates
    │   │       base.html
    │   │       index.html
    │   │       result.html
    │   │
    │   └───tests
    │           conftest.py
    │           test_ui.py
    │           test_unit.py
    │
    ├───ci_cd
    │   │   Jenkinsfile
    │   │
    │   └───scripts
    │           build.sh
    │           run_tests.sh
    │           start_server.sh
    │
    ├───deployment
    │   │   deploy.sh
    │   │
    │   └───webserver_config
    │           default.conf
    │
    └───monitoring
        │   prometheus.yml
        │   setup_monitoring.sh
        │
        └───grafana
            ├───dashboards
            │       cpu_memory_dashboard.json
            │
            └───datsources
                    prometheus.yml
```

## Folder Structure Breakdown

### `app/`

- **app.py**: Main Flask application logic.
- **requirements.txt**: List of Python dependencies.
- **static/**: Folder containing static files like CSS, images, and JavaScript.
- **templates/**: HTML templates used by Flask to render the views.
- **tests/**: Unit and UI tests for the application.

### `ci_cd/`

- **Jenkinsfile**: Defines the stages of the CI/CD pipeline (checkout, test, build, deploy).
- **scripts/**: Includes automation scripts for building, testing, and starting the server:
  - `build.sh`: Installs dependencies and prepares the app for deployment.
  - `run_tests.sh`: Runs unit and UI tests.
  - `start_server.sh`: Ensures the web server is running.

### `deployment/`

- **deploy.sh**: Automates the deployment process, including Nginx configuration and Python dependency installation.
- **webserver_config/**: Contains the Nginx configuration (`default.conf`).

### `monitoring/`

- **prometheus.yml**: Configuration file for Prometheus.
- **setup_monitoring.sh**: Automates the installation and setup of Prometheus and Grafana.
- **grafana/**: Contains dashboards and data source configurations for Grafana.

## Step-by-Step Walkthrough

### Prerequisites

- A **Debian-based Linux** environment.
- Basic knowledge of **Linux commands**, **Bash scripting**.

### 1. Clone the Repository

Start by cloning the project to your local machine:

```bash
git clone https://github.com/yousefonweb/AutomatedPipelineProject.git
cd AutomatedPipelineProject
```

### 2. Install Dependencies

#### For the Flask Web Application:

1. Navigate to the `app/` directory.
2. Install the Python dependencies using `pip`:

```bash
cd app
pip install -r requirements.txt
```

#### For Deployment and Monitoring:

1. Run the deployment script to install Nginx and the necessary Python dependencies.

```bash
cd deployment
./deploy.sh
```

This will set up Nginx and install the required packages (including Flask) to run the application.

2. Set up Prometheus and Grafana monitoring:

```bash
cd monitoring
./setup_monitoring.sh
```

### 3. Start the Flask Web Application

You can now start the Flask application by running the following:

```bash
cd app
python app.py
```

### 4. Set Up Jenkins CI/CD Pipeline

1. Make sure you have **Jenkins** installed and running.
2. Create a new Jenkins job, and in the **Pipeline** section, point Jenkins to the `Jenkinsfile` in the root of the project.
3. Jenkins will handle the automation of testing, building, and deployment.

### 5. Monitor the Application

After the app is running, you can view the performance metrics in **Grafana** by navigating to `http://localhost:3000` (default login: `admin/admin`). Prometheus metrics will be available at `http://localhost:9090`.
