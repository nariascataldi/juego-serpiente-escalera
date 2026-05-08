// ═══════════════════════════════════════════════════════════
// SERPIENTES & ESCALERAS - JUEGO EDUCATIVO
// Motor principal del juego
// ═══════════════════════════════════════════════════════════

import { 
  getQuestionForCell, 
  getRandomQuestion, 
  getCellType, 
  setTopic,
  LADDERS, 
  SNAKES 
} from './questions.js';


class SnakesAndLaddersGame {
  constructor() {
    this.players = [];
    this.currentPlayerIndex = 0;
    this.difficulty = 'medium';
    this.wrongRule = 'stay';
    this.gameStarted = false;
    this.isAnimating = false;
    this.diceValue = 0;
    this.turnCount = 0;
    
    this.boardSize = 10;
    this.totalCells = 100;
    
    this.init();
  }

  // ─── INITIALIZATION ───────────────────────────
  init() {
    this.setupStartScreen();
    this.setupGameScreen();
  }

  setupStartScreen() {
    // Player add/remove buttons
    const addP2 = document.getElementById('btn-add-player2');
    const addP3 = document.getElementById('btn-add-player3');
    const addP4 = document.getElementById('btn-add-player4');
    const p2Setup = document.getElementById('player2-setup');
    const p3Setup = document.getElementById('player3-setup');
    const p4Setup = document.getElementById('player4-setup');

    addP2.addEventListener('click', () => {
      p2Setup.classList.remove('hidden');
      addP2.classList.add('hidden');
      addP3.classList.remove('hidden');
    });

    addP3.addEventListener('click', () => {
      p3Setup.classList.remove('hidden');
      addP3.classList.add('hidden');
      addP4.classList.remove('hidden');
    });

    addP4.addEventListener('click', () => {
      p4Setup.classList.remove('hidden');
      addP4.classList.add('hidden');
    });

    // Remove player buttons
    p2Setup.querySelector('.btn-remove-player')?.addEventListener('click', () => {
      p2Setup.classList.add('hidden');
      addP2.classList.remove('hidden');
      addP3.classList.add('hidden');
      p3Setup.classList.add('hidden');
      addP4.classList.add('hidden');
      p4Setup.classList.add('hidden');
      document.getElementById('player2-name').value = '';
      document.getElementById('player3-name').value = '';
      document.getElementById('player4-name').value = '';
    });

    p3Setup.querySelector('.btn-remove-player')?.addEventListener('click', () => {
      p3Setup.classList.add('hidden');
      addP3.classList.remove('hidden');
      addP4.classList.add('hidden');
      p4Setup.classList.add('hidden');
      document.getElementById('player3-name').value = '';
      document.getElementById('player4-name').value = '';
    });

    p4Setup.querySelector('.btn-remove-player')?.addEventListener('click', () => {
      p4Setup.classList.add('hidden');
      addP4.classList.remove('hidden');
      document.getElementById('player4-name').value = '';
    });

    // Start button
    document.getElementById('btn-start').addEventListener('click', () => this.startGame());
  }

  setupGameScreen() {
    const sidebar = document.querySelector('.sidebar');
    const sidebarToggle = document.getElementById('sidebar-toggle');
    const sidebarOverlay = document.createElement('div');
    sidebarOverlay.className = 'sidebar-overlay';
    document.body.appendChild(sidebarOverlay);

    const toggleSidebar = () => {
      sidebar.classList.toggle('open');
      sidebarOverlay.classList.toggle('active');
    };

    sidebarToggle?.addEventListener('click', toggleSidebar);
    sidebarOverlay?.addEventListener('click', () => {
      sidebar.classList.remove('open');
      sidebarOverlay.classList.remove('active');
    });

    document.getElementById('btn-roll').addEventListener('click', () => this.rollDice());
    document.getElementById('btn-correct').addEventListener('click', () => this.answerQuestion(true));
    document.getElementById('btn-incorrect').addEventListener('click', () => this.answerQuestion(false));
    document.getElementById('btn-hint').addEventListener('click', () => this.showHint());
    document.getElementById('btn-event-ok').addEventListener('click', () => this.closeEventModal());
    document.getElementById('btn-rules').addEventListener('click', () => this.toggleModal('rules-modal', true));
    document.getElementById('rules-close').addEventListener('click', () => this.toggleModal('rules-modal', false));
    document.getElementById('btn-restart').addEventListener('click', () => this.restartGame());
    document.getElementById('btn-play-again').addEventListener('click', () => this.restartGame());

    // Close modals on overlay click
    document.querySelectorAll('.modal-overlay').forEach(overlay => {
      overlay.addEventListener('click', (e) => {
        if (e.target === overlay && overlay.id === 'rules-modal') {
          this.toggleModal(overlay.id, false);
        }
      });
    });

    // Keyboard shortcut: space to roll dice
    document.addEventListener('keydown', (e) => {
      if (e.code === 'Space' && this.gameStarted && !this.isAnimating) {
        e.preventDefault();
        const rollBtn = document.getElementById('btn-roll');
        if (!rollBtn.disabled) {
          this.rollDice();
        }
      }
    });
  }

