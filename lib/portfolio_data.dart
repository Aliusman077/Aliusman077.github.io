// Content for Ali Usman's portfolio (Flutter web).
// Profile: https://www.linkedin.com/in/ali-usman-a44548219

const String kPortfolioEmail = 'aliusmankhan077@gmail.com';
const String kPortfolioPhoneDisplay = '+92 308 9750550';
const String kPortfolioPhoneTel = '+923089750550';
const String kPortfolioGithubUser = 'Aliusman077';
const String kPortfolioLinkedInUrl =
    'https://www.linkedin.com/in/ali-usman-a44548219';
const String kPortfolioLinkedInDisplay = 'linkedin.com/in/ali-usman-a44548219';
const String kPortfolioLocation = 'Islamabad, Pakistan';

const String kHeroName = 'Ali Usman';
const String kHeroNameFirst = 'Ali ';
const String kHeroNameAccent = 'Usman';
const String kBrandFirst = 'Ali ';
const String kBrandAccent = 'Usman.';
const String kHeroRole =
    'Android Developer | Jetpack Compose · Kotlin · MVVM · Clean Architecture';
const String kHeroTagline =
    'Building modern, scalable, and performance-optimized Android apps with clean code, '
    'modular architecture, and responsive Jetpack Compose UIs.';
const String kHeroStatsLine =
    '4+ years · 25+ apps delivered · Compose · MVVM · Clean Architecture';

/// Shown under the hero name — signals availability to recruiters.
const String kAvailabilityLabel = 'Open to Android roles · Full-time · Remote';

/// Quick-scan tech stack for recruiters (hero chip row).
const List<String> kCoreTechnologies = [
  'Kotlin',
  'Jetpack Compose',
  'MVVM',
  'Clean Architecture',
  'Coroutines',
  'Firebase',
  'Room',
  'Retrofit',
  'Hilt / Koin',
  'Play Store',
];

const String kAboutIntro =
    'I am a motivated Android developer with 4+ years of experience shipping modern, scalable, '
    'and performance-optimized mobile applications. I specialize in Jetpack Compose, Kotlin, and '
    'MVVM with Clean Architecture—focused on clean structure, modularity, and maintainability. '
    'My stack includes Coroutines, StateFlow, LiveData, Navigation Component, Room, and Retrofit, '
    'with dependency injection via Koin or Hilt and monitoring through Firebase Crashlytics. '
    'I care about launch time, stability, lifecycle-aware code, and collaborating in Agile teams.';

const List<String> kProfessionalSummaryBullets = [
  'Android support for Switch flagship products—FitFlex (fitness VAS on Zong/Jazz) and Ersaal (smart SMS on Jazz).',
  'Jetpack Compose UIs with MVVM, Clean Architecture, SOLID, and modularization for testable codebases.',
  'Async and state: Coroutines, Flows, StateFlow, and LiveData; offline-first with Room and Realm.',
  'Networking and backend: Retrofit, Ktor, REST APIs, WebSockets, and Firebase (Auth, Firestore, Crashlytics).',
  '25+ apps across utility, productivity, AI, media, remote control, and photo editing—including Play Store releases.',
  'Maps, media, and AR: Google Maps, Mapbox, ARCore, CameraX, ExoPlayer, ML Kit, and TensorFlow Lite.',
  'Performance and security: profiling, ProGuard/R8, certificate pinning, and crash-free session improvements.',
  'Cross-functional delivery with UI/UX and backend teams—code reviews, Git, Agile/Scrum, and mentoring.',
];

