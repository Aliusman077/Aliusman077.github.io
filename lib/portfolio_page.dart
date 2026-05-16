import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import 'portfolio_data.dart';

const kAccent = Color(0xFF3DD6C6);
const kMutedColor = Color(0xFF8B9BB4);

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key, required this.isDarkMode, required this.onToggleTheme});
  final bool isDarkMode;
  final VoidCallback onToggleTheme;
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

  int _activeNav = 0;
  bool _showScrollFab = false;

  List<GlobalKey> get _sectionKeys => [
        _kHero,
        _kAbout,
        _kJourney,
        _kProjects,
        _kSkills,
        _kEducation,
        _kConnect,
      ];

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  void _onScroll() {
    final showFab = _scroll.offset > 380;
    if (showFab != _showScrollFab) setState(() => _showScrollFab = showFab);

    if (!mounted) return;
    final navH = 88.0;
    var best = 0;
    var bestDist = double.infinity;
    for (var i = 0; i < _sectionKeys.length; i++) {
      final ctx = _sectionKeys[i].currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null || !box.hasSize) continue;
      final dy = box.localToGlobal(Offset.zero).dy;
      final dist = (dy - navH).abs();
      if (dist < bestDist) {
        bestDist = dist;
        best = i;
      }
    }
    if (best != _activeNav) setState(() => _activeNav = best);
  }

  Future<void> _openUri(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
        alignment: 0.05,
      );
    }
  }

  void _scrollToTop() {
    _scroll.animateTo(0, duration: const Duration(milliseconds: 550), curve: Curves.easeOutCubic);
  }

  @override
  void dispose() {
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const muted = Color(0xFF8B9BB4);
    final navBg = isDark ? const Color(0xEE0A0E14) : Colors.white;
    final navBorder = isDark ? const Color(0x14FFFFFF) : const Color(0x14000000);
    return Scaffold(
      floatingActionButton: _showScrollFab
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton.small(
                  heroTag: 'contact_fab',
                  tooltip: 'Contact',
                  onPressed: () => _scrollTo(_kConnect),
                  child: const Icon(Icons.mail_outline_rounded, size: 20),
                ),
                const SizedBox(height: 10),
                FloatingActionButton.small(
                  heroTag: 'top_fab',
                  tooltip: 'Back to top',
                  onPressed: _scrollToTop,
                  child: const Icon(Icons.keyboard_arrow_up_rounded, size: 22),
                ),
              ],
            )
          : null,
      body: SelectionArea(
        child: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
        final wide = constraints.maxWidth >= 1000;
        final padH = constraints.maxWidth < 400 ? 12.0 : 20.0;
        return Column(children: [
          PortfolioNavBar(
            wide: wide, navBg: navBg, navBorder: navBorder, activeNav: _activeNav,
            isDarkMode: widget.isDarkMode, onToggleTheme: widget.onToggleTheme,
            onHome: () => _scrollTo(_kHero), onAbout: () => _scrollTo(_kAbout),
            onExperience: () => _scrollTo(_kJourney), onProjects: () => _scrollTo(_kProjects),
            onSkills: () => _scrollTo(_kSkills), onEducation: () => _scrollTo(_kEducation),
            onContact: () => _scrollTo(_kConnect), onGetInTouch: () => _scrollTo(_kConnect),
          ),
          Expanded(child: CustomScrollView(controller: _scroll, slivers: [
            if (!wide) SliverToBoxAdapter(child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
              child: Wrap(spacing: 4, runSpacing: 4, alignment: WrapAlignment.center, children: [
                ChipNav('About', () => _scrollTo(_kAbout)),
                ChipNav('Experience', () => _scrollTo(_kJourney)),
                ChipNav('Projects', () => _scrollTo(_kProjects)),
                ChipNav('Skills', () => _scrollTo(_kSkills)),
                ChipNav('Education', () => _scrollTo(_kEducation)),
                ChipNav('Contact', () => _scrollTo(_kConnect)),
              ]),
            )),
            SliverToBoxAdapter(child: Center(child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: padH),
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  HeroSection(key: _kHero, cs: cs, muted: muted,
                    onWork: () => _scrollTo(_kProjects), onContact: () => _scrollTo(_kConnect),
                    onLinkedIn: () => _openUri(kPortfolioLinkedInUrl),
                    onGithub: () => _openUri('https://github.com/$kPortfolioGithubUser'),
                    onEmail: () => _openUri('mailto:$kPortfolioEmail'),
                    onPhone: () => _openUri('tel:$kPortfolioPhoneTel'),
                    onScrollDown: () => _scrollTo(_kAbout)),
                  const SectionGap(),
                  AboutSection(key: _kAbout),
                  const SectionGap(),
                  JourneySection(key: _kJourney),
                  const SectionGap(),
                  ProjectsSection(key: _kProjects),
                  const SectionGap(),
                  SkillsSection(key: _kSkills),
                  const SectionGap(),
                  EducationSection(key: _kEducation),
                  const SectionGap(),
                  ConnectSection(key: _kConnect, muted: muted,
                    onGithub: () => _openUri('https://github.com/$kPortfolioGithubUser'),
                    onLinkedIn: () => _openUri(kPortfolioLinkedInUrl),
                    onEmail: () => _openUri('mailto:$kPortfolioEmail'),
                    onPhone: () => _openUri('tel:$kPortfolioPhoneTel')),
                  const SizedBox(height: 48),
                  PortfolioFooter(
                    onLinkedIn: () => _openUri(kPortfolioLinkedInUrl),
                    onGithub: () => _openUri('https://github.com/$kPortfolioGithubUser'),
                    onEmail: () => _openUri('mailto:$kPortfolioEmail')),
                  const SizedBox(height: 32),
                ]),
              ),
            ))),
          ])),
        ]);
      }),
        ),
      ),
    );
  }
}

class SectionGap extends StatelessWidget {
  const SectionGap();
  @override
  Widget build(BuildContext context) => const SizedBox(height: 56);
}

