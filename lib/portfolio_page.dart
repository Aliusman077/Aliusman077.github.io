import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import 'portfolio_data.dart';

/// Single-page portfolio with anchored sections (Flutter web), inspired by
/// https://khanusman1269.github.io — scroll-linked nav, cards, and entrance motion.
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
    const muted = Color(0xFF8B9BB4);

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
                  kHeroName,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                    letterSpacing: -0.5,
                  ),
                ),
                actions: [
                  if (wide) ...[
                    _NavText('About', () => _scrollTo(_kAbout)),
                    _NavText('Journey', () => _scrollTo(_kJourney)),
                    _NavText('Projects', () => _scrollTo(_kProjects)),
                    _NavText('Skills', () => _scrollTo(_kSkills)),
                    _NavText('Education', () => _scrollTo(_kEducation)),
                    _NavText('Connect', () => _scrollTo(_kConnect)),
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
                    _ChipNav('About', () => _scrollTo(_kAbout)),
                    _ChipNav('Journey', () => _scrollTo(_kJourney)),
                    _ChipNav('Projects', () => _scrollTo(_kProjects)),
                    _ChipNav('Skills', () => _scrollTo(_kSkills)),
                    _ChipNav('Education', () => _scrollTo(_kEducation)),
                    _ChipNav('Connect', () => _scrollTo(_kConnect)),
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
                      _Hero(
                        key: _kHero,
                        cs: cs,
                        muted: muted,
                        onWork: () => _scrollTo(_kProjects),
                        onContact: () => _scrollTo(_kConnect),
                      ),
                      const _SectionGap(),
                      _AboutSection(key: _kAbout),
                      const _SectionGap(),
                      _JourneySection(key: _kJourney),
                      const _SectionGap(),
                      _ProjectsSection(key: _kProjects),
                      const _SectionGap(),
                      _SkillsSection(key: _kSkills),
                      const _SectionGap(),
                      _EducationSection(key: _kEducation),
                      const _SectionGap(),
                      _ConnectSection(
                        key: _kConnect,
                        muted: muted,
                        onGithub: () => _openUri('https://github.com/$kPortfolioGithubUser'),
                        onLinkedIn: () => _openUri(kPortfolioLinkedInUrl),
                        onEmail: () => _openUri('mailto:$kPortfolioEmail'),
                        onPhone: () => _openUri('tel:$kPortfolioPhoneTel'),
                      ),
                      const SizedBox(height: 48),
                      Text(
                        '© ${DateTime.now().year} $kHeroName · Flutter · GitHub Pages',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: muted, fontSize: 13),
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
  const _SectionGap();

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

/// Subtle hover lift on cards (web / desktop), similar to polished portfolio sites.
class _HoverLift extends StatefulWidget {
  const _HoverLift({required this.child, this.scaleEnd = 1.012});
  final Widget child;
  final double scaleEnd;

  @override
  State<_HoverLift> createState() => _HoverLiftState();
}

class _HoverLiftState extends State<_HoverLift> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedScale(
        scale: _hover ? widget.scaleEnd : 1,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        child: widget.child,
      ),
    );
  }
}

/// Hero with slow gradient pulse (reference-style ambient motion) and entrance animations.
class _Hero extends StatefulWidget {
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
  State<_Hero> createState() => _HeroState();
}

class _HeroState extends State<_Hero> with SingleTickerProviderStateMixin {
  late AnimationController _ambient;

