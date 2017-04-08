# Dot-Files
Configuration files for VIM, Tmux and more

## Minimalistic and Documented
I try to make sure that all of my configuration files are documented in the case that myself or others don't remember what certain things do. This is particularly helpful with vim commands that aren't used so often or just simple refreshing oneself.

## Setting Up AWS users
start by going root (aws requires you to login as `ubuntu`), then add your user, followed by adding the ssh key to authorized
```
sudo su -
adduser nate
gpasswd -a nate sudo
exit
sudo su nate
cd ~
mkdir .ssh
chmod 700 .ssh
touch .ssh/authorized_keys
chmod 600 .ssh/authorized_keys
```
then finally paste the ssh key into the `authorized_keys` file, log out and then login with the user.

## Setting Up Digital Ocean

After initialization of the server, we need access to root.

> Click on reset root password

You will receive an email with a password

> Click on login to console

> Use `root` for username

> Use the emailed password for password

> Enter emailed password again, then enter new password followed by confirmation

```
adduser nate
gpasswd -a nate sudo
```

Then on the client, use that username and password to copy the ssh key to the server
```
ssh-copy-id nate@SERVER_IP_ADDRESS
```
## Setting Up A Mac
We need homebrew first as it's our main package manager
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install git node vim zsh tmux python reattach-to-user-namespace
```
Now we update our package manager and then install powerline-status
```
pip install --upgrade pip
pip install --user powerline-status
```
After doing so, we can copy `.tmux.conf` to the home directory.
```
curl https://raw.githubusercontent.com/NathanielInman/Dot-Files/master/.tmux.conf -o ~/.tmux.conf
curl https://raw.githubusercontent.com/NathanielInman/Dot-Files/master/.tmux.defaultLayout.conf -o ~/.tmux.defaultLayout.conf
```
Now for installing vim package manager
```
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
```
Now that Vundler is installed, we can copy the `.vimrc` to the home directory.
```
curl https://raw.githubusercontent.com/NathanielInman/Dot-Files/master/.vimrc -o ~/.vimrc
```
Open up vim and `:PluginInstall` to install all the plugins.
Now it's time to install our most important component, zsh.
```
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```
Download the personal theme to use with oh-my-zsh
```
curl https://raw.githubusercontent.com/NathanielInman/Dot-Files/master/pragmata.zsh-theme ~/.oh-my-zsh/themes/pragmata.zsh-theme
```
Now finally set up your zsh with the better one here.
```
curl https://raw.githubusercontent.com/NathanielInman/Dot-Files/master/.zshrc -o ~/.zshrc
```
## Setting up Debian
Start with Node
```
curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
sudo apt-get install -y nodejs build-essential
```
Now for Vim and package manager
```
sudo apt-get update
sudo apt-get install vim tmux git
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
```
Now that vim and Vundler are installed, we can copy the `.vimrc` to the home directory.
```
curl https://raw.githubusercontent.com/NathanielInman/Dot-Files/master/.vimrc -o ~/.vimrc
```
Finally we setup zsh
```
sudo apt-get install zsh
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```
Now finally set up your zsh with the better one here.
```
curl https://raw.githubusercontent.com/NathanielInman/Dot-Files/master/.zshrc -o ~/.zshrc
```

## Packaging
Package the distribution folder into a tarball
```
cd distFolder && tar -czvf ../dist.tar.gz . && cd ..
```
Now we will deploy to the server. Make sure to replace `$username` and `$serverip` with the correct values
```
user=$(whoami)
rsync -avhtz -e 'ssh -i /Users/$user/.ssh/id_rsa' dist.tar.gz $username@$serverip:./
```
Now for extracting the package on the server, don't forget to replace `/var/opt/applicationName` with where you want the package to go as well as `$username` and `$serverip` with the correct values. It creates the destination folder if it doesn't exist, and then extracts the package to that destination folder, removes the package and exits the server.
```
ssh -i ~/.ssh/id_rsa $username@$serverip "sudo mkdir -p /var/opt/applicationName;sudo tar -C /var/opt/applicationName -zxvf dist.tar.gz;rm dist.tar.gz"
```

## Deploying
First we need to add a watcher that will restart our application when it crashes. Make sure to change `index.js` to the entry javascript file of the application that you would normally start with `node fileName.js`.
```
sudo npm install pm2 -g
pm2 start index.js
```
Now we need to add a startup script so when the server restarts for any reason we can start the application automatically. Make sure to replace `ubuntu` with the proper linux distro. For additional information refer to `pm2 -h` for help.
```
pm2 startup ubuntu
```
This will output a command, run the command supplied to generate and initiate the script.

## Monitoring Application
The following will get uptime statistics and restart information for the application.
```
pm2 info appName
```
The following will monitor realtime statics for the CPU 
```
pm2 monit
```

## Reverse Proxy
The following will help allow public users to access the application. It will use a generic nginx location block.
```
sudo apt-get install nginx
sudo vim /etc/nginx/sites-available/default
```
replace the entire contents with the following, while replacing the ip dictated and the domain if one is already allocated to the application.
```
server {
  listen 80;

  server_name applicationDomain.com;

  location / {
    proxy_pass http://APP_IP_ADDRESS:8080;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host $host;
    proxy_cache_bypass $http_upgrade;
  }
}
```
After finished restart the nginx server.
```
sudo service nginx restart
```
## Setting up Mongodb
Start by using the official mongodb repo for apt-get
```
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
sudo apt-get update
```
Now install mongod and make sure it is running okay
```
sudo apt-get install -y mongodb-org
service mongod status
```
