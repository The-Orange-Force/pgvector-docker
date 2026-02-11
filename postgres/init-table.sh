#!/bin/bash

set -e

validate_vector_dimension() {
    local dim="$1"
    
    # Check if it's a number
    if ! [[ "$dim" =~ ^[0-9]+$ ]]; then
        echo "Error: VECTOR_DIMENSION must be a positive integer, got: $dim" >&2
        return 1
    fi
    
    # Check if it's greater than 0
    if [ "$dim" -le 0 ]; then
        echo "Error: VECTOR_DIMENSION must be greater than 0, got: $dim" >&2
        return 1
    fi
    
    return 0
}

VECTOR_DIMENSION=${VECTOR_DIMENSION:-1536}

# Validate VECTOR_DIMENSION
if ! validate_vector_dimension "$VECTOR_DIMENSION"; then
    echo "Error: Invalid VECTOR_DIMENSION value: $VECTOR_DIMENSION" >&2
    exit 1
fi

DB_USER="${POSTGRES_USER:-postgres}"
DB_NAME="${POSTGRES_DB:-vectordb}"

echo "Creating items table with vector dimension: $VECTOR_DIMENSION"

# Check if table already exists
echo "Checking if table 'items' already exists..."
TABLE_EXISTS=$(psql -U "$DB_USER" -d "$DB_NAME" -tAc "SELECT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'items');")

if [ "$TABLE_EXISTS" = "t" ]; then
    echo "Table 'items' already exists. Skipping creation."
    exit 0
fi

# Create the items table
echo "Creating table with SQL command..."
PSQL_OUTPUT=$(psql -U "$DB_USER" -d "$DB_NAME" -v ON_ERROR_STOP=1 <<EOF
CREATE TABLE items (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    item_data JSONB,
    embedding vector($VECTOR_DIMENSION)
);
EOF
)

PSQL_EXIT_CODE=$?

if [ $PSQL_EXIT_CODE -eq 0 ]; then
    echo "Successfully created items table with vector dimension $VECTOR_DIMENSION"
    exit 0
else
    echo "Error: Failed to create items table. psql exit code: $PSQL_EXIT_CODE" >&2
    if [ -n "$PSQL_OUTPUT" ]; then
        echo "psql output: $PSQL_OUTPUT" >&2
    fi
    exit 1
fi