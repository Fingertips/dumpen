# Dumpen

A little Ruby script that dumps MySQL and Postgres databases to file. 

## Haha, what?

The script uses regular database dump tools to create daily dumps and maintains them in a directory according to a smart strategy. So a directory might look like this:

	dumps/
		postgres/
			20141027.dump.gz
			20141103.dump.gz
			20141110.dump.gz
			20141111.dump.gz
			20141112.dump.gz
	    mysql/
			20141027.sql.gz
			20141103.sql.gz
			20141110.sql.gz
			20141111.sql.gz
			20141112.sql.gz

By default it keeps backups around from the last two mondays and the entire previous 7 days.

## So yeah…

    ./dumpen
    ./dumpen /var/lib/backups
