import os
import psycopg2

db_host = os.getenv("POSTGRESQL_HOST")
db_name = os.getenv("POSTGRESQL_DB")
db_user = os.getenv("POSTGRESQL_USER")
db_password = os.getenv("POSTGRESQL_PASSWORD")
db_port = os.getenv("POSTGRESQL_PORT", 5432)

connection = psycopg2.connect(
    host=db_host, dbname=db_name, user=db_user, password=db_password, port=db_port
)

cursor = connection.cursor()

try:
    # Create table
    cursor.execute(
        """
    CREATE TABLE IF NOT EXISTS test_table (
        id SERIAL PRIMARY KEY,
        message TEXT NOT NULL
    )
    """
    )

    # Insert data
    cursor.execute(
        "INSERT INTO test_table (message) VALUES (%s) RETURNING id",
        ("Hello, PostgreSQL!",),
    )
    inserted_id = cursor.fetchone()[0]
    connection.commit()
    print(f"Inserted row with ID: {inserted_id}")

    # Select data
    cursor.execute("SELECT id, message FROM test_table WHERE id = %s", (inserted_id,))
    row = cursor.fetchone()
    print(f"Selected row: {row}")

    # Cleanup
    cursor.execute("DROP TABLE test_table")
    connection.commit()

    try:
        cursor.execute("SELECT * FROM test_table")
    except psycopg2.errors.UndefinedTable as e:
        print("Cleanup successful: The table test_table does not exist.")
    else:
        print("Cleanup failed: The table test_table still exists.")

except Exception as e:
    connection.rollback()
    print(f"An error occurred: {e}")

finally:
    cursor.close()
    connection.close()
