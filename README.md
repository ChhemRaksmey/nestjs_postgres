**********************************************************************************

git config user.name "ChhemRaksmey"
git config user.email "raksmeypolie@example.com"
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/ChhemRaksmey/nestjs_postgres.git
git push -u origin main

**********************************************************************************

Directory
  * "bootstrap_template" the original boostrap admin template
  * "setup_docker" docker config files for create
    - "MySQL", "Postgress" Database use for store data records
    - "Redis" use for application caching with third party (future update)
  * "setup_database" database setup with defaultt data records

How to run this source

  Note, Make sure you already have MySQL database for connect to this source code before below action.

  1, clone or download the source project
  2, update config file in ".env"

    PORT=3000
    DB_HOST=127.0.0.1
    DB_PORT=3306
    DB_USER=root
    DB_PASS=123456789
    DB_NAME=db_core_system

  3, open main directory then run below command

    npm run install
    npm run start:dev

  4, access to url localhost:3000