const List<AboutHighlight> kAboutHighlights = [
  AboutHighlight(
    title: 'Compose & architecture',
    body:
        'Jetpack Compose, MVVM, Clean Architecture, MVI patterns, and modularization for scalable Android products.',
  ),
  AboutHighlight(
    title: '25+ shipped applications',
    body:
        'Consumer and B2B apps on Play Store—utility, productivity, AI, media, remote control, and creative tools.',
  ),
  AboutHighlight(
    title: 'Performance & quality',
    body:
        'Lifecycle-aware code, memory management, faster launches, fewer ANRs/crashes, and Crashlytics-driven monitoring.',
  ),
  AboutHighlight(
    title: 'Integrations',
    body:
        'Retrofit, Firebase, ML Kit, billing, AdMob, ExoPlayer, Glide, Coil, and operator or third-party APIs.',
  ),
  AboutHighlight(
    title: 'Maps, AR & camera',
    body:
        'Google Maps, Mapbox, ARCore, and CameraX for location, navigation, and media-heavy experiences.',
  ),
  AboutHighlight(
    title: 'Team collaboration',
    body:
        'Works with product, design, and backend teams using Git, Agile/Scrum, code reviews, and clear communication.',
  ),
];

const List<JobEntry> kJobs = [
  JobEntry(
    title: 'Mobile Application Developer',
    company: 'Switch Communications',
    meta: 'January 2026 – Present · Islamabad, Pakistan',
    summary:
        'Android apps for telecom and digital products at Pakistan’s leading value-added services provider—Kotlin, '
        'Jetpack Compose, and Clean Architecture.',
    bullets: [
      'Develop and support Android apps including FitFlex and Ersaal—telecom VAS with operator billing and subscriptions.',
      'Develop and maintain Android applications for consumer and B2B mobile products.',
      'Integrate REST APIs, Firebase, and operator billing/APIs with scalable, maintainable architecture.',
      'Collaborate with product, design, and backend teams from planning through Play Store release.',
      'Focus on performance, stability, store compliance, code reviews, and Agile delivery.',
    ],
    topProjects: [
      TopProject(
        name: 'FitFlex',
        detail:
            'Switch Communications fitness VAS—personalized workouts (2,000+ exercises), meal plans, AI food scanner, '
            'and nutrition tracking. Operator billing on Jazz and Zong. Android support.',
      ),
      TopProject(
        name: 'Ersaal',
        detail:
            'Smart default SMS app by Switch—folder management, schedule send, SMS broadcast, web messaging, '
            'pinned chats, and end-to-end encryption. Jazz VAS subscriptions; high install base. Android support.',
      ),
      TopProject(
        name: 'Universal TV Remote Control App',
        detail:
            'Control TVs and set-top devices; high engagement on Play Store. Kotlin, Jetpack Compose, IR/Bluetooth.',
      ),
      TopProject(
        name: 'Photo Editor App',
        detail:
            'Filters, backgrounds, text and fonts, stickers, frames, crop/resize, draw tools, layers, and export—optimized for mid-range devices.',
      ),
    ],
    tags: [
      'Kotlin',
      'Jetpack Compose',
      'Clean Architecture',
      'Firebase',
      'REST',
      'Play Store',
    ],
  ),
  JobEntry(
    title: 'Android Engineer',
    company: 'Ninesol Technologies',
    meta: 'October 2023 – January 2026 · Islamabad, Pakistan',
    summary:
        'Designed and delivered modern Android applications with Kotlin, Jetpack Compose, and the Android SDK.',
    bullets: [
      'Built apps with Room, Navigation Component, Flows, and LiveData for maintainable architecture.',
      'Collaborated with UI/UX and backend teams on responsive, high-quality mobile experiences.',
      'Improved performance and reliability—reduced crashes and optimized load times.',
      'Integrated REST APIs, Firebase, and third-party SDKs; applied Clean Architecture and MVVM.',
    ],
    topProjects: [
      TopProject(
        name: 'SOAPSUDS',
        detail:
            'AI-powered medical communication between doctors and patients—notes, messages, and remote consultations.',
      ),
      TopProject(
        name: 'NoteIQ',
        detail:
            'AI meeting assistant that records discussions and generates structured notes, summaries, and reports.',
      ),
      TopProject(
        name: 'SkinCare AI',
        detail: 'Personalized skincare recommendations with ML Kit integration.',
      ),
      TopProject(
        name: 'Chatly',
        detail:
            'AI conversational and research assistant with intelligent search and multi-model reasoning.',
      ),
      TopProject(
        name: 'Wifi AR',
        detail:
            'ARCore visualization of Wi‑Fi signal strength and metadata in the physical environment. MVVM, Koin.',
      ),
      TopProject(
        name: 'AI-Powered Image Editing App',
        detail:
            'ML Kit background removal, CameraX, templates; MVVM, Hilt, ViewModel, LiveData.',
      ),
      TopProject(
        name: 'PDF Reader',
        detail:
            'Create, edit, merge, compress, sign, annotate, and image-to-PDF; optimized for large documents.',
      ),
      TopProject(
        name: 'Quran Learning',
        detail:
            'Quran and Hadith, Tarteel practice, Namaz reminders, and real-time socket-based Tarteel feedback.',
      ),
      TopProject(
        name: 'Multilingual Keyboard App',
        detail:
            'Custom IME with multiple languages, predictive text, emoji, and customizable themes.',
      ),
    ],
    tags: [
      'Kotlin',
      'Compose',
      'Room',
      'Firebase',
      'MVVM',
      'ML Kit',
      'ARCore',
    ],
  ),
  JobEntry(
    title: 'Android Developer',
    company: 'FHA Technologies',
    meta: 'July 2021 – September 2023 · Pakistan',
    summary:
        'Built Android applications from scratch in Java and Kotlin with MVVM and maintainable modular structure.',
    bullets: [
      'Implemented MVVM, View Binding, and Navigation Component for scalable apps.',
      'Integrated Retrofit and Ktor APIs; Firebase, Realm, and Room for persistence and sync.',
      'Delivered Google Maps–based features; optimized performance with Glide and Coroutines.',
      'Contributed in Agile teams—sprint planning, code reviews, and Play Store releases.',
    ],
    topProjects: [
      TopProject(
        name: 'Location and map applications',
        detail: 'Google Maps and Mapbox navigation and tracking for B2B clients.',
      ),
      TopProject(
        name: 'Utility and productivity apps',
        detail: 'Multiple Java/Kotlin apps from scratch for B2B and B2C, published on Play Store.',
      ),
    ],
    tags: [
      'Java',
      'Kotlin',
      'MVVM',
      'Google Maps',
      'Retrofit',
      'Realm',
    ],
  ),
];

