@echo off
set lpath=c:\xampp\htdocs\projectname-master
cd %lpath%

set username=user
set password=password
set host=host
set projectname=projectname.com

echo  %password%

git remote add production ssh://%username%@%host%/home/%username%/git/%projectname%.git
git push production +master:refs/heads/master
PAUSE 