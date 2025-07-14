# REDCap Docker Setup

Goal of this is to provide an easy installation of REDCap using containers and compose. 

## Installation

1. Create environment from template

```
cp env.example .env
```

Change the values, so that they fit your setup. The `DATABASE_SALT` has to be a alpha-numeric string of at least 8 characters. It will be used for pseudonymization in the data export process. This should not be changed after setup.

2. PHP Sendmail setup

REDCap sends emails using PHP Sendmail. PHP is configured to use msmtp for sending emails. Enter your email credentials in the msmtprc file.

3. Unpacking

Unpack the REDCap archive `redcap*.zip` in the location of this git repository (e.g. using `unzip redcap*.zip`).

4. Setting permissions

PHP runs with ther UID 82. Give PHP write access to folders for user upload, modules and temp:

```
chmod -R 700 edocs
chmod -R 700 redcap/edocs
chmod -R 700 redcap/temp
chmod -R 700 redcap/modules
chown 82:82 redcap
chown -R 82:82 edocs
chown -R 82:82 redcap/edocs
chown -R 82:82 redcap/temp
chown -R 82:82 redcap/modules
```

5. Starting containers

Start REDCap using

```
docker-compose up -d
```

Continue the setup in the browser on the port that you defined in the `.env` file.

# Initialize REDCap Database

When the initial setup form is completed, you'll get an SQL-file for initialization. Save that script to your computer and load the SQL file.

```
docker exec -i redcap-mysql mariadb -u redcap -predcap123 redcap < redcap.sql
```
Replace `redcap123` with your database password.

### After setup

1. Head to the Control Center and then to Configuration Check.

2. By default the user-uploaded documents folder is in a place that can be accessed by nginx. This is a security risk and should be changed. This docker setup is supposed to have this set to `/var/www/edocs`. Set this value in File Upload Settings at Local Server File Storage and hit save.