class HoverLift extends StatefulWidget {
  const HoverLift({super.key, required this.child, this.scaleEnd = 1.013});
  final Widget child;
  final double scaleEnd;
  @override
  State<HoverLift> createState() => _HoverLiftState();
}
class _HoverLiftState extends State<HoverLift> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedScale(
        scale: hover ? widget.scaleEnd : 1,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: hover ? [BoxShadow(color: kAccent.withValues(alpha: 0.12), blurRadius: 24, spreadRadius: 0)] : [],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

class PortfolioNavBar extends StatelessWidget {
  const PortfolioNavBar({super.key, required this.wide, required this.navBg, required this.navBorder,
    required this.activeNav, required this.isDarkMode, required this.onToggleTheme, required this.onHome,
    required this.onAbout, required this.onExperience, required this.onProjects, required this.onSkills,
    required this.onEducation, required this.onContact, required this.onGetInTouch});
  final bool wide;
  final Color navBg, navBorder;
  final int activeNav;
  final bool isDarkMode;
  final VoidCallback onToggleTheme, onHome, onAbout, onExperience, onProjects, onSkills, onEducation, onContact, onGetInTouch;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final navMuted = Color.lerp(cs.onSurface, cs.surface, isDarkMode ? 0.35 : 0.45)!;
    return Material(
      color: navBg,
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: navBorder)),
          boxShadow: isDarkMode ? null : [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Center(child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: wide ? Row(children: [
            Expanded(flex: 1, child: Align(alignment: Alignment.centerLeft, child: InkWell(onTap: onHome, borderRadius: BorderRadius.circular(8), child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              child: Text.rich(TextSpan(style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, letterSpacing: -0.25), children: [
                TextSpan(text: kBrandFirst, style: TextStyle(color: cs.onSurface)),
                TextSpan(text: kBrandAccent, style: TextStyle(color: cs.primary)),
              ])),
            )))),
            Expanded(flex: 2, child: Center(child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(mainAxisSize: MainAxisSize.min, children: [
              TopNavLink('Home', onHome, navMuted, active: activeNav == 0),
              TopNavLink('About', onAbout, navMuted, active: activeNav == 1),
              TopNavLink('Experience', onExperience, navMuted, active: activeNav == 2),
              TopNavLink('Projects', onProjects, navMuted, active: activeNav == 3),
              TopNavLink('Skills', onSkills, navMuted, active: activeNav == 4),
              TopNavLink('Education', onEducation, navMuted, active: activeNav == 5),
              TopNavLink('Contact', onContact, navMuted, active: activeNav == 6),
            ])))),
            Expanded(flex: 1, child: Align(alignment: Alignment.centerRight, child: Row(mainAxisSize: MainAxisSize.min, children: [
              IconButton(tooltip: isDarkMode ? 'Light mode' : 'Dark mode', onPressed: onToggleTheme,
                icon: Icon(isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined, color: cs.onSurface.withValues(alpha: 0.88))),
              const SizedBox(width: 8),
              FilledButton(onPressed: onGetInTouch,
                style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12), textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                child: const Text('Get In Touch')),
            ]))),
          ]) : Row(children: [
            InkWell(onTap: onHome, borderRadius: BorderRadius.circular(8), child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              child: Text.rich(TextSpan(style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, letterSpacing: -0.25), children: [
                TextSpan(text: kBrandFirst, style: TextStyle(color: cs.onSurface)),
                TextSpan(text: kBrandAccent, style: TextStyle(color: cs.primary)),
              ])),
            )),
            const Spacer(),
            IconButton(tooltip: isDarkMode ? 'Light mode' : 'Dark mode', onPressed: onToggleTheme,
              icon: Icon(isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined, color: cs.onSurface.withValues(alpha: 0.88))),
            FilledButton(onPressed: onGetInTouch,
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11), textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              child: const Text('Get In Touch')),
          ]),
        )),
      ),
    );
  }
}