// Add Play Store / website URLs in [links] when ready — empty url hides that button.
const List<FeaturedProject> kFeaturedProjects = [
  FeaturedProject(
    badge: 'Featured · Fitness',
    name: 'FitFlex',
    subtitle: 'Health & fitness · Switch Communications',
    desc:
        'Personalized workout and meal plans, 2,000+ exercises, AI food scanner, and progress tracking. '
        'Operator VAS on Zong and Jazz.',
    links: [
      ProjectLink(
        'Play Store',
        'https://play.google.com/store/apps/details?id=fitflex.workout.fitness.weight.gym.fat.training',
      ),
      ProjectLink('Website', 'https://switch.com.pk/services/digital-products/fitflex'),
    ],
    tags: ['Kotlin', 'Compose', 'Operator Billing', 'Fitness', 'Firebase'],
  ),
  FeaturedProject(
    badge: 'Featured · Telecom',
    name: 'Ersaal',
    subtitle: 'Smart SMS · Switch / Jazz',
    desc:
        'Default SMS replacement with folders, schedule send, broadcast, web messaging, pinned chats, and E2E encryption.',
    stats: [
      ProjectStat('400K+', 'Installs'),
    ],
    links: [
      ProjectLink('Website', 'https://ersaal.pk/'),
      ProjectLink('Jazz VAS', 'https://jazz.com.pk/prepaid/ersaal'),
    ],
    tags: ['Kotlin', 'MVVM', 'WebSockets', 'Room', 'Operator Billing'],
  ),
  FeaturedProject(
    badge: 'Consumer',
    name: 'Universal TV Remote Control',
    subtitle: 'IR & Bluetooth remote',
    desc: 'Control TVs and set-top devices with strong Play Store engagement; Kotlin, Jetpack Compose.',
    links: [
      ProjectLink('Play Store', ''), // TODO: paste Play Store URL
    ],
    tags: ['Kotlin', 'Compose', 'Bluetooth', 'IR', 'Play Store'],
  ),
  FeaturedProject(
    badge: 'Creative',
    name: 'Photo Editor App',
    subtitle: 'Photo editing suite',
    desc: 'Filters, backgrounds, typography, stickers, frames, layers, drawing tools, and fast export.',
    links: [
      ProjectLink('Play Store', ''),
    ],
    tags: ['Compose', 'Performance', 'CameraX'],
  ),
  FeaturedProject(
    badge: 'Health / AI',
    name: 'SOAPSUDS',
    subtitle: 'Medical communication',
    desc: 'AI-assisted doctor–patient notes, messaging, and remote consultations.',
    links: [ProjectLink('Play Store', '')],
    tags: ['Clean Architecture', 'Kotlin', 'AI'],
  ),
  FeaturedProject(
    badge: 'Productivity / AI',
    name: 'NoteIQ',
    subtitle: 'AI meeting assistant',
    desc: 'Meeting capture with AI-generated structured notes, summaries, and reports.',
    links: [ProjectLink('Play Store', '')],
    tags: ['AI', 'Audio', 'Kotlin'],
  ),
  FeaturedProject(
    badge: 'Health / AI',
    name: 'SkinCare AI',
    subtitle: 'Personalized skincare',
    desc: 'Personalized skincare guidance with ML Kit-driven analysis.',
    links: [ProjectLink('Play Store', '')],
    tags: ['ML Kit', 'Kotlin', 'AI'],
  ),
  FeaturedProject(
    badge: 'AI',
    name: 'Chatly',
    subtitle: 'AI assistant',
    desc: 'Conversational and research assistant—search, generation, and deep reasoning.',
    links: [ProjectLink('Play Store', '')],
    tags: ['AI', 'Kotlin', 'Networking'],
  ),
  FeaturedProject(
    badge: 'AI / Creative',
    name: 'AI-Powered Image Editing',
    subtitle: 'ML image tools',
    desc: 'ML Kit workflows, CameraX, and templates with MVVM and Hilt.',
    links: [ProjectLink('Play Store', '')],
    tags: ['ML Kit', 'Hilt', 'CameraX'],
  ),
  FeaturedProject(
    badge: 'AR',
    name: 'Wifi AR',
    subtitle: 'Wi‑Fi visualization',
    desc: 'ARCore overlay of Wi‑Fi strength and metadata in the real world.',
    links: [ProjectLink('Play Store', '')],
    tags: ['ARCore', 'MVVM', 'Koin'],
  ),
  FeaturedProject(
    badge: 'Productivity',
    name: 'PDF Reader',
    subtitle: 'Document toolkit',
    desc: 'Full PDF toolkit—edit, merge, compress, sign, annotate, and image-to-PDF.',
    links: [ProjectLink('Play Store', '')],
    tags: ['MVVM', 'Koin', 'Documents'],
  ),
  FeaturedProject(
    badge: 'Education',
    name: 'Quran Learning',
    subtitle: 'Quran & Hadith',
    desc: 'Quran and Hadith, Tarteel practice, Namaz reminders, and real-time socket feedback.',
    links: [ProjectLink('Play Store', '')],
    tags: ['Hilt', 'Sockets', 'Clean Architecture'],
  ),
  FeaturedProject(
    badge: 'Productivity',
    name: 'Multilingual Keyboard',
    subtitle: 'Custom IME',
    desc: 'Custom IME with languages, prediction, emoji, and themes.',
    links: [ProjectLink('Play Store', '')],
    tags: ['IME', 'MVVM', 'Koin'],
  ),
];

