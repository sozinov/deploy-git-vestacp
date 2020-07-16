# deploy-git-vestacp
Deploying a project from git to a server with vestacp installed in two steps.

## setting up deployment for vestacp
1.Create a project in vestacp-> web

2.Load the bash script server.create-hook.sh to the /home/user folder

3.Run the bash script server.create-git-hook.sh from the admin user with the name of the project

  bash server.create-git-hook.sh projectname.com
   
   , where projectname.com is the name of your project created in vestacp-> web, then a repository is automatically created in the /home/user/git/projectname.com.git folder

4. For deploying the project in production, from git to the server to the /home/user/web/projectname.com/public_html folder
   (for windows) you need:
   1) Clone project from git to local machine with commit option
   2) Modify the client.deploy-to-server.bat script, namely change the values ​​of the variables to your data
         "lpath"       path to your local repository
         "username"    username on your server
         "password"    password for your user on the server
         "host"        ip or name of your server
         "projectname" is the name of your project in vestacp-> web
   3) Run the script, enter your password and the current version will appear on the server in the /home/user/web/projectname.com/public_html folder

Important!
- Before doing the deployment, your local branch must be up to date, so do git pull
- Data that is not synchronized with git will not be deleted during deployment, so your .env or other folders from .gitignore will always remain on the server