class TopNavLink extends StatefulWidget {
  const TopNavLink(this.label, this.onTap, this.color, {this.active = false});
  final String label;
  final VoidCallback onTap;
  final Color color;
  final bool active;
  @override
  State<TopNavLink> createState() => _TopNavLinkState();
}
class _TopNavLinkState extends State<TopNavLink> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: TextButton(
        onPressed: widget.onTap,
        style: TextButton.styleFrom(
          foregroundColor: widget.active || hover ? cs.primary : widget.color,
          backgroundColor: widget.active ? cs.primary.withValues(alpha: 0.1) : Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: TextStyle(
            fontWeight: widget.active || hover ? FontWeight.w700 : FontWeight.w500,
            fontSize: 15,
            height: 1.2,
            color: widget.active || hover ? cs.primary : widget.color,
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}

class ChipNav extends StatelessWidget {
  const ChipNav(this.label, this.onTap);
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => ActionChip(label: Text(label), onPressed: onTap, visualDensity: VisualDensity.compact);
}

class HeroSection extends StatefulWidget {
  const HeroSection({super.key, required this.cs, required this.muted, required this.onWork,
    required this.onContact, required this.onLinkedIn, required this.onGithub,
    required this.onEmail, required this.onPhone, required this.onScrollDown});
  final ColorScheme cs;
  final Color muted;
  final VoidCallback onWork, onContact, onLinkedIn, onGithub, onEmail, onPhone, onScrollDown;
  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with TickerProviderStateMixin {
  late AnimationController ambient;
  late AnimationController avatarPulse;
  final List<String> roles = ['Android Engineer', 'Kotlin Developer', 'Jetpack Compose Expert', 'Clean Architecture Advocate'];
  int roleIndex = 0;
  String displayedRole = '';
  bool typing = true;
  Timer? typeTimer;

  @override
  void initState() {
    super.initState();
    ambient = AnimationController(vsync: this, duration: const Duration(seconds: 7))..repeat(reverse: true);
    avatarPulse = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat(reverse: true);
    startTypewriter();
  }

  void startTypewriter() {
    typeTimer?.cancel();
    final target = roles[roleIndex];
    typeTimer = Timer.periodic(const Duration(milliseconds: 60), (t) {
      if (!mounted) { t.cancel(); return; }
      setState(() {
        if (typing) {
          if (displayedRole.length < target.length) {
            displayedRole = target.substring(0, displayedRole.length + 1);
          } else {
            typing = false; t.cancel();
            Future.delayed(const Duration(milliseconds: 1800), eraseRole);
          }
        }
      });
    });
  }

  void eraseRole() {
    typeTimer?.cancel();
    typeTimer = Timer.periodic(const Duration(milliseconds: 35), (t) {
      if (!mounted) { t.cancel(); return; }
      setState(() {
        if (displayedRole.isNotEmpty) {
          displayedRole = displayedRole.substring(0, displayedRole.length - 1);
        } else {
          typing = true; roleIndex = (roleIndex + 1) % roles.length; t.cancel(); startTypewriter();
        }
      });
    });
  }

  @override
  void dispose() { ambient.dispose(); avatarPulse.dispose(); typeTimer?.cancel(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final cs = widget.cs;
    final muted = widget.muted;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final w = MediaQuery.sizeOf(context).width;
    final nameSize = w >= 900 ? 54.0 : (w >= 600 ? 42.0 : 34.0);
    final headlineStyle = TextStyle(fontSize: nameSize, fontWeight: FontWeight.w800, letterSpacing: nameSize >= 48 ? -1.8 : -1.2, height: 1.08);

    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: isDark ? const Color(0x14FFFFFF) : const Color(0x14000000)))),
      child: Stack(clipBehavior: Clip.none, children: [
        Positioned.fill(child: AnimatedBuilder(animation: ambient, builder: (context, _) {
          final t = CurvedAnimation(parent: ambient, curve: Curves.easeInOutCubic).value;
          return DecoratedBox(decoration: BoxDecoration(gradient: LinearGradient(
            begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: [Color.lerp(const Color(0x1A3DD6C6), const Color(0x3A3DD6C6), t)!,
              Color.lerp(isDark ? const Color(0x08B06EFF) : const Color(0x06B06EFF), isDark ? const Color(0x18B06EFF) : const Color(0x10B06EFF), t)!],
          )));
        })),
        Positioned(top: -60, right: -60, child: AnimatedBuilder(animation: ambient, builder: (_, __) {
          final t = CurvedAnimation(parent: ambient, curve: Curves.easeInOutSine).value;
          return Opacity(opacity: 0.06 + t * 0.06, child: Container(width: 320, height: 320, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: kAccent, width: 1.5))));
        })),
        Positioned(bottom: -80, left: -80, child: AnimatedBuilder(animation: ambient, builder: (_, __) {
          final t = CurvedAnimation(parent: ambient, curve: Curves.easeInOutSine).value;
          return Opacity(opacity: 0.04 + t * 0.04, child: Container(width: 240, height: 240, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: kAccent, width: 1))));
        })),
        Padding(
          padding: EdgeInsets.fromLTRB(16, w >= 900 ? 56 : 36, 16, w >= 900 ? 56 : 40),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            AnimatedBuilder(animation: avatarPulse, builder: (_, __) {
              final t = CurvedAnimation(parent: avatarPulse, curve: Curves.easeInOutSine).value;
              return Container(
                width: 110, height: 110,
                decoration: BoxDecoration(shape: BoxShape.circle,
                  gradient: SweepGradient(colors: [kAccent, Color.lerp(kAccent, const Color(0xFF7C3AED), t)!, kAccent]),
                  boxShadow: [BoxShadow(color: kAccent.withValues(alpha: 0.25 + t * 0.2), blurRadius: 20 + t * 10)]),
                padding: const EdgeInsets.all(3),
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, color: isDark ? const Color(0xFF0A0E14) : Colors.white),
                  child: Center(
                    child: Icon(Icons.phone_android_rounded, size: 48, color: cs.primary),
                  ),
                ),
              );
            }).animate().fadeIn(duration: 600.ms, curve: Curves.easeOutCubic).scale(begin: const Offset(0.7, 0.7), curve: Curves.easeOutBack),
            SizedBox(height: w >= 900 ? 24 : 18),
            Text.rich(TextSpan(children: [
              TextSpan(text: kHeroNameFirst, style: headlineStyle.copyWith(color: cs.onSurface)),
              TextSpan(text: kHeroNameAccent, style: headlineStyle.copyWith(color: cs.primary)),
            ]), textAlign: TextAlign.center).animate().fadeIn(delay: 150.ms, duration: 550.ms, curve: Curves.easeOutCubic).slideY(begin: 0.06, end: 0, curve: Curves.easeOutCubic),
            SizedBox(height: w >= 900 ? 14 : 10),
            const OpenToWorkBadge().animate().fadeIn(delay: 200.ms, duration: 450.ms).scale(begin: const Offset(0.92, 0.92), curve: Curves.easeOutBack),
            SizedBox(height: w >= 900 ? 14 : 10),
            SizedBox(height: 32, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(displayedRole, style: TextStyle(fontSize: w >= 900 ? 20 : 17, color: cs.primary, fontWeight: FontWeight.w600, height: 1.4)),
              BlinkingCursor(color: cs.primary),
            ])).animate().fadeIn(delay: 250.ms, duration: 500.ms),
            SizedBox(height: w >= 900 ? 10 : 8),
            Text(kPortfolioLocation, textAlign: TextAlign.center, style: TextStyle(fontSize: w >= 900 ? 15 : 13, color: muted, fontWeight: FontWeight.w500)).animate().fadeIn(delay: 300.ms, duration: 500.ms),
            SizedBox(height: w >= 900 ? 16 : 12),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: Text(kHeroTagline, textAlign: TextAlign.center, style: TextStyle(fontSize: w >= 900 ? 17 : 15, color: muted, height: 1.6, fontWeight: FontWeight.w400)))
                .animate().fadeIn(delay: 350.ms, duration: 550.ms).slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic),
            SizedBox(height: w >= 900 ? 20 : 14),
            HeroStats(cs: cs, compact: w < 500).animate().fadeIn(delay: 420.ms, duration: 500.ms).slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic),
            SizedBox(height: w >= 900 ? 18 : 14),
            CoreTechStrip(cs: cs).animate().fadeIn(delay: 460.ms, duration: 480.ms).slideY(begin: 0.06, end: 0, curve: Curves.easeOutCubic),
            SizedBox(height: w >= 900 ? 24 : 18),
            RecruiterQuickActions(
              onEmail: widget.onEmail,
              onLinkedIn: widget.onLinkedIn,
              onGithub: widget.onGithub,
              onPhone: widget.onPhone,
            ).animate().fadeIn(delay: 500.ms, duration: 450.ms),
            SizedBox(height: w >= 900 ? 28 : 22),
            Wrap(alignment: WrapAlignment.center, spacing: 14, runSpacing: 14, children: [
              FilledButton.icon(onPressed: widget.onWork, icon: const Icon(Icons.work_outline_rounded, size: 18), label: const Text('View My Work'),
                style: FilledButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: w >= 900 ? 28 : 22, vertical: w >= 900 ? 15 : 13), textStyle: TextStyle(fontSize: w >= 900 ? 15 : 14, fontWeight: FontWeight.w600), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
              OutlinedButton.icon(onPressed: widget.onContact, icon: const Icon(Icons.mail_outline_rounded, size: 18), label: const Text('Contact Me'),
                style: OutlinedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: w >= 900 ? 28 : 22, vertical: w >= 900 ? 15 : 13), textStyle: TextStyle(fontSize: w >= 900 ? 15 : 14, fontWeight: FontWeight.w600), foregroundColor: cs.onSurface, side: BorderSide(color: cs.onSurface.withValues(alpha: 0.35)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
            ]).animate().fadeIn(delay: 480.ms, duration: 450.ms).scale(begin: const Offset(0.96, 0.96), curve: Curves.easeOutBack),
            const SizedBox(height: 28),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SocialIconBtn(tooltip: 'LinkedIn', icon: Icons.work_outline_rounded, onTap: widget.onLinkedIn),
              SocialIconBtn(tooltip: 'GitHub', icon: Icons.code_rounded, onTap: widget.onGithub),
              SocialIconBtn(tooltip: 'Email', icon: Icons.mail_outline_rounded, onTap: widget.onEmail),
            ]).animate().fadeIn(delay: 540.ms, duration: 450.ms).slideY(begin: 0.12, end: 0, curve: Curves.easeOutCubic),
            const SizedBox(height: 40),
            ScrollDownCue(onTap: widget.onScrollDown, color: cs.primary).animate().fadeIn(delay: 650.ms, duration: 500.ms).scale(begin: const Offset(0.85, 0.85), curve: Curves.easeOutBack),
          ]),
        ),
      ]),
    );
  }
}

