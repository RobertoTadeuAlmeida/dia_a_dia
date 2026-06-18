import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../login/view/pages/login_page.dart';
import '../../login/viewmodel/auth_viewmodel.dart';

/// Tela Home baseada no wireframe enviado.
///
/// O objetivo deste arquivo é apenas representar a interface visual.
/// Não existe integração com:
/// - ViewModel
/// - Provider
/// - Banco de dados
/// - APIs
/// - Outras camadas da aplicação
///
/// Compatível com Flutter 3.44.2.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    print(Supabase.instance.client.auth.currentSession);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      // SafeArea evita que o conteúdo fique atrás
      // da barra de status do dispositivo.
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==========================================================
              // CABEÇALHO
              // ==========================================================
              const Text(
                'Dia A Dia',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3366FF),
                ),
              ),

              const SizedBox(height: 4),

              const Text(
                'Seu dia mais organizado',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 24),


              // ==========================================================
              // CARD DE CLIMA
              // ==========================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF5B9DFF),
                      Color(0xFF6366F1),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'São Paulo',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Temperatura
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              '24°C',
                              style: TextStyle(
                                fontSize: 64,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Ensolarado',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),

                        // Ícone do clima
                        const Icon(
                          Icons.wb_sunny_outlined,
                          size: 72,
                          color: Colors.amber,
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    const Row(
                      children: [
                        Icon(
                          Icons.water_drop_outlined,
                          color: Colors.white70,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Chance de chuva: 15%',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ==========================================================
              // CARDS DE ESTATÍSTICAS
              // ==========================================================
              Row(
                children: [
                  Expanded(
                    child: _StatisticCard(
                      icon: Icons.calendar_today_outlined,
                      iconColor: Colors.blue,
                      value: '0',
                      label: 'Hoje',
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _StatisticCard(
                      icon: Icons.check_circle_outline,
                      iconColor: Colors.green,
                      value: '0',
                      label: 'Feitas',
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _StatisticCard(
                      icon: Icons.trending_up,
                      iconColor: Colors.purple,
                      value: '0%',
                      label: 'Taxa',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ==========================================================
              // PROGRESSO DO DIA
              // ==========================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Progresso de Hoje',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '0%',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Barra de progresso
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: const LinearProgressIndicator(
                        value: 0,
                        minHeight: 8,
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      '0 de 0 tarefas concluídas',
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ==========================================================
              // TÍTULO PRÓXIMAS TAREFAS
              // ==========================================================
              const Text(
                'Próximas Tarefas',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 16),

              // ==========================================================
              // CARD DE TAREFAS
              // ==========================================================
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 48),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: const Column(
                      children: [
                        Text(
                          'Nenhuma tarefa pendente',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Toque no + para criar',
                          style: TextStyle(
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Botão flutuante dentro do card
                  Positioned(
                    right: 16,
                    bottom: 16,
                    child: ElevatedButton(
                      onPressed: () async {
                        await context.read<AuthViewModel>().signOut();

                        if (!mounted) return;

                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const LoginPage(),
                          ),
                        );
                      },
                      child: const Text('Sair'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      // ==============================================================
      // BOTTOM NAVIGATION BAR
      // ==============================================================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Hoje',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: 'Concluídas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: 'Estatísticas',
          ),
        ],
      ),
    );
  }
}

///
/// Widget reutilizável para os cards de estatísticas.
///
/// Mantido no mesmo arquivo para atender ao requisito
/// de possuir apenas um único arquivo.
///
class _StatisticCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const _StatisticCard({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: iconColor,
          ),

          const Spacer(),

          Text(
            value,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            label,
            style: const TextStyle(
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}