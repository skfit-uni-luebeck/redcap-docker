# REDCap Docker Setup

Goal of this is to provide an easy installation of REDCap using containers and compose. 

## Installation

1. Create environment from template

```
cp env.example .env
```

Change the values, so that they fit your setup. The `DATABASE_SALT` has to be a alpha-numeric string of at least 8 characters. It will be used for pseudonymization in the data export process. This should not be changed after setup.

2. PHP Sendmail setup

REDCap sends emails using PHP Sendmail. To configure sendmail, add the sendmail parameters to the `email.ini` file.
The parameters must follow the scheme of busybox sendmail.

3. Starting containers

Start REDCap using

```
docker-compose up -d
```

Continue the setup in the browser on the port that you defined in the `.env` file.

# Initialize REDCap Database

When the initial setup form is completed, you'll get an SQL-file for initialization. Save that script to your computer and load the SQL file.

```
docker exec -it redcap-mysql mariadb -u redcap -predcap123 redcap < redcap.sql
```
Replace `redcap123` with your database password.

### After setup

1. Head to the Control Center and then to Configuration Check.
There might be some issues with write-permissions to temp and modules directories.
Fix those by setting permissions using chmod.

2. By default the user-uploaded documents folder is in a place that can be accessed by nginx. This is a security risk and should be changed. This docker setup is supposed to have this set to `/var/www/edocs`. Set this value in File Upload Settings at Local Server File Storage and hit save.