class BlinkingCursor extends StatefulWidget {
  const BlinkingCursor({super.key, required this.color});
  final Color color;
  @override
  State<BlinkingCursor> createState() => _BlinkingCursorState();
}
class _BlinkingCursorState extends State<BlinkingCursor> with SingleTickerProviderStateMixin {
  late AnimationController ctrl;
  @override
  void initState() { super.initState(); ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600))..repeat(reverse: true); }
  @override
  void dispose() { ctrl.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => AnimatedBuilder(animation: ctrl, builder: (_, __) => Opacity(opacity: ctrl.value > 0.5 ? 1.0 : 0.0, child: Container(width: 2, height: 22, margin: const EdgeInsets.only(left: 2), color: widget.color)));
}

class HeroStats extends StatelessWidget {
  const HeroStats({super.key, required this.cs, this.compact = false});
  final ColorScheme cs;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final stats = [
      ('4+', 'Years'),
      ('25+', 'Apps'),
      ('500K+', 'FitFlex DLs'),
      ('3', 'Companies'),
    ];
    final statTile = (String v, String l) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(v, style: TextStyle(fontSize: compact ? 18 : 22, fontWeight: FontWeight.w800, color: cs.primary)),
            Text(l, textAlign: TextAlign.center, style: TextStyle(fontSize: compact ? 11 : 12, color: kMutedColor)),
          ]),
        );

    return Container(
      width: compact ? double.infinity : null,
      padding: EdgeInsets.symmetric(horizontal: compact ? 12 : 24, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: kAccent.withValues(alpha: 0.08),
        border: Border.all(color: kAccent.withValues(alpha: 0.2)),
      ),
      child: compact
          ? Wrap(alignment: WrapAlignment.center, spacing: 4, runSpacing: 4, children: stats.map((s) => statTile(s.$1, s.$2)).toList())
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: stats.asMap().entries.map((e) {
                final isLast = e.key == stats.length - 1;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    statTile(e.value.$1, e.value.$2),
                    if (!isLast) Container(width: 1, height: 36, margin: const EdgeInsets.symmetric(horizontal: 8), color: kAccent.withValues(alpha: 0.3)),
                  ],
                );
              }).toList(),
            ),
    );
  }
}

/// Pulsing “open to work” badge for recruiters.
class OpenToWorkBadge extends StatefulWidget {
  const OpenToWorkBadge({super.key});
  @override
  State<OpenToWorkBadge> createState() => _OpenToWorkBadgeState();
}

class _OpenToWorkBadgeState extends State<OpenToWorkBadge> with SingleTickerProviderStateMixin {
  late AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: AnimatedBuilder(
        animation: _pulse,
        builder: (context, _) {
          final t = CurvedAnimation(parent: _pulse, curve: Curves.easeInOut).value;
          return Container(
            constraints: const BoxConstraints(maxWidth: 520),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: cs.primary.withValues(alpha: 0.1 + t * 0.06),
              border: Border.all(color: cs.primary.withValues(alpha: 0.35 + t * 0.15)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.lerp(const Color(0xFF22C55E), cs.primary, t * 0.3),
                    boxShadow: [BoxShadow(color: cs.primary.withValues(alpha: 0.5 * t), blurRadius: 6)],
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    kAvailabilityLabel,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: cs.primary),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Horizontal tech chips — quick scan for hiring managers.
class CoreTechStrip extends StatelessWidget {
  const CoreTechStrip({super.key, required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: kCoreTechnologies.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: cs.onSurface.withValues(alpha: 0.06),
              border: Border.all(color: cs.primary.withValues(alpha: 0.22)),
            ),
            child: Text(
              kCoreTechnologies[i],
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: cs.onSurface.withValues(alpha: 0.88)),
            ),
          ).animate().fadeIn(delay: (40 * i).ms, duration: 350.ms).slideX(begin: 0.05, end: 0);
        },
      ),
    );
  }
}

