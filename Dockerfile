# Use the official lightweight Python image.
FROM python:3.9-slim

# Set the working directory.
WORKDIR /app

# Copy requirements.txt and install dependencies.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code.
COPY . .

# Expose the port on which the app runs.
EXPOSE 5000

# Run the application.
CMD ["python", "app.py"]
