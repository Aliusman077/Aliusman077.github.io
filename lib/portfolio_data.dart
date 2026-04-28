// Content for Ali Usman's portfolio (Flutter web).
// Update kPortfolioLinkedInUrl if your public profile slug differs.

const String kPortfolioEmail = 'aliusmankhan077@gmail.com';
const String kPortfolioPhoneDisplay = '+92 308 9750550';
const String kPortfolioPhoneTel = '+923089750550';
const String kPortfolioGithubUser = 'Aliusman077';
const String kPortfolioLinkedInUrl =
    'https://www.linkedin.com/in/aliusmankhan077';
const String kPortfolioLocation = 'Islamabad, Pakistan';

const String kHeroName = 'Ali Usman';
const String kHeroRole = 'Android Engineer';
const String kHeroTagline =
    'Designing and shipping high-performance Android applications with Kotlin, Jetpack Compose, '
    'MVVM, and Clean Architecture—focused on quality, performance, and maintainable code.';
const String kHeroStatsLine =
    '4+ years · 25+ apps delivered · Kotlin, Jetpack Compose & Clean Architecture';

/// Opening narrative (aligned with your professional summary).
const String kAboutIntro =
    'Android Engineer with 4+ years of experience designing, developing, and deploying '
    'high-performance mobile applications. I bridge polished user experiences with scalable '
    'codebases using the Android SDK, Jetpack, and modern architecture patterns. I have owned '
    'end-to-end lifecycles from requirement analysis through Play Store release, and I have '
    'delivered 25+ apps across utility, productivity, AI, and consumer domains—including '
    'photo editing, remote control, and media products for large user bases.';

/// Tight bullets mirroring your résumé highlights (shown under the intro).
const List<String> kProfessionalSummaryBullets = [
  'Led and contributed to consumer and B2B apps: remote control, video player, and photo-editing products.',
  'Integrations: REST APIs, Firebase (Auth, Firestore, Crashlytics), WebSockets, and ML Kit.',
  'State and async: Coroutines, Flows, LiveData, StateFlow; DI with Koin and Hilt.',
  'Offline-first persistence with Room and Realm; performance work via profiling, refactoring, and best practices.',
  'Maps, media, and AR: Google Maps, Mapbox, ARCore, CameraX, and Jetpack libraries.',
  'Collaboration with UI/UX and backend teams; sprint planning, code reviews, Agile delivery, and mentoring.',
  'Passionate about code quality, continuous learning, and Android solutions aligned with business goals.',
];

const List<AboutHighlight> kAboutHighlights = [
  AboutHighlight(
    title: 'Architecture you can evolve',
    body:
        'MVVM, Clean Architecture, SOLID, and OOP—readable, testable codebases that scale with the team '
        'and product.',
  ),
  AboutHighlight(
    title: '25+ shipped applications',
    body:
        'Utility, productivity, AI, and consumer apps on Play Store—including media, remote control, '
        'and creative tools.',
  ),
  AboutHighlight(
    title: 'Integrations & platform depth',
    body:
        'Retrofit, Ktor, OkHttp, Firebase, ML Kit, In-App Billing, AdMob, ExoPlayer, Glide, Coil, and more.',
  ),
  AboutHighlight(
    title: 'Performance & stability',
    body:
        'Reduced crashes and improved load times through profiling, ProGuard/R8, and disciplined refactors.',
  ),
  AboutHighlight(
    title: 'Maps, AR & camera',
    body:
        'Location and navigation with Google Maps and Mapbox; ARCore, CameraX, and media-heavy pipelines.',
  ),
  AboutHighlight(
    title: 'Team delivery',
    body:
        'Works with designers and backend engineers; mentors juniors and ships reliably in Agile environments.',
  ),
];

