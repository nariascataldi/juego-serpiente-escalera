// ═══════════════════════════════════════════════════════════
// LÓGICA DE PREGUNTAS Y TABLERO
// ═══════════════════════════════════════════════════════════

import { 
  PREGUNTAS_POESIA,
  PREGUNTAS_CIENCIAS_NATURALES,
  PREGUNTAS_CIENCIAS_SOCIALES,
  QUESTION_CELLS, 
  REINFORCEMENT_CELLS, 
  LADDERS, 
  SNAKES 
} from './questions_db.js';

let activeQuestionsDB = PREGUNTAS_CIENCIAS_NATURALES;

export function setTopic(topic) {
  if (topic === 'PREGUNTAS_POESIA') activeQuestionsDB = PREGUNTAS_POESIA;
  else if (topic === 'PREGUNTAS_CIENCIAS_SOCIALES') activeQuestionsDB = PREGUNTAS_CIENCIAS_SOCIALES;
  else activeQuestionsDB = PREGUNTAS_CIENCIAS_NATURALES;
}

/**
 * Obtiene la pregunta para una casilla específica
 */
export function getQuestionForCell(cellNumber, gameDifficulty) {
  // Check if it's a fixed question cell
  if (QUESTION_CELLS[cellNumber]) {
    const config = QUESTION_CELLS[cellNumber];
    const levelArray = activeQuestionsDB[config.level];
    const question = levelArray[config.fixed % levelArray.length];
    return { ...question, level: config.level };
  }
  
  // Check if it's a reinforcement cell
  if (REINFORCEMENT_CELLS.includes(cellNumber)) {
    return getRandomQuestion(gameDifficulty);
  }
  
  return null; // No question for this cell
}

/**
 * Obtiene una pregunta aleatoria según la dificultad
 */
export function getRandomQuestion(difficulty) {
  let pool = [];
  
  if (difficulty === 'easy') {
    pool = [
      ...activeQuestionsDB.easy.map(q => ({ ...q, level: 'easy' })),
      ...activeQuestionsDB.easy.map(q => ({ ...q, level: 'easy' })), 
      ...activeQuestionsDB.medium.map(q => ({ ...q, level: 'medium' })),
    ];
  } else if (difficulty === 'medium') {
    pool = [
      ...activeQuestionsDB.easy.map(q => ({ ...q, level: 'easy' })),
      ...activeQuestionsDB.medium.map(q => ({ ...q, level: 'medium' })),
      ...activeQuestionsDB.medium.map(q => ({ ...q, level: 'medium' })), 
      ...activeQuestionsDB.hard.map(q => ({ ...q, level: 'hard' })),
    ];
  } else {
    pool = [
      ...activeQuestionsDB.medium.map(q => ({ ...q, level: 'medium' })),
      ...activeQuestionsDB.hard.map(q => ({ ...q, level: 'hard' })),
      ...activeQuestionsDB.hard.map(q => ({ ...q, level: 'hard' })), 
    ];
  }
  
  return pool[Math.floor(Math.random() * pool.length)];
}

export function hasQuestion(cellNumber) {
  return QUESTION_CELLS[cellNumber] || REINFORCEMENT_CELLS.includes(cellNumber);
}

export function isLadder(cellNumber) {
  return LADDERS[cellNumber] !== undefined;
}

export function isSnake(cellNumber) {
  return SNAKES[cellNumber] !== undefined;
}

export function getCellType(cellNumber) {
  if (isLadder(cellNumber)) return 'ladder';
  if (isSnake(cellNumber)) return 'snake';
  if (hasQuestion(cellNumber)) return 'question';
  return 'normal';
}

// Re-export constants if needed
export { LADDERS, SNAKES };
