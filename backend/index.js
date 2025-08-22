const express = require('express');
const cors = require('cors');
const { v4: uuidv4 } = require('uuid');
const { createClient } = require('@supabase/supabase-js');
require('dotenv').config();

const app = express();
app.use(cors());
app.use(express.json());

const PORT = process.env.PORT || 3000;

// Initialize Supabase client using env vars
const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_KEY);

// Fetch questions from Supabase based on tier
app.get('/api/questions', async (req, res) => {
  const tier = req.query.tier || 'free';
  const quantidade = tier === 'free' ? 30 : tier === 'plus' ? 60 : 100;

  const { data, error } = await supabase
    .from('questions')
    .select('*')
    .order('id', { ascending: false })
    .limit(quantidade);

  if (error) {
    return res.status(500).json({ error: error.message });
  }

  res.json(data);
});

// Submit answers and store result in ranking
app.post('/api/submit', async (req, res) => {
  const { userId = uuidv4(), answers } = req.body;
  let correct = 0;

  for (const { questionId, selectedIndex } of answers) {
    const { data, error } = await supabase
      .from('questions')
      .select('correta')
      .eq('id', questionId)
      .single();
    if (!error && data && data.correta === selectedIndex) correct++;
  }

  const result = {
    userId,
    score: correct,
    correct,
    total: answers.length,
    timestamp: new Date()
  };

  await supabase.from('ranking').insert(result);
  res.json(result);
});

// Get ranking from Supabase
app.get('/api/ranking', async (req, res) => {
  const limit = parseInt(req.query.limit, 10) || 10;
  const { data, error } = await supabase
    .from('ranking')
    .select('*')
    .order('score', { ascending: false })
    .limit(limit);

  if (error) {
    return res.status(500).json({ error: error.message });
  }

  res.json(data);
});

app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});
