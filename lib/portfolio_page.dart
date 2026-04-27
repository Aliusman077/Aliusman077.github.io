import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Single-page portfolio with anchored sections (like a Flutter web CV site).
class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scroll = ScrollController();
  final GlobalKey _kHero = GlobalKey();
  final GlobalKey _kAbout = GlobalKey();
  final GlobalKey _kJourney = GlobalKey();
  final GlobalKey _kProjects = GlobalKey();
  final GlobalKey _kSkills = GlobalKey();
  final GlobalKey _kEducation = GlobalKey();
  final GlobalKey _kConnect = GlobalKey();

  Future<void> _openUri(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeOutCubic,
        alignment: 0.05,
      );
    }
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final muted = const Color(0xFF8B9BB4);

    return Scaffold(
      body: CustomScrollView(
        controller: _scroll,
        slivers: [
          SliverLayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.crossAxisExtent > 720;
              return SliverAppBar.large(
                pinned: true,
                backgroundColor: const Color(0xDD0A0E14),
                surfaceTintColor: Colors.transparent,
                title: Text(
                  "Ali Usman",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                    letterSpacing: -0.5,
                  ),
                ),
                actions: [
                  if (wide) ...[
                    _NavText("About", () => _scrollTo(_kAbout)),
                    _NavText("Journey", () => _scrollTo(_kJourney)),
                    _NavText("Projects", () => _scrollTo(_kProjects)),
                    _NavText("Skills", () => _scrollTo(_kSkills)),
                    _NavText("Education", () => _scrollTo(_kEducation)),
                    _NavText("Connect", () => _scrollTo(_kConnect)),
                    const SizedBox(width: 12),
                  ],
                ],
              );
            },
          ),
          if (MediaQuery.sizeOf(context).width <= 720)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: [
                    _ChipNav("About", () => _scrollTo(_kAbout)),
                    _ChipNav("Journey", () => _scrollTo(_kJourney)),
                    _ChipNav("Projects", () => _scrollTo(_kProjects)),
                    _ChipNav("Skills", () => _scrollTo(_kSkills)),
                    _ChipNav("Education", () => _scrollTo(_kEducation)),
                    _ChipNav("Connect", () => _scrollTo(_kConnect)),
                  ],
                ),
              ),
            ),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _Hero(key: _kHero, cs: cs, muted: muted, onWork: () => _scrollTo(_kProjects), onContact: () => _scrollTo(_kConnect)),
                      _SectionGap(),
                      _AboutSection(key: _kAbout),
                      _SectionGap(),
                      _JourneySection(key: _kJourney),
                      _SectionGap(),
                      _ProjectsSection(key: _kProjects),
                      _SectionGap(),
                      _SkillsSection(key: _kSkills),
                      _SectionGap(),
                      _EducationSection(key: _kEducation),
                      _SectionGap(),
                      _ConnectSection(key: _kConnect, muted: muted, onGithub: () => _openUri("https://github.com/Aliusman077")),
                      const SizedBox(height: 48),
                      Text(
                        "© ${DateTime.now().year} Ali Usman · Flutter · GitHub Pages",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: muted, fontSize: 13),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionGap extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const SizedBox(height: 40);
}

class _NavText extends StatelessWidget {
  const _NavText(this.label, this.onTap);
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
    );
  }
}

class _ChipNav extends StatelessWidget {
  const _ChipNav(this.label, this.onTap);
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(label),
      onPressed: onTap,
      visualDensity: VisualDensity.compact,
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({
    super.key,
    required this.cs,
    required this.muted,
    required this.onWork,
    required this.onContact,
  });