/// One-tap recruiter actions above primary CTAs.
class RecruiterQuickActions extends StatelessWidget {
  const RecruiterQuickActions({
    super.key,
    required this.onEmail,
    required this.onLinkedIn,
    required this.onGithub,
    required this.onPhone,
  });
  final VoidCallback onEmail, onLinkedIn, onGithub, onPhone;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final w = MediaQuery.sizeOf(context).width;
    final actions = [
      ('Email', Icons.mail_outline_rounded, onEmail),
      ('LinkedIn', Icons.work_outline_rounded, onLinkedIn),
      ('GitHub', Icons.code_rounded, onGithub),
      if (w >= 400) ('Call', Icons.phone_outlined, onPhone),
    ];
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: actions.map((a) {
        return OutlinedButton.icon(
          onPressed: a.$3,
          icon: Icon(a.$2, size: 16),
          label: Text(a.$1),
          style: OutlinedButton.styleFrom(
            foregroundColor: cs.onSurface.withValues(alpha: 0.9),
            side: BorderSide(color: cs.primary.withValues(alpha: 0.35)),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        );
      }).toList(),
    );
  }
}

class SocialIconBtn extends StatefulWidget {
  const SocialIconBtn({super.key, required this.tooltip, required this.icon, required this.onTap});
  final String tooltip;
  final IconData icon;
  final VoidCallback onTap;
  @override
  State<SocialIconBtn> createState() => _SocialIconBtnState();
}
class _SocialIconBtnState extends State<SocialIconBtn> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 6), child: MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(shape: BoxShape.circle, color: hover ? cs.primary.withValues(alpha: 0.15) : cs.onSurface.withValues(alpha: 0.08), border: Border.all(color: hover ? cs.primary.withValues(alpha: 0.5) : Colors.transparent)),
        child: IconButton(tooltip: widget.tooltip, onPressed: widget.onTap, icon: Icon(widget.icon, size: 22), color: hover ? cs.primary : cs.onSurface.withValues(alpha: 0.85)),
      ),
    ));
  }
}

class ScrollDownCue extends StatefulWidget {
  const ScrollDownCue({super.key, required this.onTap, required this.color});
  final VoidCallback onTap;
  final Color color;
  @override
  State<ScrollDownCue> createState() => _ScrollDownCueState();
}
class _ScrollDownCueState extends State<ScrollDownCue> with SingleTickerProviderStateMixin {
  late AnimationController bounce;
  @override
  void initState() { super.initState(); bounce = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))..repeat(reverse: true); }
  @override
  void dispose() { bounce.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return MouseRegion(cursor: SystemMouseCursors.click, child: GestureDetector(onTap: widget.onTap, child: AnimatedBuilder(animation: bounce, builder: (_, __) {
      final t = CurvedAnimation(parent: bounce, curve: Curves.easeInOutSine).value;
      return Transform.translate(offset: Offset(0, t * 5), child: Container(width: 44, height: 44,
        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: widget.color.withValues(alpha: 0.65), width: 2), color: widget.color.withValues(alpha: 0.12)),
        child: Icon(Icons.keyboard_arrow_down_rounded, color: widget.color, size: 28)));
    })));
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, this.subtitle);
  final String title, subtitle;
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(width: 4, height: 28, decoration: BoxDecoration(color: cs.primary, borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 12),
        Text(title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
      ]),
      const SizedBox(height: 8),
      Padding(padding: const EdgeInsets.only(left: 16), child: Text(subtitle, style: const TextStyle(color: kMutedColor, height: 1.5))),
      const SizedBox(height: 24),
    ]);
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SectionTitle('About Me', 'Passionate Android engineer with a track record of shipping quality apps.')
          .animate().fadeIn(duration: 480.ms, curve: Curves.easeOutCubic).slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic),
      Text(kAboutIntro, style: TextStyle(color: cs.onSurface.withValues(alpha: 0.78), height: 1.6, fontSize: 16))
          .animate().fadeIn(delay: 80.ms, duration: 500.ms).slideY(begin: 0.06, end: 0, curve: Curves.easeOutCubic),
      const SizedBox(height: 18),
      ...kProfessionalSummaryBullets.asMap().entries.map((e) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(Icons.check_circle_outline_rounded, size: 18, color: cs.primary),
          const SizedBox(width: 10),
          Expanded(child: Text(e.value, style: TextStyle(color: cs.onSurface.withValues(alpha: 0.76), height: 1.5, fontSize: 15))),
        ]),
      ).animate().fadeIn(delay: (120 + e.key * 40).ms, duration: 420.ms, curve: Curves.easeOutCubic).slideX(begin: -0.02, end: 0, curve: Curves.easeOutCubic)),
      const SizedBox(height: 24),
      LayoutBuilder(builder: (context, c) {
        final cols = c.maxWidth > 900 ? 3 : (c.maxWidth > 560 ? 2 : 1);
        final itemWidth = (c.maxWidth - (cols - 1) * 12) / cols;
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List.generate(kAboutHighlights.length, (i) =>
            SizedBox(width: itemWidth, child: InfoCard(title: kAboutHighlights[i].title, body: kAboutHighlights[i].body, index: i)
                .animate().fadeIn(delay: (100 + i * 70).ms, duration: 450.ms, curve: Curves.easeOutCubic).slideY(begin: 0.12, end: 0, curve: Curves.easeOutCubic)),
          ),
        );
      }),
    ]);
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.title, required this.body, required this.index});
  final String title, body;
  final int index;
  static const icons = [Icons.architecture_rounded, Icons.apps_rounded, Icons.integration_instructions_rounded, Icons.speed_rounded, Icons.map_rounded, Icons.groups_rounded];
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return HoverLift(child: Card(child: Padding(padding: const EdgeInsets.all(18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(width: 40, height: 40, decoration: BoxDecoration(color: cs.primary.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10)), child: Icon(icons[index % icons.length], color: cs.primary, size: 22)),
      const SizedBox(height: 12),
      Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
      const SizedBox(height: 6),
      Text(body, style: const TextStyle(color: kMutedColor, height: 1.45, fontSize: 13), maxLines: 4, overflow: TextOverflow.ellipsis),
    ]))));
  }
}

class JourneySection extends StatelessWidget {
  const JourneySection({super.key});
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const SectionTitle('Professional Journey', 'A timeline of growth, leadership, and technical excellence.')
        .animate().fadeIn(duration: 480.ms).slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic),
    ...kJobs.asMap().entries.map((e) => Padding(
      padding: EdgeInsets.only(bottom: e.key == kJobs.length - 1 ? 0 : 16),
      child: JobBlock(job: e.value, index: e.key).animate().fadeIn(delay: (120 + e.key * 100).ms, duration: 500.ms, curve: Curves.easeOutCubic).slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic),
    )),
  ]);
}

