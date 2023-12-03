# tug-gpt
Setup for running a custom GPT UI on top of my own API Keys

### Uses

- Uses Nginx for Reverse proxy
- lets Encrypt for SSL cert generation
- docker-compose for managing all of these stuff together.

The UI for GPT is deployed using - [ChatGPT-Next-Web](https://github.com/Yidadaa/ChatGPT-Next-Web)

### Things to do

#### Nginx.conf
- Replace `server_name` in the nginx.conf file with the actual server name like `chat.example.com`

#### docker-compose.yml
- Set Env variable value for - `OPENAI_API_KEY`
- Set Env variable value for - `CODE` - This is the password to access the app
- Update the correct path for SSL certificate folder name as it has domain name

#### How to generate Let"s Encrypt cert for Amazon Linux 2023

```bash
sudo dnf install -y augeas-libs
sudo python3 -m venv /opt/certbot/
sudo /opt/certbot/bin/pip install --upgrade pip
sudo /opt/certbot/bin/pip install certbot
sudo ln -s /opt/certbot/bin/certbot /usr/bin/certbot
```

After the installation is done, run the below command

```bash
certbot certonly --standalone -d chat.example.com
```

#### Auto renew script

- Auto renew script is present at `renew_ssl_and_restart_docker.sh`
- Configure it with a cron job. I have set it up to run every month - `0 0 1 * * /home/ec2-user/openai/renew_ssl_and_restart_docker.sh
  `

### FAQ

1. The webapp is not accessible on https

If you are deploying on AWS Lightsail or EC2, make sure you allow port 443
You can check for SSL handshake with the below command

```bash
openssl s_client -connect chat.example.com:443
```
