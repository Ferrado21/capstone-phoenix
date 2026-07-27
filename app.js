const express = require('express');
const { Pool } = require('pg');

const app = express();
const port = process.env.PORT || 3000;

const pool = new Pool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT || 5432,
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  ssl: { rejectUnauthorized: false }
});

app.get('/', async (req, res) => {
  try {
    const result = await pool.query('SELECT NOW()');
    res.json({
      status: 'healthy',
      message: 'Capstone Phoenix API connected to RDS PostgreSQL!',
      db_time: result.rows[0].now
    });
  } catch (err) {
    res.status(500).json({ status: 'error', error: err.message });
  }
});

app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