  // ─── GAME START ───────────────────────────────
  startGame() {
    // Gather players
    this.players = [];
    const colors = ['player1', 'player2', 'player3', 'player4'];
    const emojis = ['🔵', '🔴', '🟢', '🟡'];
    
    for (let i = 1; i <= 4; i++) {
      const nameInput = document.getElementById(`player${i}-name`);
      const setup = document.getElementById(`player${i}-setup`);
      if (setup && !setup.classList.contains('hidden')) {
        const name = nameInput.value.trim() || `Jugador ${i}`;
        this.players.push({
          id: i,
          name: name,
          position: 0, // 0 = not on board yet
          color: colors[i - 1],
          emoji: emojis[i - 1],
          correctAnswers: 0,
          wrongAnswers: 0,
          turnsPlayed: 0,
          skipNextTurn: false
        });
      }
    }

    if (this.players.length < 1) {
      // Ensure at least player 1 exists
      this.players.push({
        id: 1,
        name: `Jugador 1`,
        position: 0,
        color: colors[0],
        emoji: emojis[0],
        correctAnswers: 0,
        wrongAnswers: 0,
        turnsPlayed: 0,
        skipNextTurn: false
      });
    }

    // Get settings
    this.difficulty = document.querySelector('input[name="difficulty"]:checked').value;
    this.wrongRule = document.querySelector('input[name="wrong-rule"]:checked').value;
    const selectedTopic = document.querySelector('input[name="topic"]:checked').value;
    setTopic(selectedTopic);

    // Switch screens
    document.getElementById('start-screen').classList.remove('active');
    document.getElementById('game-screen').classList.add('active');

    this.gameStarted = true;
    this.currentPlayerIndex = 0;
    this.turnCount = 0;

    this.buildBoard();
    this.renderPlayers();
    this.updateTurnDisplay();
    this.addLog('🎮 ¡El juego ha comenzado!');
    this.addLog(`📊 Dificultad: ${this.getDifficultyLabel()}`);

    // Draw snakes and ladders after board is rendered
    requestAnimationFrame(() => {
      this.drawSnakesAndLadders();
    });
  }

  // ─── BOARD BUILD ──────────────────────────────
  buildBoard() {
    const board = document.getElementById('board');
    board.innerHTML = '';

    // Build cells in snake order (bottom-left to top-right, alternating)
    for (let row = 0; row < this.boardSize; row++) {
      for (let col = 0; col < this.boardSize; col++) {
        const cellNum = this.getCellNumber(row, col);
        const cell = document.createElement('div');
        cell.className = 'cell';
        cell.id = `cell-${cellNum}`;
        cell.dataset.cell = cellNum;

        // Cell type class
        const type = getCellType(cellNum);
        cell.classList.add(`cell-${type}`);

        // Cell number
        const numSpan = document.createElement('span');
        numSpan.className = 'cell-number';
        numSpan.textContent = cellNum;
        cell.appendChild(numSpan);

        // Cell icon
        if (type !== 'normal') {
          const icon = document.createElement('span');
          icon.className = 'cell-icon';
          if (type === 'ladder') icon.textContent = '🪜';
          else if (type === 'snake') icon.textContent = '🐍';
          else if (type === 'question') icon.textContent = '❓';
          cell.appendChild(icon);
        }

        // Special cell for 100
        if (cellNum === 100) {
          cell.classList.add('cell-goal');
          const goalIcon = document.createElement('span');
          goalIcon.className = 'cell-icon';
          goalIcon.textContent = '🏆';
          cell.appendChild(goalIcon);
        }

        // Special cell for 1
        if (cellNum === 1) {
          cell.classList.add('cell-start');
        }

        // Player tokens container
        const tokens = document.createElement('div');
        tokens.className = 'cell-tokens';
        tokens.id = `tokens-${cellNum}`;
        cell.appendChild(tokens);

        board.appendChild(cell);
      }
    }
  }