const List<JobEntry> kJobs = [
  JobEntry(
    title: 'Android Developer',
    company: 'Switch Communications',
    meta: 'January 2026 – Present · Islamabad, Pakistan',
    summary:
        'Android applications for consumer and B2B products using Kotlin, Jetpack Compose, and Clean Architecture.',
    bullets: [
      'Develop and maintain Android applications; integrate REST APIs, Firebase, and operator billing/APIs.',
      'Collaborate with product, design, and backend teams to deliver scalable, high-quality mobile experiences.',
      'Own features end-to-end from planning to Play Store release; ensure performance, stability, and store compliance.',
      'Participate in code reviews, sprint planning, and Agile delivery; mentor junior developers and promote best practices.',
    ],
    topProjects: [
      TopProject(
        name: 'Universal TV Remote Control App',
        detail:
            'Android app to control TV and set-top devices; strong engagement on Play Store. Kotlin, Jetpack Compose, IR/Bluetooth.',
      ),
      TopProject(
        name: 'Video Player App',
        detail:
            'Full-featured player: multiple formats, playback controls, playlists, casting. ExoPlayer, Jetpack Compose.',
      ),
      TopProject(
        name: 'Photo Editor App',
        detail:
            'Filters, custom backgrounds, text overlay and fonts, stickers, frames, crop and resize, draw and brush, '
            'layers, multi-format export—optimized for mid-range devices. Kotlin, Jetpack Compose.',
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
    title: 'Android Developer',
    company: 'Ninesol Technologies',
    meta: 'August 2023 – December 2025 · Islamabad, Pakistan',
    summary:
        'Designed, developed, and maintained modern Android applications with Kotlin, Jetpack Compose, and the Android SDK.',
    bullets: [
      'Implemented Room, Navigation Component, Flows, and LiveData for efficient, maintainable architecture.',
      'Collaborated with UI/UX designers and backend teams to deliver responsive, high-quality experiences.',
      'Optimized performance, scalability, and reliability—reducing crashes and improving load times.',
      'Integrated REST APIs, Firebase, and third-party libraries; applied Clean Architecture and MVVM.',
      'Stayed current with platform updates and applied modern practices across existing products.',
    ],
    topProjects: [
      TopProject(
        name: 'SOAPSUDS',
        detail:
            'AI-powered medical communication between doctors and patients—notes, messages, and remote consultations. Kotlin, Clean Architecture.',
      ),
      TopProject(
        name: 'NoteIQ',
        detail:
            'AI-driven meeting assistant: records discussions and auto-generates structured notes, summaries, and reports.',
      ),
      TopProject(
        name: 'SkinCare AI',
        detail:
            'Personalized AI skincare recommendations from user input and skin type; ML Kit integration.',
      ),
      TopProject(
        name: 'Chatly',
        detail:
            'Advanced AI conversational and research assistant—intelligent search, content generation, and multi-model reasoning.',
      ),
      TopProject(
        name: 'Wifi AR',
        detail:
            'ARCore app visualizing real-time Wi‑Fi networks with signal strength and metadata in the environment. MVVM, Koin.',
      ),
      TopProject(
        name: 'AI-Powered Image Editing App',
        detail:
            'ML Kit background removal, CameraX, customizable templates; MVVM, Hilt, ViewModel, LiveData.',
      ),
      TopProject(
        name: 'PDF Reader',
        detail:
            'Creation, editing, merging, compressing, signing, lock/unlock, annotations, image-to-PDF; MVVM, Koin, large documents.',
      ),
      TopProject(
        name: 'Quran Learning',
        detail:
            'Quran and Hadith, Tarteel practice and recording, Namaz reminders; real-time socket-based Tarteel feedback. Clean Architecture, Hilt.',
      ),
      TopProject(
        name: 'Multilingual Keyboard App',
        detail:
            'Custom Android keyboard—multiple languages, predictive text, emoji; language layouts and themes. MVVM, Koin, IMF.',
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
    meta: 'July 2021 – August 2023 · Islamabad, Pakistan',
    summary:
        'Built multiple Android applications from scratch in Java and Kotlin with clean, maintainable structure.',
    bullets: [
      'Implemented MVVM, View Binding, and Navigation Component for scalable, modular applications.',
      'Integrated RESTful APIs with Retrofit and Ktor; Firebase, Realm, and Room for persistence and real-time sync.',
      'Delivered location-based features with Google Maps API; optimized performance with Glide and Coroutines.',
      'Worked in Agile teams on sprint planning, feature design, and code reviews; Play Store standards and Git-based workflows.',
    ],
    topProjects: [
      TopProject(
        name: 'Location and map applications',
        detail:
            'Google Maps API and Mapbox—navigation and tracking solutions for B2B clients.',
      ),
      TopProject(
        name: 'Utility and productivity apps',
        detail:
            'Multiple Android apps (Java/Kotlin) from scratch for B2B and B2C, published on the Play Store.',
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

const List<FeaturedProject> kFeaturedProjects = [
  FeaturedProject(
    badge: 'Consumer',
    name: 'Universal TV Remote Control',
    desc:
        'Control TVs and set-top devices with high engagement on Play Store; IR/Bluetooth, Kotlin, Jetpack Compose.',
    tags: ['Kotlin', 'Compose', 'Bluetooth', 'IR', 'Play Store'],
  ),
  FeaturedProject(
    badge: 'Media',
    name: 'Video Player App',
    desc: 'Multi-format playback, playlists, casting, and polished controls with ExoPlayer.',
    tags: ['ExoPlayer', 'Compose', 'Kotlin'],
  ),
  FeaturedProject(
    badge: 'Creative',
    name: 'Photo Editor App',
    desc:
        'Filters, backgrounds, typography, stickers, frames, layers, drawing tools, and fast export for real devices.',
    tags: ['Compose', 'Performance', 'CameraX'],
  ),
  FeaturedProject(
    badge: 'Health / AI',
    name: 'SOAPSUDS',
    desc:
        'AI-assisted medical communication—doctor–patient notes, messaging, and remote consultations.',
    tags: ['Clean Architecture', 'Kotlin', 'AI'],
  ),
  FeaturedProject(
    badge: 'Productivity / AI',
    name: 'NoteIQ',
    desc: 'Meeting capture with AI-generated structured notes, summaries, and reports.',
    tags: ['AI', 'Audio', 'Kotlin'],
  ),
  FeaturedProject(
    badge: 'Health / AI',
    name: 'SkinCare AI',
    desc: 'Personalized skincare guidance with ML Kit-driven analysis.',
    tags: ['ML Kit', 'Kotlin', 'AI'],
  ),
  FeaturedProject(
    badge: 'AI',
    name: 'Chatly',
    desc: 'Research and conversational assistant—search, generation, and deep reasoning across models.',
    tags: ['AI', 'Kotlin', 'Networking'],
  ),
  FeaturedProject(
    badge: 'AI / Creative',
    name: 'AI-Powered Image Editing',
    desc: 'ML Kit workflows, CameraX, and templates with MVVM and Hilt.',
    tags: ['ML Kit', 'Hilt', 'CameraX'],
  ),
  FeaturedProject(
    badge: 'AR',
    name: 'Wifi AR',
    desc: 'ARCore overlay of Wi‑Fi strength and metadata in the physical environment.',
    tags: ['ARCore', 'MVVM', 'Koin'],
  ),
  FeaturedProject(
    badge: 'Productivity',
    name: 'PDF Reader',
    desc: 'Full PDF toolkit—edit, merge, compress, sign, annotate, and image-to-PDF at scale.',
    tags: ['MVVM', 'Koin', 'Documents'],
  ),
  FeaturedProject(
    badge: 'Education',
    name: 'Quran Learning',
    desc: 'Quran and Hadith, Tarteel practice, Namaz reminders, and real-time socket feedback.',
    tags: ['Hilt', 'Sockets', 'Clean Architecture'],
  ),
  FeaturedProject(
    badge: 'Productivity',
    name: 'Multilingual Keyboard',
    desc: 'Custom IME with languages, prediction, emoji, and themes.',
    tags: ['IME', 'MVVM', 'Koin'],
  ),
];

/// Grouped like a skills matrix (from your résumé technologies list).
const List<SkillGroupData> kSkillGroups = [
  SkillGroupData(
    title: 'Languages & UI',
    tags: [
      'Java',
      'Kotlin',
      'XML',
      'Jetpack Compose',
      'Android SDK',
      'NDK',
      'JNI',
      'Material Design',
      'View Binding',
    ],
  ),
  SkillGroupData(
    title: 'Architecture & patterns',
    tags: ['MVVM', 'MVC', 'MVP', 'Clean Architecture', 'OOP', 'SOLID'],
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
    tags: ['Retrofit', 'Ktor', 'Volley', 'OkHttp', 'REST APIs', 'WebSockets'],
  ),
  SkillGroupData(
    title: 'Dependency injection',
    tags: ['Koin', 'Hilt', 'Dagger'],
  ),
  SkillGroupData(
    title: 'Google, maps & Jetpack',
    tags: [
      'Firebase',
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
    tags: ['CameraX', 'ML Kit', 'ARCore', 'ExoPlayer', 'Glide', 'Coil'],
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
      'Postman',
      'Android Studio',
      'Figma',
      'Debugging',
      'Performance optimization',
      'In-App Billing',
      'AdMob',
      'Localization',
    ],
  ),
];

const List<MetricData> kMetrics = [
  MetricData(value: '4+', label: 'Years experience'),
  MetricData(value: '25+', label: 'Apps delivered'),
  MetricData(value: '3', label: 'Companies'),
  MetricData(value: 'Play Store', label: 'Shipping focus'),
];

const String kEducationTitle = 'Bachelor of Science in Computer Sciences';
const String kEducationMeta = '2021 · The University of Poonch Rawalakot';
const String kEducationSummary =
    'Formal computer science training supporting production Android engineering and continuous platform learning.';

const List<String> kWhyWorkWithMe = [
  '4+ years shipping production Android apps end-to-end',
  '25+ applications across utility, productivity, AI, and consumer domains',
  'Deep stack: Compose, Clean Architecture, Firebase, ML Kit, maps, and media pipelines',
  'Reliable collaborator in Agile teams—with code reviews, mentoring, and Play Store discipline',
];

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

class FeaturedProject {
  const FeaturedProject({
    required this.badge,
    required this.name,
    required this.desc,
    required this.tags,
  });

  final String badge;
  final String name;
  final String desc;
  final List<String> tags;
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
