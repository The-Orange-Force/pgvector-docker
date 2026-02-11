# Installing a local instance PostgreSQL with pgVector extension

## Prerequisites
* Docker

## Configuration

## Installation

### Clone this repository
Command
```
git clone https://github.com/magnetrong/pgvector.git
```

### Configure vector dimensions

The vector dimension can be configured through the `VECTOR_DIMENSION` environment variable. By default, it is set to `1536`, which is suitable for most local models.

To customize the vector dimension:
1. Edit the `docker-compose.yml` file
2. Modify the `VECTOR_DIMENSION` value under the `environment` section

#### Pgvector dimension limits

pgvector supports different vector types, each with its own dimension limits:

* `vector` - Up to 2,000 dimensions (16,000 in raw storage)
* `halfvec` - Up to 4,000 dimensions (16,000 in raw storage)
* `bit` - Up to 64,000 dimensions
* `sparsevec` - Up to 1,000 non-zero elements

The limits above represent the maximum dimensions that can be indexed. Vectors can have up to 16,000 dimensions in raw storage, but only the first N dimensions (where N is the limit for each type) can be indexed for similarity search.

### Start the database using this command:
```
docker compose up --build
```

#### Example output

```
docker compose up --build

 ✔ Network pgvector_default  Created                                                                                                                                                   0.0s 
 ✔ Volume "pgvector_pgdata"  Created                                                                                                                                                   0.0s 
 ✔ Container pgvector-db     Created                                                                                                                                                   0.0s 
Attaching to pgvector-db
pgvector-db  | The files belonging to this database system will be owned by user "postgres".
pgvector-db  | This user must also own the server process.
pgvector-db  | 
pgvector-db  | The database cluster will be initialized with locale "en_US.utf8".
pgvector-db  | The default database encoding has accordingly been set to "UTF8".
pgvector-db  | The default text search configuration will be set to "english".
pgvector-db  | 
pgvector-db  | Data page checksums are disabled.
pgvector-db  | 
pgvector-db  | fixing permissions on existing directory /var/lib/postgresql/data ... ok
pgvector-db  | creating subdirectories ... ok
pgvector-db  | selecting dynamic shared memory implementation ... posix
pgvector-db  | selecting default "max_connections" ... 100
pgvector-db  | selecting default "shared_buffers" ... 128MB
pgvector-db  | selecting default time zone ... Etc/UTC
pgvector-db  | creating configuration files ... ok
pgvector-db  | running bootstrap script ... ok
pgvector-db  | performing post-bootstrap initialization ... ok
pgvector-db  | syncing data to disk ... ok
pgvector-db  | 
pgvector-db  | 
pgvector-db  | Success. You can now start the database server using:
pgvector-db  | 
pgvector-db  |     pg_ctl -D /var/lib/postgresql/data -l logfile start
pgvector-db  | 
pgvector-db  | initdb: warning: enabling "trust" authentication for local connections
pgvector-db  | initdb: hint: You can change this by editing pg_hba.conf or using the option -A, or --auth-local and --auth-host, the next time you run initdb.
pgvector-db  | waiting for server to start....2025-09-10 23:51:24.921 UTC [48] LOG:  starting PostgreSQL 17.6 (Debian 17.6-1.pgdg12+1) on aarch64-unknown-linux-gnu, compiled by gcc (Debian 12.2.0-14+deb12u1) 12.2.0, 64-bit
pgvector-db  | 2025-09-10 23:51:24.921 UTC [48] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
pgvector-db  | 2025-09-10 23:51:24.923 UTC [51] LOG:  database system was shut down at 2025-09-10 23:51:24 UTC
pgvector-db  | 2025-09-10 23:51:24.924 UTC [48] LOG:  database system is ready to accept connections
pgvector-db  |  done
pgvector-db  | server started
pgvector-db  | CREATE DATABASE
pgvector-db  | 
pgvector-db  | 
pgvector-db  | /usr/local/bin/docker-entrypoint.sh: running /docker-entrypoint-initdb.d/01-schema.sql
pgvector-db  | CREATE EXTENSION
pgvector-db  | 
pgvector-db  | 
pgvector-db  | /usr/local/bin/docker-entrypoint.sh: running /docker-entrypoint-initdb.d/02-init-table.sh
pgvector-db  | Creating items table with vector dimension: 1024
pgvector-db  | Checking if table 'items' already exists...
pgvector-db  | Creating table with SQL command...
pgvector-db  | Successfully created items table with vector dimension 1024
pgvector-db  | 
pgvector-db  | waiting for server to shut down...2025-09-10 23:51:25.112 UTC [48] LOG:  received fast shutdown request
pgvector-db  | .2025-09-10 23:51:25.113 UTC [48] LOG:  aborting any active transactions
pgvector-db  | 2025-09-10 23:51:25.114 UTC [48] LOG:  background worker "logical replication launcher" (PID 54) exited with exit code 1
pgvector-db  | 2025-09-10 23:51:25.114 UTC [49] LOG:  shutting down
pgvector-db  | 2025-09-10 23:51:25.115 UTC [49] LOG:  checkpoint starting: shutdown immediate
pgvector-db  | 2025-09-10 23:51:25.137 UTC [49] LOG:  checkpoint complete: wrote 952 buffers (5.8%); 0 WAL file(s) added, 0 removed, 0 recycled; write=0.005 s, sync=0.017 s, total=0.023 s; sync files=306, longest=0.004 s, average=0.001 s; distance=4639 kB, estimate=4639 kB; lsn=0/196CCF0, redo lsn=0/196CCF0
pgvector-db  | 2025-09-10 23:51:25.139 UTC [48] LOG:  database system is shut down
pgvector-db  |  done
pgvector-db  | server stopped
pgvector-db  | 
pgvector-db  | PostgreSQL init process complete; ready for start up.
pgvector-db  | 
pgvector-db  | 2025-09-10 23:51:25.231 UTC [1] LOG:  starting PostgreSQL 17.6 (Debian 17.6-1.pgdg12+1) on aarch64-unknown-linux-gnu, compiled by gcc (Debian 12.2.0-14+deb12u1) 12.2.0, 64-bit
pgvector-db  | 2025-09-10 23:51:25.231 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
pgvector-db  | 2025-09-10 23:51:25.231 UTC [1] LOG:  listening on IPv6 address "::", port 5432
pgvector-db  | 2025-09-10 23:51:25.232 UTC [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
pgvector-db  | 2025-09-10 23:51:25.234 UTC [72] LOG:  database system was shut down at 2025-09-10 23:51:25 UTC
pgvector-db  | 2025-09-10 23:51:25.235 UTC [1] LOG:  database system is ready to accept connections
```

