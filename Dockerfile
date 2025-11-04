# Use the latest Python image
FROM python:latest

# Set working directory inside the container
WORKDIR /app

# Install necessary system packages
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends ffmpeg curl unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Deno (if your project needs it)
RUN curl -fsSL https://deno.land/install.sh | sh \
    && ln -s /root/.deno/bin/deno /usr/local/bin/deno

# Copy requirements first (important for caching)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip \
    && pip install -r requirements.txt \
    && rm -rf /root/.cache/pip

# Copy the rest of your project files
COPY . .

# Start your app
CMD ["bash", "start"]
