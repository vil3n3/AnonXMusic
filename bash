# Build image
docker build -t telegram-bot .

# Run container
docker run -d --name bot telegram-bot