  @override
  void initState() {
    super.initState();
    _ambient = AnimationController(vsync: this, duration: const Duration(seconds: 7))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ambient.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = widget.cs;
    final muted = widget.muted;
    final headlineStyle = Theme.of(context).textTheme.displaySmall?.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: -1,
        );

    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0x14FFFFFF))),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _ambient,
              builder: (context, _) {
                final t = CurvedAnimation(parent: _ambient, curve: Curves.easeInOutCubic).value;
                final topGlow = Color.lerp(const Color(0x243DD6C6), const Color(0x423DD6C6), t)!;
                return DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        topGlow,
                        const Color(0x000A0E14),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(kHeroName, style: headlineStyle)
                    .animate()
                    .fadeIn(duration: 550.ms, curve: Curves.easeOutCubic)
                    .slideX(begin: -0.04, end: 0, curve: Curves.easeOutCubic),
                const SizedBox(height: 8),
                Text(
                  '$kHeroRole · $kPortfolioLocation',
                  style: TextStyle(
                    fontSize: 18,
                    color: cs.primary,
                    fontWeight: FontWeight.w600,
                    height: 1.45,
                  ),
                )
                    .animate()
                    .fadeIn(delay: 90.ms, duration: 500.ms)
                    .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic)
                    .then(delay: 350.ms)
                    .shimmer(
                      duration: 2200.ms,
                      color: cs.primary.withValues(alpha: 0.22),
                    ),
                const SizedBox(height: 10),
                Text(
                  kHeroTagline,
                  style: TextStyle(fontSize: 17, color: muted, height: 1.5),
                )
                    .animate()
                    .fadeIn(delay: 160.ms, duration: 550.ms)
                    .slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic),
                const SizedBox(height: 12),
                Text(
                  kHeroStatsLine,
                  style: TextStyle(color: muted.withValues(alpha: 0.95), fontSize: 15, height: 1.4),
                )
                    .animate()
                    .fadeIn(delay: 220.ms, duration: 500.ms)
                    .then(delay: 200.ms)
                    .shimmer(
                      duration: 2600.ms,
                      color: const Color(0xFF3DD6C6).withValues(alpha: 0.2),
                    ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    FilledButton(
                      onPressed: widget.onWork,
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                      ),
                      child: const Text('View my work'),
                    ),
                    OutlinedButton(
                      onPressed: widget.onContact,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                      ),
                      child: const Text('Contact me'),
                    ),
                  ],
                ).animate().fadeIn(delay: 300.ms, duration: 450.ms).scale(
                      begin: const Offset(0.96, 0.96),
                      curve: Curves.easeOutBack,
                    ),
              ],
            ),
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
    const muted = Color(0xFF8B9BB4);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        Text(subtitle, style: const TextStyle(color: muted, height: 1.5)),
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
          'About me',
          'Professional summary—Android engineering, architecture, integrations, and how I ship with teams.',
        )
            .animate()
            .fadeIn(duration: 480.ms, curve: Curves.easeOutCubic)
            .slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic),
        Text(
          kAboutIntro,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.78),
            height: 1.55,
            fontSize: 16,
          ),
        )
            .animate()
            .fadeIn(delay: 80.ms, duration: 500.ms)
            .slideY(begin: 0.06, end: 0, curve: Curves.easeOutCubic),
        const SizedBox(height: 18),
        ...kProfessionalSummaryBullets.asMap().entries.map((e) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• ',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Expanded(
                  child: Text(
                    e.value,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.76),
                      height: 1.5,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          )
              .animate()
              .fadeIn(delay: (120 + e.key * 40).ms, duration: 420.ms, curve: Curves.easeOutCubic)
              .slideX(begin: -0.02, end: 0, curve: Curves.easeOutCubic);
        }),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, c) {
            final cols = c.maxWidth > 900 ? 3 : (c.maxWidth > 560 ? 2 : 1);
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: cols == 1 ? 1.35 : 1.15,
              ),
              itemCount: kAboutHighlights.length,
              itemBuilder: (context, i) {
                final h = kAboutHighlights[i];
                return _InfoCard(title: h.title, body: h.body)
                    .animate()
                    .fadeIn(delay: (100 + i * 70).ms, duration: 450.ms, curve: Curves.easeOutCubic)
                    .slideY(begin: 0.12, end: 0, curve: Curves.easeOutCubic);
              },
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
    const muted = Color(0xFF8B9BB4);
    return _HoverLift(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
              const SizedBox(height: 8),
              Expanded(child: Text(body, style: const TextStyle(color: muted, height: 1.45, fontSize: 14))),
            ],
          ),
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
          'Professional journey',
          'Roles, responsibilities, and flagship work—similar to a résumé timeline.',
        )
            .animate()
            .fadeIn(duration: 480.ms)
            .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic),
        ...kJobs.asMap().entries.map((e) {
          return Padding(
            padding: EdgeInsets.only(bottom: e.key == kJobs.length - 1 ? 0 : 12),
            child: _JobBlock(job: e.value)
                .animate()
                .fadeIn(delay: (120 + e.key * 100).ms, duration: 500.ms, curve: Curves.easeOutCubic)
                .slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic),
          );
        }),
      ],
    );
  }
}