  final ColorScheme cs;
  final Color muted;
  final VoidCallback onWork;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 40),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0x14FFFFFF))),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0x2E3DD6C6),
            Color(0x000A0E14),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ali Usman",
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            "Developer — replace with your headline (web, mobile, student, etc.).",
            style: TextStyle(fontSize: 18, color: muted, height: 1.45),
          ),
          const SizedBox(height: 12),
          Text(
            "Edit this line: years · projects · what you care about.",
            style: TextStyle(color: muted, fontSize: 15),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton(
                onPressed: onWork,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                ),
                child: const Text("View my work"),
              ),
              OutlinedButton(
                onPressed: onContact,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                ),
                child: const Text("Contact me"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title, this.subtitle);
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final muted = const Color(0xFF8B9BB4);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        Text(subtitle, style: TextStyle(color: muted, height: 1.5)),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          "About me",
          "Short intro about who you are and what you build. Replace this copy with your story.",
        ),
        LayoutBuilder(
          builder: (context, c) {
            final cols = c.maxWidth > 900 ? 3 : (c.maxWidth > 560 ? 2 : 1);
            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: cols,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.25,
              children: const [
                _InfoCard(
                  title: "Focus",
                  body: "Your main stack or role — frontend, backend, mobile, etc.",
                ),
                _InfoCard(
                  title: "How I work",
                  body: "How you like to collaborate and ship quality.",
                ),
                _InfoCard(
                  title: "Impact",
                  body: "Add measurable wins when you have them.",
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.body});
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final muted = const Color(0xFF8B9BB4);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 8),
            Expanded(child: Text(body, style: TextStyle(color: muted, height: 1.45, fontSize: 14))),
          ],
        ),
      ),
    );
  }
}

class _JourneySection extends StatelessWidget {
  const _JourneySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          "Professional journey",
          "Replace with your roles. Each block is a job or internship.",
        ),
        const _JobBlock(
          title: "Your role title",
          meta: "Company · 20XX – Present · City",
          summary: "One line about the team or product.",
          bullets: [
            "Achievement or responsibility you are proud of.",
            "Another bullet with numbers if you can.",
          ],
          tags: ["Stack", "Tool"],
        ),
        const SizedBox(height: 12),
        const _JobBlock(
          title: "Previous role",
          meta: "Company · 20XX – 20XX",
          summary: "",
          bullets: ["What you shipped or learned."],
          tags: ["Add tags"],
        ),
      ],
    );
  }
}

class _JobBlock extends StatelessWidget {
  const _JobBlock({
    required this.title,
    required this.meta,
    required this.summary,
    required this.bullets,
    required this.tags,
  });

  final String title;
  final String meta;
  final String summary;
  final List<String> bullets;
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    final muted = const Color(0xFF8B9BB4);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(meta, textAlign: TextAlign.end, style: TextStyle(color: muted, fontSize: 13)),
                ),
              ],
            ),
            if (summary.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(summary, style: TextStyle(color: muted, fontSize: 14)),
            ],
            const SizedBox(height: 10),
            ...bullets.map(
              (b) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("• ", style: TextStyle(color: muted)),
                    Expanded(child: Text(b, style: TextStyle(color: muted, height: 1.45))),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: tags.map((t) => _Tag(t)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0x263DD6C6),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF3DD6C6),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ProjectsSection extends StatelessWidget {
  const _ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          "Featured projects",
          "Link titles to GitHub, demos, or store listings when you have URLs.",
        ),
        LayoutBuilder(
          builder: (context, c) {
            final cols = c.maxWidth > 900 ? 3 : (c.maxWidth > 560 ? 2 : 1);
            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: cols,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.05,
              children: const [
                _ProjectCard(
                  badge: "Project",
                  name: "Project name",
                  desc: "What it does and your part in it.",
                  tags: ["Flutter", "Web"],
                ),
                _ProjectCard(
                  badge: "Project",
                  name: "Another build",
                  desc: "Short description. Add a URL launcher later if you want.",
                  tags: ["Dart"],
                ),
                _ProjectCard(
                  badge: "Learning",
                  name: "Course or hackathon",
                  desc: "Show learning work while you grow your list.",
                  tags: ["Team"],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({
    required this.badge,
    required this.name,
    required this.desc,
    required this.tags,
  });

  final String badge;
  final String name;
  final String desc;
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    final muted = const Color(0xFF8B9BB4);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              badge.toUpperCase(),
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: Color(0xFF3DD6C6),
              ),
            ),
            const SizedBox(height: 6),
            Text(name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 8),
            Expanded(child: Text(desc, style: TextStyle(color: muted, height: 1.45, fontSize: 14))),
            const SizedBox(height: 8),
            Wrap(spacing: 6, runSpacing: 6, children: tags.map((t) => _Tag(t)).toList()),
          ],
        ),
      ),
    );
  }
}