  getCellNumber(row, col) {
    // Bottom-left = 1, zigzag pattern
    const actualRow = this.boardSize - 1 - row;
    if (actualRow % 2 === 0) {
      return actualRow * this.boardSize + col + 1;
    } else {
      return actualRow * this.boardSize + (this.boardSize - 1 - col) + 1;
    }
  }

  getCellPosition(cellNum) {
    // Returns {row, col} for given cell number (for SVG drawing)
    const actualRow = Math.floor((cellNum - 1) / this.boardSize);
    const col = actualRow % 2 === 0 
      ? (cellNum - 1) % this.boardSize 
      : this.boardSize - 1 - ((cellNum - 1) % this.boardSize);
    const row = this.boardSize - 1 - actualRow;
    return { row, col };
  }

  // ─── DRAW SNAKES AND LADDERS (SVG) ───────────
  drawSnakesAndLadders() {
    const svg = document.getElementById('board-overlay');
    const board = document.getElementById('board');
    svg.innerHTML = '';

    const boardRect = board.getBoundingClientRect();
    const cellSize = boardRect.width / this.boardSize;

    svg.setAttribute('viewBox', `0 0 ${boardRect.width} ${boardRect.height}`);
    svg.style.width = boardRect.width + 'px';
    svg.style.height = boardRect.height + 'px';

    // Draw ladders
    Object.entries(LADDERS).forEach(([from, to]) => {
      const fromPos = this.getCellPosition(parseInt(from));
      const toPos = this.getCellPosition(parseInt(to));
      
      const x1 = fromPos.col * cellSize + cellSize / 2;
      const y1 = fromPos.row * cellSize + cellSize / 2;
      const x2 = toPos.col * cellSize + cellSize / 2;
      const y2 = toPos.row * cellSize + cellSize / 2;

      // Ladder rails
      const offset = cellSize * 0.12;
      const angle = Math.atan2(y2 - y1, x2 - x1);
      const perpX = Math.sin(angle) * offset;
      const perpY = -Math.cos(angle) * offset;

      // Left rail
      const rail1 = document.createElementNS('http://www.w3.org/2000/svg', 'line');
      rail1.setAttribute('x1', x1 - perpX);
      rail1.setAttribute('y1', y1 - perpY);
      rail1.setAttribute('x2', x2 - perpX);
      rail1.setAttribute('y2', y2 - perpY);
      rail1.setAttribute('class', 'ladder-rail');

      // Right rail
      const rail2 = document.createElementNS('http://www.w3.org/2000/svg', 'line');
      rail2.setAttribute('x1', x1 + perpX);
      rail2.setAttribute('y1', y1 + perpY);
      rail2.setAttribute('x2', x2 + perpX);
      rail2.setAttribute('y2', y2 + perpY);
      rail2.setAttribute('class', 'ladder-rail');

      svg.appendChild(rail1);
      svg.appendChild(rail2);

      // Rungs
      const dist = Math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2);
      const numRungs = Math.max(3, Math.floor(dist / (cellSize * 0.5)));
      for (let i = 1; i < numRungs; i++) {
        const t = i / numRungs;
        const rx = x1 + (x2 - x1) * t;
        const ry = y1 + (y2 - y1) * t;
        const rung = document.createElementNS('http://www.w3.org/2000/svg', 'line');
        rung.setAttribute('x1', rx - perpX);
        rung.setAttribute('y1', ry - perpY);
        rung.setAttribute('x2', rx + perpX);
        rung.setAttribute('y2', ry + perpY);
        rung.setAttribute('class', 'ladder-rung');
        svg.appendChild(rung);
      }
    });

