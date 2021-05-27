#!/bin/bash

# set -e

cmd="$1"

# TODO change me
migrate_tool="/migrate.linux-amd64"
infra_migrate_tool="/infra-migrate-tool"
migrate_source="file:///migrations"
# TODO use last schema version before we migration to new init system
migrate_init_version=

m_cassandra_address=${CASSANDRA_ADDRESS:-cassandra-default-0.component.svc.cluster.local}
m_cassandra_username=${CASSANDRA_USERNAME:-cassandra}
m_cassandra_password=${CASSANDRA_PASSWORD:-cassandra}
m_cassandra_keyspace=${CASSANDRA_KEYSPACE:-viper_test}

m_mysql_address=${MYSQL_ADDRESS:-mysql-default.component.svc.cluster.local}
m_mysql_username=${MYSQL_USERNAME:-root}
m_mysql_password=${MYSQL_PASSWORD:-root}
m_mysql_database=${MYSQL_DATABASE:-viper_test}

migrate_cassandra()
{
    m_cassandra_url="cassandra://$m_cassandra_address/$m_cassandra_keyspace?username=$m_cassandra_username&password=$m_cassandra_password"

    echo "migrating for cassandra, address: $m_cassandra_address, keyspace: $m_cassandra_keyspace"
    "$infra_migrate_tool" check_migrate --database="$m_cassandra_url"
    status=$?
    if [ $status -eq 10 ]; then
        echo "WARNING: schema_migrations not found, forcing version $migrate_init_version"
        "$migrate_tool" -source=$migrate_source -database="$m_cassandra_url" force $migrate_init_version || exit 1
    elif [ $status -ne 0 ]; then
            echo "failed to check schema"
            exit 1
    fi
    "$migrate_tool" -source=$migrate_source -database="$m_cassandra_url" up || exit 1
}

migrate_mysql()
{
    m_mysql_url="mysql://$m_mysql_username:$m_mysql_password@tcp($m_mysql_address)/$m_mysql_database"

    echo "migrating for mysql, address: $m_mysql_address, keyspace: $m_mysql_keyspace"
    "$migrate_tool" -source=$migrate_source -database="$m_mysql_url" up || exit 1
}

migrate()
{
    echo "Migrating filesystem..."
    echo "Migrating filesystem...Skip"
    echo "Migrating database schema..."

    # migrate_cassandra

    echo "Migrating database schema...Done"
}

cleanup() {
    echo "Cleaning up database schema..."
    echo "Cleaning up database schema...Done"
    echo "Cleaning up filesystem..."
    echo "Cleaning up filesystem...Skip"
}

# /engine-static-feature-db/migrate-linux-amd64

prompt_yes()
{
echo "Do you wish to run CLEANUP (YES/n)? "
read answer
if [ "$answer" == "YES" ] ;then
    echo "Will run CLEANUP command!"
else
    echo "Aborted..."
    exit
fi
}

echo "Init script for {{Name}}"
case "$cmd" in
    migrate) echo "Running migrate..."
        migrate
        ;;
    cleanup)
        prompt_yes
        cleanup
        ;;
    *) echo "Unknown command: $cmd"
       echo "Usage: $0 migrate/cleanup"
       exit 1
        ;;
esac


