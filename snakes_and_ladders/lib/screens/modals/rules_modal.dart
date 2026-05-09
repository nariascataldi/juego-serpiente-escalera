import 'package:flutter/material.dart';
import '../../theme.dart';

class RulesModal extends StatelessWidget {
  final bool isVisible;
  final VoidCallback onClose;

  const RulesModal({
    super.key,
    required this.isVisible,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();

    return Container(
      color: Colors.black54,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(24),
          decoration: AppTheme.glassCard,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    '📜',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Reglas del Juego',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: onClose,
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 8),
              _buildRule(1, 'Cada jugador tira el dado en su turno.'),
              _buildRule(2, 'Al caer en una casilla con ❓, aparece una pregunta.'),
              _buildRule(3, 'Papá 👨 valida si la respuesta es correcta o no.'),
              _buildRule(4, '✅ Correcta → avanza normalmente. ❌ Incorrecta → según la regla elegida.'),
              _buildRule(5, '🪜 Escalera → ¡Sube! Responde bien para activarla.'),
              _buildRule(6, '🐍 Serpiente → ¡Baja! Solo si responde mal.'),
              _buildRule(7, '🏆 El primero en llegar a 100 gana.'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRule(int number, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$number',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}