    // Draw snakes
    Object.entries(SNAKES).forEach(([from, to]) => {
      const fromPos = this.getCellPosition(parseInt(from));
      const toPos = this.getCellPosition(parseInt(to));
      
      const x1 = fromPos.col * cellSize + cellSize / 2;
      const y1 = fromPos.row * cellSize + cellSize / 2;
      const x2 = toPos.col * cellSize + cellSize / 2;
      const y2 = toPos.row * cellSize + cellSize / 2;

      // Snake body as curved path
      const midX = (x1 + x2) / 2 + (Math.random() - 0.5) * cellSize * 1.5;
      const midY = (y1 + y2) / 2;
      
      const path = document.createElementNS('http://www.w3.org/2000/svg', 'path');
      const d = `M ${x1} ${y1} Q ${midX} ${midY} ${x2} ${y2}`;
      path.setAttribute('d', d);
      path.setAttribute('class', 'snake-body');
      svg.appendChild(path);

      // Snake head
      const head = document.createElementNS('http://www.w3.org/2000/svg', 'circle');
      head.setAttribute('cx', x1);
      head.setAttribute('cy', y1);
      head.setAttribute('r', cellSize * 0.1);
      head.setAttribute('class', 'snake-head');
      svg.appendChild(head);
    });
  }

  // ─── PLAYER RENDERING ────────────────────────
  renderPlayers() {
    // Clear all tokens
    document.querySelectorAll('.cell-tokens').forEach(t => t.innerHTML = '');

    // Place tokens
    this.players.forEach(player => {
      if (player.position > 0) {
        const container = document.getElementById(`tokens-${player.position}`);
        if (container) {
          const token = document.createElement('div');
          token.className = `player-token token-${player.color}`;
          token.textContent = player.emoji;
          token.title = player.name;
          container.appendChild(token);
        }
      }
    });

    // Update sidebar player list
    const list = document.getElementById('players-list');
    list.innerHTML = '';
    this.players.forEach((player, idx) => {
      const div = document.createElement('div');
      div.className = `player-card ${idx === this.currentPlayerIndex ? 'active' : ''}`;
      div.innerHTML = `
        <div class="player-card-header">
          <span class="player-card-emoji">${player.emoji}</span>
          <span class="player-card-name">${player.name}</span>
        </div>
        <div class="player-card-stats">
          <span class="stat">📍 ${player.position || 'Inicio'}</span>
          <span class="stat">✅ ${player.correctAnswers}</span>
          <span class="stat">❌ ${player.wrongAnswers}</span>
        </div>
      `;
      list.appendChild(div);
    });
  }

  updateTurnDisplay() {
    const player = this.players[this.currentPlayerIndex];
    const display = document.getElementById('current-player-name');
    display.textContent = `${player.emoji} ${player.name}`;
    display.className = `current-player-name ${player.color}`;
  }

  // ─── DICE ROLL ────────────────────────────────
  async rollDice() {
    if (this.isAnimating || !this.gameStarted) return;

    const player = this.players[this.currentPlayerIndex];
    
    // Check if player should skip turn
    if (player.skipNextTurn) {
      player.skipNextTurn = false;
      this.addLog(`⏭️ ${player.name} pierde turno.`);
      this.nextTurn();
      return;
    }

    this.isAnimating = true;
    const rollBtn = document.getElementById('btn-roll');
    rollBtn.disabled = true;

    // Dice animation
    const diceFace = document.getElementById('dice-face');
    const dice = document.getElementById('dice');
    dice.classList.add('rolling');

    const diceEmojis = ['⚀', '⚁', '⚂', '⚃', '⚄', '⚅'];

    // Animate dice
    let rolls = 0;
    const maxRolls = 15;
    const rollInterval = setInterval(() => {
      diceFace.textContent = diceEmojis[Math.floor(Math.random() * 6)];
      rolls++;
      if (rolls >= maxRolls) {
        clearInterval(rollInterval);
        
        // Final value
        this.diceValue = Math.floor(Math.random() * 6) + 1;
        diceFace.textContent = diceEmojis[this.diceValue - 1];
        dice.classList.remove('rolling');
        dice.classList.add('landed');
        setTimeout(() => dice.classList.remove('landed'), 300);

        this.addLog(`🎲 ${player.name} sacó ${this.diceValue}`);
        this.movePlayer(player);
      }
    }, 80);
  }

  // ─── PLAYER MOVEMENT ─────────────────────────
  async movePlayer(player) {
    const oldPos = player.position;
    let newPos = oldPos + this.diceValue;

    // If not on board yet, start at dice value
    if (oldPos === 0) {
      newPos = this.diceValue;
    }

    // Can't go past 100
    if (newPos > 100) {
      this.addLog(`📍 ${player.name} necesita exacto para llegar a 100. Se queda en ${oldPos}.`);
      this.isAnimating = false;
      document.getElementById('btn-roll').disabled = false;
      this.nextTurn();
      return;
    }

    // Animate step by step
    await this.animateMovement(player, oldPos, newPos);
    
    player.position = newPos;
    player.turnsPlayed++;
    this.renderPlayers();

    // Check win
    if (newPos === 100) {
      this.handleWin(player);
      return;
    }

    // Check for question, snake, or ladder
    this.handleCellEvent(player, newPos);
  }

  async animateMovement(player, fromPos, toPos) {
    const start = Math.max(1, fromPos);
    const direction = toPos > start ? 1 : -1;
    
    for (let pos = start; pos !== toPos; pos += direction) {
      player.position = pos;
      this.renderPlayers();
      await this.delay(150);
    }
    player.position = toPos;
    this.renderPlayers();
    
    // Highlight current cell
    const cell = document.getElementById(`cell-${toPos}`);
    if (cell) {
      cell.classList.add('cell-highlight');
      setTimeout(() => cell.classList.remove('cell-highlight'), 600);
    }
  }

  // ─── CELL EVENTS ─────────────────────────────
  handleCellEvent(player, cellNum) {
    const cellType = getCellType(cellNum);

    if (cellType === 'question') {
      this.showQuestion(player, cellNum, false);
    } else if (cellType === 'ladder') {
      // Ladder: show question, if correct go up
      this.pendingLadder = { from: cellNum, to: LADDERS[cellNum] };
      this.showQuestion(player, cellNum, true);
    } else if (cellType === 'snake') {
      // Snake: show question, if incorrect go down
      this.pendingSnake = { from: cellNum, to: SNAKES[cellNum] };
      this.showQuestion(player, cellNum, true);
    } else {
      // Normal cell - next turn
      this.isAnimating = false;
      document.getElementById('btn-roll').disabled = false;
      this.nextTurn();
    }
  }

  // ─── QUESTION SYSTEM ─────────────────────────
  showQuestion(player, cellNum, isSpecial) {
    const question = getQuestionForCell(cellNum, this.difficulty) || getRandomQuestion(this.difficulty);
    
    this.currentQuestion = question;
    this.currentQuestionCell = cellNum;
    this.currentQuestionSpecial = isSpecial;

    // Update modal
    const levelLabels = {
      easy: '🟢 Básico',
      medium: '🟡 Medio',
      hard: '🔴 Avanzado'
    };

    document.getElementById('question-difficulty').textContent = levelLabels[question.level] || '🟡 Medio';
    document.getElementById('question-difficulty').className = `question-difficulty ${question.level}`;
    document.getElementById('question-cell').textContent = `Casillero #${cellNum}`;
    document.getElementById('question-text').textContent = question.q;
    
    // Reset hint
    const hintEl = document.getElementById('question-hint');
    hintEl.classList.add('hidden');
    document.getElementById('hint-text').textContent = question.hint || '';
    document.getElementById('btn-hint').style.display = question.hint ? 'inline-flex' : 'none';

    this.toggleModal('question-modal', true);
  }

  showHint() {
    document.getElementById('question-hint').classList.remove('hidden');
    document.getElementById('btn-hint').style.display = 'none';
  }

  async answerQuestion(correct) {
    const player = this.players[this.currentPlayerIndex];
    this.toggleModal('question-modal', false);

    if (correct) {
      player.correctAnswers++;
      this.addLog(`✅ ${player.name} respondió correctamente.`);

      // Check if there's a pending ladder
      if (this.pendingLadder) {
        await this.delay(300);
        await this.showEventAndMove(player, 'ladder', this.pendingLadder.from, this.pendingLadder.to);
        this.pendingLadder = null;
      } else if (this.pendingSnake) {
        // Correct answer on snake = avoid it!
        this.addLog(`🛡️ ${player.name} evitó la serpiente respondiendo bien.`);
        this.pendingSnake = null;
        this.isAnimating = false;
        document.getElementById('btn-roll').disabled = false;
        this.nextTurn();
      } else {
        this.isAnimating = false;
        document.getElementById('btn-roll').disabled = false;
        this.nextTurn();
      }
    } else {
      player.wrongAnswers++;
      this.addLog(`❌ ${player.name} respondió incorrectamente.`);

      // Check if there's a pending snake
      if (this.pendingSnake) {
        await this.delay(300);
        await this.showEventAndMove(player, 'snake', this.pendingSnake.from, this.pendingSnake.to);
        this.pendingSnake = null;
      } else if (this.pendingLadder) {
        // Wrong answer on ladder = don't climb
        this.addLog(`🚫 ${player.name} no puede subir la escalera.`);
        this.pendingLadder = null;
        this.applyWrongRule(player);
      } else {
        this.applyWrongRule(player);
      }
    }
  }

  applyWrongRule(player) {
    switch (this.wrongRule) {
      case 'stay':
        this.addLog(`🛑 ${player.name} se queda en casillero ${player.position}.`);
        break;
      case 'back':
        const goBack = Math.min(player.position - 1, this.diceValue);
        if (goBack > 0) {
          player.position = Math.max(1, player.position - goBack);
          this.addLog(`🔙 ${player.name} retrocede a casillero ${player.position}.`);
          this.renderPlayers();
        }
        break;
      case 'skip':
        player.skipNextTurn = true;
        this.addLog(`⏭️ ${player.name} pierde el próximo turno.`);
        break;
    }
    this.isAnimating = false;
    document.getElementById('btn-roll').disabled = false;
    this.nextTurn();
  }

  async showEventAndMove(player, type, from, to) {
    const eventIcon = document.getElementById('event-icon');
    const eventTitle = document.getElementById('event-title');
    const eventDesc = document.getElementById('event-desc');

    if (type === 'ladder') {
      eventIcon.textContent = '🪜';
      eventTitle.textContent = '¡Escalera!';
      eventDesc.textContent = `${player.name} sube del casillero ${from} al ${to}`;
    } else {
      eventIcon.textContent = '🐍';
      eventTitle.textContent = '¡Serpiente!';
      eventDesc.textContent = `${player.name} baja del casillero ${from} al ${to}`;
    }

    this.toggleModal('event-modal', true);

    // Wait for user to click OK
    return new Promise(resolve => {
      this._eventResolve = resolve;
      this._eventPlayer = player;
      this._eventTo = to;
    });
  }

  async closeEventModal() {
    this.toggleModal('event-modal', false);
    
    if (this._eventResolve) {
      const player = this._eventPlayer;
      const to = this._eventTo;
      
      // Animate movement
      await this.animateMovement(player, player.position, to);
      player.position = to;
      this.renderPlayers();

      // Check win after movement
      if (player.position === 100) {
        this.handleWin(player);
        this._eventResolve();
        return;
      }

      this.isAnimating = false;
      document.getElementById('btn-roll').disabled = false;
      this.nextTurn();
      this._eventResolve();
    }
  }

  // ─── TURN MANAGEMENT ─────────────────────────
  nextTurn() {
    this.currentPlayerIndex = (this.currentPlayerIndex + 1) % this.players.length;
    if (this.currentPlayerIndex === 0) this.turnCount++;
    this.updateTurnDisplay();
    this.renderPlayers();
  }

  // ─── WIN ──────────────────────────────────────
  handleWin(player) {
    this.gameStarted = false;
    this.isAnimating = false;

    document.getElementById('win-player-name').textContent = `${player.emoji} ${player.name}`;

    // Stats
    const stats = document.getElementById('win-stats');
    stats.innerHTML = `
      <div class="win-stat">
        <span class="win-stat-label">Turnos jugados</span>
        <span class="win-stat-value">${player.turnsPlayed}</span>
      </div>
      <div class="win-stat">
        <span class="win-stat-label">Respuestas correctas</span>
        <span class="win-stat-value">${player.correctAnswers} ✅</span>
      </div>
      <div class="win-stat">
        <span class="win-stat-label">Respuestas incorrectas</span>
        <span class="win-stat-value">${player.wrongAnswers} ❌</span>
      </div>
      <div class="win-stat">
        <span class="win-stat-label">Precisión</span>
        <span class="win-stat-value">${player.correctAnswers + player.wrongAnswers > 0 
          ? Math.round(player.correctAnswers / (player.correctAnswers + player.wrongAnswers) * 100) 
          : 0}%</span>
      </div>
    `;

    this.toggleModal('win-modal', true);
    this.createConfetti();
  }

  createConfetti() {
    const container = document.getElementById('confetti-container');
    container.innerHTML = '';
    const colors = ['#FFD700', '#FF6B6B', '#4ECDC4', '#A78BFA', '#F97316', '#10B981'];
    
    for (let i = 0; i < 60; i++) {
      const confetti = document.createElement('div');
      confetti.className = 'confetti-piece';
      confetti.style.left = Math.random() * 100 + '%';
      confetti.style.backgroundColor = colors[Math.floor(Math.random() * colors.length)];
      confetti.style.animationDelay = Math.random() * 3 + 's';
      confetti.style.animationDuration = (2 + Math.random() * 3) + 's';
      container.appendChild(confetti);
    }
  }

  // ─── RESTART ──────────────────────────────────
  restartGame() {
    this.toggleModal('win-modal', false);
    this.gameStarted = false;
    this.isAnimating = false;
    this.currentPlayerIndex = 0;
    this.turnCount = 0;
    
    document.getElementById('game-screen').classList.remove('active');
    document.getElementById('start-screen').classList.add('active');
    document.getElementById('log-entries').innerHTML = '<div class="log-entry">🎮 ¡Juego iniciado!</div>';
  }

  // ─── UTILITIES ────────────────────────────────
  toggleModal(id, show) {
    const modal = document.getElementById(id);
    if (show) {
      this._previousFocus = document.activeElement;
      modal.classList.add('active');
      const focusable = modal.querySelector('button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])');
      if (focusable) {
        focusable.focus();
      }
    } else {
      modal.classList.remove('active');
      if (this._previousFocus) {
        this._previousFocus.focus();
        this._previousFocus = null;
      }
    }
  }

  delay(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }

  getDifficultyLabel() {
    return { easy: '🟢 Básico', medium: '🟡 Medio', hard: '🔴 Avanzado' }[this.difficulty];
  }

  addLog(message) {
    const logEntries = document.getElementById('log-entries');
    const entry = document.createElement('div');
    entry.className = 'log-entry';
    entry.textContent = message;
    logEntries.insertBefore(entry, logEntries.firstChild);
    
    // Keep only last 30 entries
    while (logEntries.children.length > 30) {
      logEntries.removeChild(logEntries.lastChild);
    }
  }
}

// ─── WINDOW RESIZE: Redraw snakes/ladders ─────
let resizeTimeout;
window.addEventListener('resize', () => {
  clearTimeout(resizeTimeout);
  resizeTimeout = setTimeout(() => {
    if (window.game && window.game.gameStarted) {
      window.game.drawSnakesAndLadders();
    }
  }, 250);
});

// ─── INITIALIZE ─────────────────────────────────
document.addEventListener('DOMContentLoaded', () => {
  window.game = new SnakesAndLaddersGame();
});