class _JobBlock extends StatelessWidget {
  const _JobBlock({required this.job});
  final JobEntry job;

  @override
  Widget build(BuildContext context) {
    const muted = Color(0xFF8B9BB4);
    final cs = Theme.of(context).colorScheme;
    return _HoverLift(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(job.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
                        const SizedBox(height: 2),
                        Text(job.company, style: TextStyle(color: cs.primary, fontWeight: FontWeight.w600, fontSize: 14)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(job.meta, textAlign: TextAlign.end, style: const TextStyle(color: muted, fontSize: 13)),
                  ),
                ],
              ),
            const SizedBox(height: 8),
            Text(job.summary, style: const TextStyle(color: muted, fontSize: 14, height: 1.45)),
            if (job.bullets.isNotEmpty) ...[
              const SizedBox(height: 10),
              const Text('Responsibilities', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
              const SizedBox(height: 6),
              ...job.bullets.map(
                (b) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ', style: TextStyle(color: muted)),
                      Expanded(child: Text(b, style: const TextStyle(color: muted, height: 1.45))),
                    ],
                  ),
                ),
              ),
            ],
            if (job.topProjects.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text('Top projects', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: cs.primary)),
              const SizedBox(height: 8),
              ...job.topProjects.map(
                (p) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(p.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                      const SizedBox(height: 2),
                      Text(p.detail, style: const TextStyle(color: muted, height: 1.45, fontSize: 13)),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: job.tags.map((t) => _Tag(t)).toList(),
            ),
          ],
        ),
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
          'Featured projects',
          'Highlights across remote control, media, AI, AR, productivity, and education.',
        )
            .animate()
            .fadeIn(duration: 480.ms)
            .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic),
        LayoutBuilder(
          builder: (context, c) {
            final cols = c.maxWidth > 900 ? 3 : (c.maxWidth > 560 ? 2 : 1);
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: cols == 1 ? 1.02 : 0.98,
              ),
              itemCount: kFeaturedProjects.length,
              itemBuilder: (context, i) {
                final p = kFeaturedProjects[i];
                return _ProjectCard(
                  badge: p.badge,
                  name: p.name,
                  desc: p.desc,
                  tags: p.tags,
                )
                    .animate()
                    .fadeIn(delay: (80 + i * 55).ms, duration: 480.ms, curve: Curves.easeOutCubic)
                    .slideY(begin: 0.12, end: 0, curve: Curves.easeOutCubic);
              },
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
    const muted = Color(0xFF8B9BB4);
    return _HoverLift(
      child: Card(
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
              Expanded(child: Text(desc, style: const TextStyle(color: muted, height: 1.45, fontSize: 14))),
              const SizedBox(height: 8),
              Wrap(spacing: 6, runSpacing: 6, children: tags.map((t) => _Tag(t)).toList()),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillsSection extends StatelessWidget {
  const _SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final groups = kSkillGroups;
    final mid = (groups.length / 2).ceil();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          'Technical expertise',
          'Languages, architecture, async, data, networking, and shipping—grouped like a skills matrix.',
        )
            .animate()
            .fadeIn(duration: 480.ms)
            .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic),
        LayoutBuilder(
          builder: (context, c) {
            if (c.maxWidth > 640) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        for (var i = 0; i < mid; i++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _SkillGroup(title: groups[i].title, tags: groups[i].tags)
                                .animate()
                                .fadeIn(delay: (60 + i * 50).ms, duration: 450.ms)
                                .slideX(begin: -0.03, end: 0, curve: Curves.easeOutCubic),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      children: [
                        for (var i = mid; i < groups.length; i++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _SkillGroup(title: groups[i].title, tags: groups[i].tags)
                                .animate()
                                .fadeIn(delay: (60 + (i - mid) * 50).ms, duration: 450.ms)
                                .slideX(begin: 0.03, end: 0, curve: Curves.easeOutCubic),
                          ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return Column(
              children: [
                for (var i = 0; i < groups.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _SkillGroup(title: groups[i].title, tags: groups[i].tags)
                        .animate()
                        .fadeIn(delay: (50 + i * 45).ms, duration: 450.ms)
                        .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic),
                  ),
              ],
            );
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
                for (var i = 0; i < kMetrics.length; i++)
                  _Metric(cell, kMetrics[i].value, kMetrics[i].label)
                      .animate()
                      .fadeIn(delay: (200 + i * 80).ms, duration: 500.ms, curve: Curves.easeOutCubic)
                      .scale(begin: const Offset(0.92, 0.92), curve: Curves.easeOutBack),
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
    const muted = Color(0xFF8B9BB4);
    return _HoverLift(
      scaleEnd: 1.008,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: muted, fontWeight: FontWeight.w600, fontSize: 13)),
              const SizedBox(height: 10),
              Wrap(spacing: 8, runSpacing: 8, children: tags.map((t) => _Tag(t)).toList()),
            ],
          ),
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
    const muted = Color(0xFF8B9BB4);
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
              Text(
                value,
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: Color(0xFF3DD6C6)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, color: muted)),
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
          'Education',
          'Formal training that underpins years of Android delivery.',
        )
            .animate()
            .fadeIn(duration: 480.ms)
            .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic),
        _JobBlock(
          job: JobEntry(
            title: kEducationTitle,
            company: 'The University of Poonch Rawalakot',
            meta: kEducationMeta,
            summary: kEducationSummary,
            bullets: const [],
            topProjects: const [],
            tags: const ['Computer Science', 'Android', 'Software engineering'],
          ),
        ).animate().fadeIn(delay: 100.ms, duration: 500.ms).slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic),
      ],
    );
  }
}

