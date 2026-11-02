FROM alpine:latest

# 1. Set the working directory
WORKDIR /app

# 2. Copy app.sh from your Mac into the container's /app directory
COPY app.sh .

# 3. Make sure the script has execute permissions inside Linux
RUN chmod +x app.sh

# 4. Run the script using the correct path
CMD ["./app.sh"]