class JobBlock extends StatefulWidget {
  const JobBlock({super.key, required this.job, this.index = 0});
  final JobEntry job;
  final int index;
  @override
  State<JobBlock> createState() => _JobBlockState();
}
class _JobBlockState extends State<JobBlock> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return HoverLift(child: Card(child: IntrinsicHeight(child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Container(width: 4, decoration: BoxDecoration(color: cs.primary, borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)))),
      Expanded(child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(width: 44, height: 44, decoration: BoxDecoration(color: cs.primary.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10), border: Border.all(color: cs.primary.withValues(alpha: 0.2))),
            child: Center(child: Text(widget.job.company.substring(0, 1), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: cs.primary)))),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(widget.job.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
            const SizedBox(height: 2),
            Text(widget.job.company, style: TextStyle(color: cs.primary, fontWeight: FontWeight.w600, fontSize: 14)),
            const SizedBox(height: 2),
            Text(widget.job.meta, style: const TextStyle(color: kMutedColor, fontSize: 13)),
          ])),
          IconButton(onPressed: () => setState(() => expanded = !expanded),
            icon: AnimatedRotation(turns: expanded ? 0.5 : 0, duration: const Duration(milliseconds: 250), child: const Icon(Icons.keyboard_arrow_down_rounded)),
            color: cs.onSurface.withValues(alpha: 0.5)),
        ]),
        const SizedBox(height: 10),
        Text(widget.job.summary, style: const TextStyle(color: kMutedColor, fontSize: 14, height: 1.5)),
        const SizedBox(height: 10),
        Wrap(spacing: 6, runSpacing: 6, children: widget.job.tags.map((t) => SkillTag(t)).toList()),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (widget.job.bullets.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: isDark ? const Color(0x0AFFFFFF) : const Color(0x06000000), borderRadius: BorderRadius.circular(10)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Key Responsibilities', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: cs.primary)),
                  const SizedBox(height: 8),
                  ...widget.job.bullets.map((b) => Padding(padding: const EdgeInsets.only(bottom: 6), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Icon(Icons.arrow_right_rounded, size: 18, color: cs.primary),
                    Expanded(child: Text(b, style: const TextStyle(color: kMutedColor, height: 1.45, fontSize: 13))),
                  ]))),
                ])),
            ],
            if (widget.job.topProjects.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text('Top Projects', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: cs.primary)),
              const SizedBox(height: 8),
              ...widget.job.topProjects.map((p) => Padding(padding: const EdgeInsets.only(bottom: 10), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(width: 6, height: 6, margin: const EdgeInsets.only(top: 6, right: 10), decoration: BoxDecoration(color: cs.primary, shape: BoxShape.circle)),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(p.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                  const SizedBox(height: 2),
                  Text(p.detail, style: const TextStyle(color: kMutedColor, height: 1.45, fontSize: 13)),
                ])),
              ]))),
            ],
          ]),
          crossFadeState: expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ]))),
    ]))));
  }
}

class SkillTag extends StatelessWidget {
  const SkillTag(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(color: const Color(0x263DD6C6), borderRadius: BorderRadius.circular(6)),
    child: Text(text, style: const TextStyle(color: kAccent, fontSize: 12, fontWeight: FontWeight.w600)),
  );
}

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const SectionTitle('Featured Projects', 'Highlights across remote control, media, AI, AR, productivity, and education.')
        .animate().fadeIn(duration: 480.ms).slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic),
    LayoutBuilder(builder: (context, c) {
      final cols = c.maxWidth > 900 ? 3 : (c.maxWidth > 560 ? 2 : 1);
      final aspect = cols == 3 ? 0.68 : (cols == 2 ? 0.72 : 1.0);
      if (cols == 1) {
        return Column(children: List.generate(kFeaturedProjects.length, (i) {
          final p = kFeaturedProjects[i];
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: ProjectCard(project: p, index: i, featured: i < 2)
                .animate()
                .fadeIn(delay: (80 + i * 55).ms, duration: 480.ms, curve: Curves.easeOutCubic)
                .slideY(begin: 0.12, end: 0, curve: Curves.easeOutCubic),
          );
        }));
      }
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: cols,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: aspect,
        ),
        itemCount: kFeaturedProjects.length,
        itemBuilder: (context, i) {
          final p = kFeaturedProjects[i];
          return ProjectCard(project: p, index: i, featured: i < 2)
              .animate()
              .fadeIn(delay: (80 + i * 55).ms, duration: 480.ms, curve: Curves.easeOutCubic)
              .slideY(begin: 0.12, end: 0, curve: Curves.easeOutCubic);
        },
      );
    }),
  ]);
}

class ProjectCard extends StatefulWidget {
  const ProjectCard({super.key, required this.project, required this.index, this.featured = false});
  final FeaturedProject project;
  final int index;
  final bool featured;
  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool hover = false;
  static const gradients = [
    [Color(0xFF3DD6C6), Color(0xFF2563EB)], [Color(0xFF7C3AED), Color(0xFF3DD6C6)],
    [Color(0xFFEA580C), Color(0xFFEAB308)], [Color(0xFF2563EB), Color(0xFF7C3AED)],
    [Color(0xFF16A34A), Color(0xFF3DD6C6)], [Color(0xFFDB2777), Color(0xFF7C3AED)],
  ];