class _ConnectSection extends StatelessWidget {
  const _ConnectSection({
    super.key,
    required this.muted,
    required this.onGithub,
    required this.onLinkedIn,
    required this.onEmail,
    required this.onPhone,
  });

  final Color muted;
  final VoidCallback onGithub;
  final VoidCallback onLinkedIn;
  final VoidCallback onEmail;
  final VoidCallback onPhone;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          'Let’s connect',
          'Email, phone, LinkedIn, and GitHub—available for roles that value solid Android craft.',
        )
            .animate()
            .fadeIn(duration: 480.ms)
            .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic),
        LayoutBuilder(
          builder: (context, c) {
            final row = c.maxWidth > 720;
            final linksCard = Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Get in touch', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
                    const SizedBox(height: 12),
                    _LinkRow(label: kPortfolioEmail, onTap: onEmail),
                    _LinkRow(label: kPortfolioPhoneDisplay, onTap: onPhone),
                    _LinkRow(label: 'LinkedIn profile', onTap: onLinkedIn),
                    _LinkRow(label: 'GitHub — $kPortfolioGithubUser', onTap: onGithub),
                    _LinkRow(
                      label: kPortfolioLocation,
                      onTap: () {
                        unawaited(
                          launchUrl(
                            Uri.parse(
                              'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(kPortfolioLocation)}',
                            ),
                            mode: LaunchMode.externalApplication,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.04, end: 0, curve: Curves.easeOutCubic);

            final whyCard = Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Why work with me', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
                    const SizedBox(height: 10),
                    ...kWhyWorkWithMe.map(
                      (line) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('• ', style: TextStyle(color: Color(0xFF8B9BB4))),
                            Expanded(
                              child: Text(line, style: TextStyle(color: muted, height: 1.45)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(delay: 120.ms, duration: 500.ms).slideX(begin: 0.04, end: 0, curve: Curves.easeOutCubic);

            if (row) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: linksCard),
                  const SizedBox(width: 16),
                  Expanded(child: whyCard),
                ],
              );
            }
            return Column(children: [linksCard, const SizedBox(height: 16), whyCard]);
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