class _SkillsSection extends StatelessWidget {
  const _SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          "Technical expertise",
          "Grouped skills — rename groups and chips to match what you use.",
        ),
        LayoutBuilder(
          builder: (context, c) {
            final two = c.maxWidth > 640;
            final children = [
              _SkillGroup(title: "Languages", tags: const ["Dart", "JavaScript", "Python"]),
              _SkillGroup(title: "Flutter & web", tags: const ["Flutter", "Material 3", "HTML", "CSS"]),
              _SkillGroup(title: "Tools", tags: const ["Git", "GitHub", "VS Code"]),
              _SkillGroup(title: "Soft skills", tags: const ["Communication", "Teamwork"]),
            ];
            if (two) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Column(children: [children[0], const SizedBox(height: 12), children[2]])),
                  const SizedBox(width: 12),
                  Expanded(child: Column(children: [children[1], const SizedBox(height: 12), children[3]])),
                ],
              );
            }
            return Column(children: [...children.map((w) => Padding(padding: const EdgeInsets.only(bottom: 12), child: w))]);
          },
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, c) {
            final w = (c.maxWidth - 36) / 4;
            final cell = w.clamp(120.0, 200.0);
            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _Metric(cell, "—", "Years"),
                _Metric(cell, "—", "Projects"),
                _Metric(cell, "—", "Stat"),
                _Metric(cell, "—", "Stat"),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _SkillGroup extends StatelessWidget {
  const _SkillGroup({required this.title, required this.tags});
  final String title;
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    final muted = const Color(0xFF8B9BB4);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: muted, fontWeight: FontWeight.w600, fontSize: 13)),
            const SizedBox(height: 10),
            Wrap(spacing: 8, runSpacing: 8, children: tags.map((t) => _Tag(t)).toList()),
          ],
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric(this.width, this.value, this.label);
  final double width;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final muted = const Color(0xFF8B9BB4);
    return SizedBox(
      width: width,
      child: Card(
        color: const Color(0x263DD6C6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0x403DD6C6)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
          child: Column(
            children: [
              Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Color(0xFF3DD6C6))),
              const SizedBox(height: 4),
              Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: muted)),
            ],
          ),
        ),
      ),
    );
  }
}

class _EducationSection extends StatelessWidget {
  const _EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          "Education",
          "Degrees, bootcamps, or self-directed learning you want to highlight.",
        ),
        const _JobBlock(
          title: "Your degree or program",
          meta: "Institution · 20XX – 20XX",
          summary: "Thesis, favourite courses, or projects — optional.",
          bullets: [],
          tags: ["Topic"],
        ),
      ],
    );
  }
}

class _ConnectSection extends StatelessWidget {
  const _ConnectSection({super.key, required this.muted, required this.onGithub});
  final Color muted;
  final VoidCallback onGithub;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          "Let’s connect",
          "Replace email and add LinkedIn. GitHub opens in a new tab.",
        ),
        LayoutBuilder(
          builder: (context, c) {
            final row = c.maxWidth > 720;
            final cards = [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Links", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
                      const SizedBox(height: 12),
                      _LinkRow(
                        label: "you@example.com",
                        onTap: () {
                          unawaited(launchUrl(Uri.parse("mailto:you@example.com")));
                        },
                      ),
                      _LinkRow(label: "GitHub — Aliusman077", onTap: onGithub),
                      _LinkRow(
                        label: "LinkedIn — add your URL",
                        onTap: () {
                          unawaited(launchUrl(Uri.parse("https://linkedin.com")));
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Availability", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
                      const SizedBox(height: 8),
                      Text(
                        "Say if you are open to internships, freelance, or full-time roles, and remote vs on-site.",
                        style: TextStyle(color: muted, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ),
            ];
            if (row) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: cards[0]),
                  const SizedBox(width: 16),
                  Expanded(child: cards[1]),
                ],
              );
            }
            return Column(children: [cards[0], const SizedBox(height: 16), cards[1]]);
          },
        ),
      ],
    );
  }
}

class _LinkRow extends StatelessWidget {
  const _LinkRow({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      trailing: const Icon(Icons.open_in_new, size: 18),
      onTap: onTap,
    );
  }
}