  Future<void> _openLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final grad = gradients[widget.index % gradients.length];
    final links = p.activeLinks;

    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedScale(
        scale: hover ? 1.013 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: hover ? [BoxShadow(color: grad[0].withValues(alpha: 0.2), blurRadius: 24)] : [],
          ),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(height: 6, decoration: BoxDecoration(gradient: LinearGradient(colors: grad))),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.featured)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                Icon(Icons.star_rounded, size: 14, color: grad[0]),
                                const SizedBox(width: 4),
                                Text(
                                  'FEATURED',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.1,
                                    color: grad[0],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: grad[0].withValues(alpha: isDark ? 0.2 : 0.12),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            p.badge.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
                              color: grad[0],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(p.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
                        if (p.subtitle.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            p.subtitle,
                            style: TextStyle(fontSize: 13, color: grad[0].withValues(alpha: 0.95), fontWeight: FontWeight.w500),
                          ),
                        ],
                        const SizedBox(height: 8),
                        Text(
                          p.desc,
                          style: const TextStyle(color: kMutedColor, height: 1.45, fontSize: 14),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (p.stats.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          ProjectStatsRow(stats: p.stats, accent: grad[0]),
                        ],
                        const SizedBox(height: 10),
                        Wrap(spacing: 6, runSpacing: 6, children: p.tags.map((t) => SkillTag(t)).toList()),
                        const Spacer(),
                        if (links.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          ProjectLinksRow(links: links, accent: grad[0], onOpen: _openLink),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Stats row like the reference portfolio (downloads, rating, etc.).
class ProjectStatsRow extends StatelessWidget {
  const ProjectStatsRow({super.key, required this.stats, required this.accent});
  final List<ProjectStat> stats;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: stats.asMap().entries.map((e) {
        final s = e.value;
        final isLast = e.key == stats.length - 1;
        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: accent.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    children: [
                      Text(s.value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: accent)),
                      Text(s.label, style: const TextStyle(fontSize: 11, color: kMutedColor)),
                    ],
                  ),
                ),
              ),
              if (!isLast) const SizedBox(width: 8),
            ],
          ),
        );
      }).toList(),
    );
  }
}

/// Play Store / website link buttons (reference-style).
class ProjectLinksRow extends StatelessWidget {
  const ProjectLinksRow({super.key, required this.links, required this.accent, required this.onOpen});
  final List<ProjectLink> links;
  final Color accent;
  final Future<void> Function(String url) onOpen;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: links.map((link) {
        return OutlinedButton.icon(
          onPressed: () => onOpen(link.url),
          icon: Icon(Icons.open_in_new_rounded, size: 15, color: accent),
          label: Text(link.label),
          style: OutlinedButton.styleFrom(
            foregroundColor: accent,
            side: BorderSide(color: accent.withValues(alpha: 0.45)),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        );
      }).toList(),
    );
  }
}

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});
  @override
  Widget build(BuildContext context) {
    final groups = kSkillGroups;
    final mid = (groups.length / 2).ceil();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SectionTitle('Technical Expertise', 'Languages, architecture, async, data, networking, and shipping.')
          .animate().fadeIn(duration: 480.ms).slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic),
      LayoutBuilder(builder: (context, c) {
        if (c.maxWidth > 640) {
          return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(child: Column(children: [for (var i = 0; i < mid; i++) Padding(padding: const EdgeInsets.only(bottom: 12), child: SkillGroupCard(title: groups[i].title, tags: groups[i].tags).animate().fadeIn(delay: (60 + i * 50).ms, duration: 450.ms).slideX(begin: -0.03, end: 0, curve: Curves.easeOutCubic))])),
            const SizedBox(width: 12),
            Expanded(child: Column(children: [for (var i = mid; i < groups.length; i++) Padding(padding: const EdgeInsets.only(bottom: 12), child: SkillGroupCard(title: groups[i].title, tags: groups[i].tags).animate().fadeIn(delay: (60 + (i - mid) * 50).ms, duration: 450.ms).slideX(begin: 0.03, end: 0, curve: Curves.easeOutCubic))])),
          ]);
        }
        return Column(children: [for (var i = 0; i < groups.length; i++) Padding(padding: const EdgeInsets.only(bottom: 12), child: SkillGroupCard(title: groups[i].title, tags: groups[i].tags).animate().fadeIn(delay: (50 + i * 45).ms, duration: 450.ms).slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic))]);
      }),
      const SizedBox(height: 24),
      LayoutBuilder(builder: (context, c) {
        final itemW = c.maxWidth < 400 ? (c.maxWidth - 12) / 2 : 130.0;
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: [
            for (var i = 0; i < kMetrics.length; i++)
              SizedBox(
                width: itemW,
                child: MetricCard(value: kMetrics[i].value, label: kMetrics[i].label)
                    .animate()
                    .fadeIn(delay: (200 + i * 80).ms, duration: 500.ms, curve: Curves.easeOutCubic)
                    .scale(begin: const Offset(0.92, 0.92), curve: Curves.easeOutBack),
              ),
          ],
        );
      }),
    ]);
  }
}

class SkillGroupCard extends StatelessWidget {
  const SkillGroupCard({super.key, required this.title, required this.tags});
  final String title;
  final List<String> tags;
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return HoverLift(scaleEnd: 1.008, child: Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(width: 3, height: 14, decoration: BoxDecoration(color: cs.primary, borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(color: kMutedColor, fontWeight: FontWeight.w600, fontSize: 13)),
      ]),
      const SizedBox(height: 12),
      Wrap(spacing: 8, runSpacing: 8, children: tags.map((t) => SkillTag(t)).toList()),
    ]))));
  }
}

class MetricCard extends StatelessWidget {
  const MetricCard({super.key, required this.value, required this.label});
  final String value, label;
  @override
  Widget build(BuildContext context) => Card(
    color: const Color(0x263DD6C6),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Color(0x403DD6C6))),
    child: Padding(padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8), child: Column(children: [
      Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: kAccent), textAlign: TextAlign.center),
      const SizedBox(height: 4),
      Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, color: kMutedColor)),
    ])),
  );
}

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SectionTitle('Education', 'Formal training that underpins years of Android delivery.')
          .animate().fadeIn(duration: 480.ms).slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic),
      HoverLift(child: Card(child: IntrinsicHeight(child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(width: 4, decoration: BoxDecoration(color: cs.primary, borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)))),
        Expanded(child: Padding(padding: const EdgeInsets.all(20), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(width: 48, height: 48, decoration: BoxDecoration(color: cs.primary.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)), child: Icon(Icons.school_rounded, color: cs.primary, size: 26)),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(kEducationTitle, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
            const SizedBox(height: 4),
            Text('The University of Poonch Rawalakot', style: TextStyle(color: cs.primary, fontWeight: FontWeight.w600, fontSize: 14)),
            const SizedBox(height: 4),
            Text(kEducationMeta, style: const TextStyle(color: kMutedColor, fontSize: 13)),
            const SizedBox(height: 10),
            Text(kEducationSummary, style: const TextStyle(color: kMutedColor, fontSize: 14, height: 1.5)),
            const SizedBox(height: 12),
            Wrap(spacing: 6, runSpacing: 6, children: ['Computer Science', 'Android', 'Software Engineering'].map((t) => SkillTag(t)).toList()),
          ])),
        ]))),
      ])))).animate().fadeIn(delay: 100.ms, duration: 500.ms).slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic),
    ]);
  }
}