### Verify the installation

#### Connect to the container's console
`docker exec -it pgvector-db psql -U postgres -d vectordb`

##### Expected output

```
docker exec -it pgvector-db psql -U postgres -d vectordb
psql (17.6 (Debian 17.6-1.pgdg12+1))
Type "help" for help.
```

#### Verify the extension
`\dx`

##### Expected output

```
vectordb=# \dx
                             List of installed extensions
  Name   | Version |   Schema   |                     Description                      
---------+---------+------------+------------------------------------------------------
 plpgsql | 1.0     | pg_catalog | PL/pgSQL procedural language
 vector  | 0.8.0   | public     | vector data type and ivfflat and hnsw access methods
(2 rows)
```

#### Verify the table
`\dt`

##### Expected output

```
vectordb=# \dt
         List of relations
 Schema | Name  | Type  |  Owner   
--------+-------+-------+----------
 public | items | table | postgres
(1 row)
```

#### Verify the table structure
`\d items`

##### Expected output (vector dimension may vary based on your configuration)

```
vectordb=# \d items
                                     Table "public.items"
  Column   |          Type          | Collation | Nullable |              Default              
-----------+------------------------+-----------+----------+-----------------------------------
 id        | integer                |           | not null | nextval('items_id_seq'::regclass)
 name      | character varying(255) |           | not null | 
 item_data | jsonb                  |           |          | 
 embedding | vector(1024)           |           |          | 
Indexes:
    "items_pkey" PRIMARY KEY, btree (id)
```

*Note: The vector dimension (N) will match the value you set in the `VECTOR_DIMENSION` environment variable.*

### Connect to vector database using the following configuration:
* JDBC URL: `jdbc:postgresql://localhost:5434/vectordb`
* Username: `postgres`
* Password: `password`

## Troubleshooting:

### Unable to connect to the database:
The `localhost` part in the jdbc URL might not work because the container is deployed on a separate (Docker) network stack. Or like myself, my Mendix client is inside a virtual machine on its own network stack.

I purposely decided against using the host's network stack as many of us have a PostgreSQL instance running on our machine, so the port 5432 is already in use. By deploying the container on its own network stack we can map an alternative port to the container's port (5434:5432). If you do want to use your host machine's network stack, add this line in the docker compose file "network_mode: host" in the "db" section and remove the ports sub-section.

To resolve this issue, replace `localhost` with your local IP address.
* To find your local IP address on Windows OS, use the following command in a console: `ipconfig`
    * Copy the value for the IPv4 address, typically looks something like 192.168.X.X
    * Alternatively, you can try this command in a PowerShell console `Get-NetIPAddress -InterfaceAlias "Ethernet" | Where-Object { $_.AddressFamily -eq 'IPv4' } | SelectObject -ExpandProperty IPAddress`, this command should return only your local IP address`
* To find your local IP address on Mac OS, use the following command in a console: `ifconfig en0`
    * Copy the value for the `inet` key, typically looks something like 192.168.X.X
    * Alternatively, you can try this command `ifconfig en0 | awk '/inet / {print $2}'`, this command should return only your local IP address
* Your new JDBC URL should look something like: `jdbc:postgresql://192.168.X.X:5434/vectordb`