const List<SkillGroupData> kSkillGroups = [
  SkillGroupData(
    title: 'Languages & UI',
    tags: [
      'Java',
      'Kotlin',
      'XML',
      'Jetpack Compose',
      'Android SDK',
      'Material Design',
      'View Binding',
    ],
  ),
  SkillGroupData(
    title: 'Architecture & patterns',
    tags: ['MVVM', 'MVI', 'Clean Architecture', 'Modularization', 'SOLID', 'OOP'],
  ),
  SkillGroupData(
    title: 'Async & state',
    tags: ['Coroutines', 'Flows', 'LiveData', 'StateFlow'],
  ),
  SkillGroupData(
    title: 'Data & local',
    tags: ['Room', 'Realm', 'DataStore', 'SharedPreferences'],
  ),
  SkillGroupData(
    title: 'Networking',
    tags: ['Retrofit', 'Ktor', 'OkHttp', 'REST APIs', 'WebSockets'],
  ),
  SkillGroupData(
    title: 'Dependency injection',
    tags: ['Koin', 'Hilt', 'Dagger'],
  ),
  SkillGroupData(
    title: 'Google, maps & Jetpack',
    tags: [
      'Firebase',
      'Crashlytics',
      'Firestore',
      'Google Maps',
      'Mapbox',
      'Navigation Component',
      'ViewModel',
      'WorkManager',
      'Jetpack libraries',
    ],
  ),
  SkillGroupData(
    title: 'Media, ML & AR',
    tags: ['CameraX', 'ML Kit', 'TensorFlow Lite', 'ARCore', 'ExoPlayer', 'Glide', 'Coil'],
  ),
  SkillGroupData(
    title: 'Quality, release & tools',
    tags: [
      'Git',
      'GitHub',
      'Agile',
      'Scrum',
      'Jira',
      'Play Store',
      'Unit testing',
      'Espresso',
      'Mockito',
      'ProGuard',
      'R8',
      'CI/CD',
      'Android Studio',
      'Figma',
      'Performance optimization',
      'In-App Billing',
      'AdMob',
    ],
  ),
];

