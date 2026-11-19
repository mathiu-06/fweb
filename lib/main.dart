import 'package:flutter/material.dart';

void main() {
  runApp(const FwebApp());
}

class FwebApp extends StatelessWidget {
  const FwebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fweb',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Arial',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 800;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.auto_awesome, color: Color(0xFF6750A4)),
            SizedBox(width: 10),
            Text('fweb', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          if (isWide) ...[
            TextButton(onPressed: () {}, child: const Text('Features')),
            TextButton(onPressed: () {}, child: const Text('About')),
            const SizedBox(width: 12),
          ],
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: FilledButton(
              onPressed: () {},
              child: const Text('Get started'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 80 : 24,
                vertical: isWide ? 100 : 64,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF5F1FF), Color(0xFFE9F5FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Flex(
                    direction: isWide ? Axis.horizontal : Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: isWide
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Build something\nbeautiful for the web.',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 52,
                                height: 1.08,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF241A35),
                              ),
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              'A friendly Flutter starter page designed to help you turn your next idea into an experience people love.',
                              style: TextStyle(fontSize: 18, height: 1.5),
                            ),
                            const SizedBox(height: 32),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              alignment: isWide
                                  ? WrapAlignment.start
                                  : WrapAlignment.center,
                              children: [
                                FilledButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.arrow_forward),
                                  label: const Text('Explore the page'),
                                ),
                                OutlinedButton(
                                  onPressed: () {},
                                  child: const Text('Learn more'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (isWide) const SizedBox(width: 70),
                      const SizedBox(height: 48),
                      Container(
                        width: 280,
                        height: 280,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.75),
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x226750A4),
                              blurRadius: 30,
                              offset: Offset(0, 15),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.web_rounded,
                            size: 130,
                            color: Color(0xFF6750A4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 80 : 24,
                vertical: 72,
              ),
              child: Column(
                children: [
                  const Text(
                    'Everything you need to get started',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const Text('Simple tools. Thoughtful design. Infinite possibilities.'),
                  const SizedBox(height: 40),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: const [
                      FeatureCard(
                        icon: Icons.bolt_rounded,
                        title: 'Fast by default',
                        text: 'Create responsive experiences with Flutter.',
                      ),
                      FeatureCard(
                        icon: Icons.devices_rounded,
                        title: 'Works everywhere',
                        text: 'One codebase that looks great on every screen.',
                      ),
                      FeatureCard(
                        icon: Icons.favorite_rounded,
                        title: 'Made with care',
                        text: 'A clean foundation ready for your ideas.',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.all(24),
        child: Text('© 2026 fweb · Built with Flutter', textAlign: TextAlign.center),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  const FeatureCard({required this.icon, required this.title, required this.text, super.key});

  final IconData icon;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 36, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 18),
              Text(title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(text, style: const TextStyle(height: 1.4)),
            ],
          ),
        ),
      ),
    );
  }
}