class ConnectSection extends StatelessWidget {
  const ConnectSection({super.key, required this.muted, required this.onGithub, required this.onLinkedIn, required this.onEmail, required this.onPhone});
  final Color muted;
  final VoidCallback onGithub, onLinkedIn, onEmail, onPhone;
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const SectionTitle("Let's Connect", 'Available for roles that value solid Android craft.')
        .animate().fadeIn(duration: 480.ms).slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic),
    LayoutBuilder(builder: (context, c) {
      final row = c.maxWidth > 640;
      final linksCard = ContactCard(onEmail: onEmail, onPhone: onPhone, onLinkedIn: onLinkedIn, onGithub: onGithub).animate().fadeIn(duration: 500.ms).slideX(begin: -0.04, end: 0, curve: Curves.easeOutCubic);
      final whyCard = WhyCard(muted: muted).animate().fadeIn(delay: 120.ms, duration: 500.ms).slideX(begin: 0.04, end: 0, curve: Curves.easeOutCubic);
      if (row) return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: linksCard), const SizedBox(width: 16), Expanded(child: whyCard)]);
      return Column(children: [linksCard, const SizedBox(height: 16), whyCard]);
    }),
  ]);
}

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.onEmail, required this.onPhone, required this.onLinkedIn, required this.onGithub});
  final VoidCallback onEmail, onPhone, onLinkedIn, onGithub;
  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.mail_outline_rounded, 'Email', kPortfolioEmail, onEmail),
      (Icons.phone_outlined, 'Phone', kPortfolioPhoneDisplay, onPhone),
      (Icons.work_outline_rounded, 'LinkedIn', kPortfolioLinkedInDisplay, onLinkedIn),
      (Icons.code_rounded, 'GitHub', 'github.com/$kPortfolioGithubUser', onGithub),
      (Icons.location_on_outlined, 'Location', kPortfolioLocation, () {}),
    ];
    return HoverLift(child: Card(child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Get in Touch', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
      const SizedBox(height: 16),
      ...items.map((item) => ContactRow(icon: item.$1, label: item.$2, value: item.$3, onTap: item.$4)),
    ]))));
  }
}

class ContactRow extends StatefulWidget {
  const ContactRow({super.key, required this.icon, required this.label, required this.value, required this.onTap});
  final IconData icon;
  final String label, value;
  final VoidCallback onTap;
  @override
  State<ContactRow> createState() => _ContactRowState();
}
class _ContactRowState extends State<ContactRow> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: InkWell(onTap: widget.onTap, borderRadius: BorderRadius.circular(10), child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        margin: const EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(color: hover ? cs.primary.withValues(alpha: 0.08) : Colors.transparent, borderRadius: BorderRadius.circular(10)),
        child: Row(children: [
          Container(width: 36, height: 36, decoration: BoxDecoration(color: cs.primary.withValues(alpha: hover ? 0.2 : 0.1), borderRadius: BorderRadius.circular(8)), child: Icon(widget.icon, size: 18, color: cs.primary)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(widget.label, style: const TextStyle(fontSize: 11, color: kMutedColor, fontWeight: FontWeight.w500)),
            Text(widget.value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: hover ? cs.primary : null)),
          ])),
          Icon(Icons.open_in_new_rounded, size: 16, color: hover ? cs.primary : kMutedColor),
        ]),
      )),
    );
  }
}

class WhyCard extends StatelessWidget {
  const WhyCard({super.key, required this.muted});
  final Color muted;
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return HoverLift(child: Card(child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Why Work With Me', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
      const SizedBox(height: 16),
      ...kWhyWorkWithMe.asMap().entries.map((e) => Padding(padding: const EdgeInsets.only(bottom: 12), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(width: 28, height: 28, decoration: BoxDecoration(color: cs.primary.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(7)), child: Center(child: Text('${e.key + 1}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: cs.primary)))),
        const SizedBox(width: 12),
        Expanded(child: Text(e.value, style: TextStyle(color: muted, height: 1.5, fontSize: 14))),
      ]))),
      const SizedBox(height: 8),
      Divider(color: cs.onSurface.withValues(alpha: 0.12)),
      const SizedBox(height: 12),
      Text(
        '“$kRecommendationQuote”',
        style: TextStyle(color: muted.withValues(alpha: 0.9), height: 1.55, fontSize: 13, fontStyle: FontStyle.italic),
      ),
      const SizedBox(height: 6),
      Text(
        '— Abdul Samad Tayyab · LinkedIn recommendation',
        style: TextStyle(color: cs.primary.withValues(alpha: 0.85), fontSize: 12, fontWeight: FontWeight.w600),
      ),
    ]))));
  }
}

class PortfolioFooter extends StatelessWidget {
  const PortfolioFooter({super.key, required this.onLinkedIn, required this.onGithub, required this.onEmail});
  final VoidCallback onLinkedIn, onGithub, onEmail;
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: isDark ? const Color(0x14FFFFFF) : const Color(0x14000000)))),
      child: Column(children: [
        Text.rich(TextSpan(style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: -0.5), children: [
          TextSpan(text: kBrandFirst, style: TextStyle(color: cs.onSurface)),
          TextSpan(text: kBrandAccent, style: TextStyle(color: cs.primary)),
        ])),
        const SizedBox(height: 8),
        const Text(kHeroRole, style: TextStyle(color: kMutedColor, fontSize: 14)),
        const SizedBox(height: 16),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SocialIconBtn(tooltip: 'LinkedIn', icon: Icons.work_outline_rounded, onTap: onLinkedIn),
          SocialIconBtn(tooltip: 'GitHub', icon: Icons.code_rounded, onTap: onGithub),
          SocialIconBtn(tooltip: 'Email', icon: Icons.mail_outline_rounded, onTap: onEmail),
        ]),
        const SizedBox(height: 20),
        Text('© ${DateTime.now().year} $kHeroName · Android Developer', textAlign: TextAlign.center, style: const TextStyle(color: kMutedColor, fontSize: 13)),
      ]),
    );
  }
}