const List<MetricData> kMetrics = [
  MetricData(value: '4+', label: 'Years experience'),
  MetricData(value: '25+', label: 'Apps delivered'),
  MetricData(value: '3', label: 'Companies'),
  MetricData(value: 'Compose', label: 'Primary UI stack'),
];

const String kEducationTitle = 'Bachelor of Science in Computer Science';
const String kEducationMeta = '2017 – 2021 · The University of Poonch · GPA 3.5';
const String kEducationSummary =
    'Computer science foundation with strong focus on software engineering and Android development practice.';

const List<String> kWhyWorkWithMe = [
  '4+ years building production Android apps with Compose, MVVM, and Clean Architecture',
  '25+ apps across utility, productivity, AI, and consumer domains',
  'Strong collaborator—clear communication, code reviews, and Agile delivery',
  'Open to Android developer roles—full-time, freelance, or remote',
];

/// Short testimonial from LinkedIn (Abdul Samad Tayyab).
const String kRecommendationQuote =
    'Skilled and dedicated Android developer with strong problem-solving and clean code practices—'
    'delivers high-quality work and collaborates effectively with the team.';

class AboutHighlight {
  const AboutHighlight({required this.title, required this.body});
  final String title;
  final String body;
}

class TopProject {
  const TopProject({required this.name, required this.detail});
  final String name;
  final String detail;
}

class JobEntry {
  const JobEntry({
    required this.title,
    required this.company,
    required this.meta,
    required this.summary,
    required this.bullets,
    required this.topProjects,
    required this.tags,
  });

  final String title;
  final String company;
  final String meta;
  final String summary;
  final List<String> bullets;
  final List<TopProject> topProjects;
  final List<String> tags;
}

/// External link on a project card (reference-style). Leave [url] empty to hide until you add it.
class ProjectLink {
  const ProjectLink(this.label, this.url);
  final String label;
  final String url;
  bool get hasUrl => url.trim().isNotEmpty;
}

class ProjectStat {
  const ProjectStat(this.value, this.label);
  final String value;
  final String label;
}

class FeaturedProject {
  const FeaturedProject({
    required this.badge,
    required this.name,
    required this.desc,
    required this.tags,
    this.subtitle = '',
    this.stats = const [],
    this.links = const [],
  });

  final String badge;
  final String name;
  final String subtitle;
  final String desc;
  final List<String> tags;
  final List<ProjectStat> stats;
  final List<ProjectLink> links;

  List<ProjectLink> get activeLinks => links.where((l) => l.hasUrl).toList();
}

class SkillGroupData {
  const SkillGroupData({required this.title, required this.tags});
  final String title;
  final List<String> tags;
}

class MetricData {
  const MetricData({required this.value, required this.label});
  final String value;
  final String label;
}

