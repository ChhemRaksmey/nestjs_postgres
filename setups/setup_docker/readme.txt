MySQL Workbench connection:
	Hostname: 127.0.0.1
	Port: 3306
	Username: root
	Password: 123456789
	Connection Method: Standard TCP/IP

If root still cannot connect, reset the MySQL data volume once:
	docker compose down -v
	docker compose up -d

That recreates the MySQL user table so the current root password is applied.