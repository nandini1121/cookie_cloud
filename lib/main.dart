import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

// ─── Data ─────────────────────────────────────────────────────────────────────

final List<Map<String, dynamic>> products = [
  // Cookies
  {
    "name": "Classic Chocolate Chip",
    "price": 220,
    "category": "Cookies",
    "image":
        "https://images.unsplash.com/photo-1499636136210-6f4ee915583e?w=400&q=80",
    "rating": 4.8,
    "reviews": 312,
    "tag": "Bestseller",
  },
  {
    "name": "Red Velvet Cookie",
    "price": 260,
    "category": "Cookies",
    "image":
        "https://images.unsplash.com/photo-1558961363-fa8fdf82db35?w=400&q=80",
    "rating": 4.9,
    "reviews": 204,
    "tag": "New",
  },
  {
    "name": "Oatmeal Raisin Cookie",
    "price": 190,
    "category": "Cookies",
    "image":
        "https://images.unsplash.com/photo-1590080875515-8a3a8dc5735e?w=400&q=80",
    "rating": 4.5,
    "reviews": 98,
    "tag": "",
  },
  {
    "name": "Double Choco Cookie",
    "price": 240,
    "category": "Cookies",
    "image":
        "https://images.unsplash.com/photo-1606312619070-d48b4c652a52?w=400&q=80",
    "rating": 4.7,
    "reviews": 176,
    "tag": "Bestseller",
  },
  // Cakes
  {
    "name": "Vanilla Dream Cake",
    "price": 1450,
    "category": "Cakes",
    "image":
        "https://images.unsplash.com/photo-1464349095431-e9a21285b5f3?w=400&q=80",
    "rating": 5.0,
    "reviews": 98,
    "tag": "Premium",
  },
  {
    "name": "Cheesecake",
    "price": 1180,
    "category": "Cakes",
    "image":
        "https://images.unsplash.com/photo-1533134242443-d4fd215305ad?w=400&q=80",
    "rating": 4.9,
    "reviews": 87,
    "tag": "Premium",
  },
  {
    "name": "Strawberry Shortcake",
    "price": 1250,
    "category": "Cakes",
    "image":
        "https://images.unsplash.com/photo-1488477181946-6428a0291777?w=400&q=80",
    "rating": 4.8,
    "reviews": 143,
    "tag": "",
  },
  {
    "name": "Dark Chocolate Cake",
    "price": 1380,
    "category": "Cakes",
    "image":
        "https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=400&q=80",
    "rating": 4.9,
    "reviews": 211,
    "tag": "Bestseller",
  },
  // Brownies
  {
    "name": "Chocolate Brownie",
    "price": 280,
    "category": "Brownies",
    "image":
        "https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=400&q=80",
    "rating": 4.6,
    "reviews": 241,
    "tag": "Bestseller",
  },
  {
    "name": "Walnut Fudge Brownie",
    "price": 320,
    "category": "Brownies",
    "image":
        "https://images.unsplash.com/photo-1589985270826-4b7bb135bc9d?w=400&q=80",
    "rating": 4.7,
    "reviews": 134,
    "tag": "",
  },
  {
    "name": "Cream Cheese Brownie",
    "price": 350,
    "category": "Brownies",
    "image":
        "https://images.unsplash.com/photo-1564355808539-22fda35bed7e?w=400&q=80",
    "rating": 4.8,
    "reviews": 89,
    "tag": "New",
  },
  // Donuts
  {
    "name": "Chocolate Donut",
    "price": 160,
    "category": "Donuts",
    "image":
        "https://images.unsplash.com/photo-1551024709-8f23befc6f87?w=400&q=80",
    "rating": 4.4,
    "reviews": 155,
    "tag": "",
  },
  {
    "name": "Strawberry Donut",
    "price": 175,
    "category": "Donuts",
    "image":
        "https://images.unsplash.com/photo-1556913396-7a3c459ef68e?w=400&q=80",
    "rating": 4.5,
    "reviews": 119,
    "tag": "",
  },
  {
    "name": "Glazed Ring Donut",
    "price": 150,
    "category": "Donuts",
    "image":
        "https://images.unsplash.com/photo-1527515637462-cff94eecc1ac?w=400&q=80",
    "rating": 4.3,
    "reviews": 92,
    "tag": "",
  },
  {
    "name": "Sprinkle Donut",
    "price": 185,
    "category": "Donuts",
    "image":
        "https://images.unsplash.com/photo-1562777717-dc6984f65a63?w=400&q=80",
    "rating": 4.6,
    "reviews": 177,
    "tag": "New",
  },
  // Pastries
  {
    "name": "Butter Croissant",
    "price": 195,
    "category": "Pastries",
    "image":
        "https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=400&q=80",
    "rating": 4.7,
    "reviews": 176,
    "tag": "",
  },
  {
    "name": "Pain au Chocolat",
    "price": 240,
    "category": "Pastries",
    "image":
        "https://images.unsplash.com/photo-1549834125-82d3c38b6ad9?w=400&q=80",
    "rating": 4.8,
    "reviews": 143,
    "tag": "Premium",
  },
  {
    "name": "Almond Danish",
    "price": 270,
    "category": "Pastries",
    "image":
        "https://images.unsplash.com/photo-1509440159596-0249088772ff?w=400&q=80",
    "rating": 4.6,
    "reviews": 88,
    "tag": "",
  },
  // Muffins
  {
    "name": "Blueberry Muffin",
    "price": 210,
    "category": "Muffins",
    "image":
        "https://images.unsplash.com/photo-1607958996333-41aef7caefaa?w=400&q=80",
    "rating": 4.6,
    "reviews": 188,
    "tag": "New",
  },
  {
    "name": "Chocolate Chip Muffin",
    "price": 230,
    "category": "Muffins",
    "image":
        "https://images.unsplash.com/photo-1558303578-2a3c65f6e3c4?w=400&q=80",
    "rating": 4.7,
    "reviews": 144,
    "tag": "",
  },
  {
    "name": "Banana Walnut Muffin",
    "price": 220,
    "category": "Muffins",
    "image":
        "https://images.unsplash.com/photo-1612198790700-6c5c47bef18c?w=400&q=80",
    "rating": 4.5,
    "reviews": 97,
    "tag": "",
  },
  // Cupcakes
  {
    "name": "Vanilla Cupcake",
    "price": 200,
    "category": "Cupcakes",
    "image":
        "https://images.unsplash.com/photo-1576618148400-f54bed99fcfd?w=400&q=80",
    "rating": 4.5,
    "reviews": 133,
    "tag": "",
  },
  {
    "name": "Red Velvet Cupcake",
    "price": 240,
    "category": "Cupcakes",
    "image":
        "https://images.unsplash.com/photo-1614707267537-b85aaf00c4b7?w=400&q=80",
    "rating": 4.8,
    "reviews": 201,
    "tag": "Bestseller",
  },
  {
    "name": "Lemon Zest Cupcake",
    "price": 220,
    "category": "Cupcakes",
    "image":
        "https://images.unsplash.com/photo-1599785209707-a456fc1337bb?w=400&q=80",
    "rating": 4.6,
    "reviews": 115,
    "tag": "New",
  },
  // Coffee
  {
    "name": "Cappuccino",
    "price": 220,
    "category": "Coffee",
    "image":
        "https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=400&q=80",
    "rating": 4.7,
    "reviews": 289,
    "tag": "Bestseller",
  },
  {
    "name": "Caramel Latte",
    "price": 260,
    "category": "Coffee",
    "image":
        "https://images.unsplash.com/photo-1561882468-9110e03e0f78?w=400&q=80",
    "rating": 4.8,
    "reviews": 234,
    "tag": "Premium",
  },
  {
    "name": "Cold Brew",
    "price": 280,
    "category": "Coffee",
    "image":
        "https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=400&q=80",
    "rating": 4.6,
    "reviews": 178,
    "tag": "New",
  },
  {
    "name": "Espresso Shot",
    "price": 170,
    "category": "Coffee",
    "image":
        "https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?w=400&q=80",
    "rating": 4.5,
    "reviews": 143,
    "tag": "",
  },
  // Sandwiches
  {
    "name": "Club Sandwich",
    "price": 340,
    "category": "Sandwiches",
    "image":
        "https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=400&q=80",
    "rating": 4.6,
    "reviews": 167,
    "tag": "Bestseller",
  },
  {
    "name": "Grilled Veggie Panini",
    "price": 300,
    "category": "Sandwiches",
    "image":
        "https://images.unsplash.com/photo-1509722747041-616f39b57569?w=400&q=80",
    "rating": 4.5,
    "reviews": 112,
    "tag": "",
  },
  {
    "name": "Chicken Pesto Sub",
    "price": 380,
    "category": "Sandwiches",
    "image":
        "https://images.unsplash.com/photo-1553909489-cd47e0907980?w=400&q=80",
    "rating": 4.7,
    "reviews": 198,
    "tag": "New",
  },
  // Chocolates
  {
    "name": "Belgian Truffle Box",
    "price": 580,
    "category": "Chocolates",
    "image":
        "https://images.unsplash.com/photo-1549007953-2f2dc0b24019?w=400&q=80",
    "rating": 4.9,
    "reviews": 301,
    "tag": "Premium",
  },
  {
    "name": "Dark Chocolate Bar",
    "price": 320,
    "category": "Chocolates",
    "image":
        "https://images.unsplash.com/photo-1481391319762-47dff72954d9?w=400&q=80",
    "rating": 4.7,
    "reviews": 145,
    "tag": "",
  },
  {
    "name": "Hazelnut Pralines",
    "price": 480,
    "category": "Chocolates",
    "image":
        "https://images.unsplash.com/photo-1582176604856-e824b4736522?w=400&q=80",
    "rating": 4.8,
    "reviews": 212,
    "tag": "Bestseller",
  },
  // Macarons
  {
    "name": "Assorted Macarons (6)",
    "price": 440,
    "category": "Macarons",
    "image":
        "https://images.unsplash.com/photo-1558326567-98ae2405596b?w=400&q=80",
    "rating": 4.9,
    "reviews": 277,
    "tag": "Premium",
  },
  {
    "name": "Rose Macaron",
    "price": 260,
    "category": "Macarons",
    "image":
        "https://images.unsplash.com/photo-1569864358642-9d1684040f43?w=400&q=80",
    "rating": 4.8,
    "reviews": 189,
    "tag": "Bestseller",
  },
  {
    "name": "Pistachio Macaron",
    "price": 280,
    "category": "Macarons",
    "image":
        "https://images.unsplash.com/photo-1610450949065-1f2841536c88?w=400&q=80",
    "rating": 4.7,
    "reviews": 134,
    "tag": "New",
  },
  // Cheesecakes
  {
    "name": "NY Baked Cheesecake",
    "price": 1320,
    "category": "Cheesecakes",
    "image":
        "https://images.unsplash.com/photo-1567171466295-4afa63d45416?w=400&q=80",
    "rating": 4.9,
    "reviews": 244,
    "tag": "Premium",
  },
  {
    "name": "Mango Cheesecake",
    "price": 1280,
    "category": "Cheesecakes",
    "image":
        "https://images.unsplash.com/photo-1565958011703-44f9829ba187?w=400&q=80",
    "rating": 4.8,
    "reviews": 188,
    "tag": "New",
  },
  {
    "name": "Blueberry Cheesecake",
    "price": 1300,
    "category": "Cheesecakes",
    "image":
        "https://images.unsplash.com/photo-1533134242443-d4fd215305ad?w=400&q=80",
    "rating": 4.9,
    "reviews": 156,
    "tag": "Bestseller",
  },
  // Beverages
  {
    "name": "Mango Smoothie",
    "price": 230,
    "category": "Beverages",
    "image":
        "https://images.unsplash.com/photo-1546173159-315724a31696?w=400&q=80",
    "rating": 4.6,
    "reviews": 143,
    "tag": "New",
  },
  {
    "name": "Iced Matcha Latte",
    "price": 270,
    "category": "Beverages",
    "image":
        "https://images.unsplash.com/photo-1536256263959-770b48d82b0a?w=400&q=80",
    "rating": 4.7,
    "reviews": 198,
    "tag": "Bestseller",
  },
  {
    "name": "Hot Chocolate",
    "price": 250,
    "category": "Beverages",
    "image":
        "https://images.unsplash.com/photo-1542990253-0d0f5be5f0ed?w=400&q=80",
    "rating": 4.8,
    "reviews": 222,
    "tag": "Premium",
  },
  // Breads
  {
    "name": "Sourdough Loaf",
    "price": 420,
    "category": "Breads",
    "image":
        "https://images.unsplash.com/photo-1585478259715-876acc5be8eb?w=400&q=80",
    "rating": 4.7,
    "reviews": 134,
    "tag": "",
  },
  {
    "name": "Multigrain Bread",
    "price": 360,
    "category": "Breads",
    "image":
        "https://images.unsplash.com/photo-1509440159596-0249088772ff?w=400&q=80",
    "rating": 4.5,
    "reviews": 98,
    "tag": "",
  },
  {
    "name": "Garlic Herb Focaccia",
    "price": 390,
    "category": "Breads",
    "image":
        "https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=400&q=80",
    "rating": 4.8,
    "reviews": 167,
    "tag": "New",
  },
];

final List<Map<String, dynamic>> customerReviews = [
  {
    "name": "Aanya Sharma",
    "avatar": "A",
    "avatarColor": Color(0xFFC8938A),
    "rating": 5,
    "comment":
        "The cookies are absolutely divine! Crispy outside and gooey inside. Will order again!",
    "date": "2 days ago",
    "item": "Classic Chocolate Chip",
  },
  {
    "name": "Rohan Mehta",
    "avatar": "R",
    "avatarColor": Color(0xFF9E8080),
    "rating": 5,
    "comment":
        "The cake looked beautiful and tasted even better. Perfect for our anniversary!",
    "date": "4 days ago",
    "item": "Vanilla Dream Cake",
  },
  {
    "name": "Priya Nair",
    "avatar": "P",
    "avatarColor": Color(0xFF6B5050),
    "rating": 4,
    "comment":
        "Loved the packaging and the freshness. The brownies were fudgy perfection.",
    "date": "1 week ago",
    "item": "Chocolate Brownie",
  },
  {
    "name": "Kabir Singh",
    "avatar": "K",
    "avatarColor": Color(0xFF8B6060),
    "rating": 5,
    "comment":
        "Best cappuccino I've had outside a café! Rich, creamy and perfectly balanced.",
    "date": "3 days ago",
    "item": "Cappuccino",
  },
  {
    "name": "Meera Iyer",
    "avatar": "M",
    "avatarColor": Color(0xFFBFA8A8),
    "rating": 5,
    "comment":
        "The macarons are straight out of Paris! Delicate shells and perfect filling.",
    "date": "5 days ago",
    "item": "Assorted Macarons (6)",
  },
  {
    "name": "Arjun Kapoor",
    "avatar": "A",
    "avatarColor": Color(0xFFD4A96A),
    "rating": 4,
    "comment":
        "Club sandwich was filling and fresh. Great for a quick lunch. Loved it!",
    "date": "1 week ago",
    "item": "Club Sandwich",
  },
  {
    "name": "Sneha Patel",
    "avatar": "S",
    "avatarColor": Color(0xFF9E8080),
    "rating": 5,
    "comment":
        "Red Velvet Cupcake was heavenly! Moist and the frosting was absolutely dreamy.",
    "date": "2 weeks ago",
    "item": "Red Velvet Cupcake",
  },
  {
    "name": "Dev Malhotra",
    "avatar": "D",
    "avatarColor": Color(0xFF6B5050),
    "rating": 5,
    "comment":
        "Belgian Truffles melted in my mouth. Perfect gift for my wife's birthday!",
    "date": "2 weeks ago",
    "item": "Belgian Truffle Box",
  },
  {
    "name": "Riya Joshi",
    "avatar": "R",
    "avatarColor": Color(0xFFC8938A),
    "rating": 4,
    "comment":
        "The sourdough bread is incredibly fresh. Crispy crust and chewy inside!",
    "date": "3 weeks ago",
    "item": "Sourdough Loaf",
  },
  {
    "name": "Vikram Nanda",
    "avatar": "V",
    "avatarColor": Color(0xFF8B6060),
    "rating": 5,
    "comment":
        "NY Cheesecake rivals the best I've tasted abroad. Perfectly creamy and dense!",
    "date": "3 weeks ago",
    "item": "NY Baked Cheesecake",
  },
];

final List<Map<String, dynamic>> categories = [
  {"name": "All", "emoji": "✨"},
  {"name": "Cookies", "emoji": "🍪"},
  {"name": "Cakes", "emoji": "🎂"},
  {"name": "Brownies", "emoji": "🍫"},
  {"name": "Donuts", "emoji": "🍩"},
  {"name": "Pastries", "emoji": "🥐"},
  {"name": "Muffins", "emoji": "🧁"},
  {"name": "Cupcakes", "emoji": "🍰"},
  {"name": "Coffee", "emoji": "☕"},
  {"name": "Sandwiches", "emoji": "🥪"},
  {"name": "Chocolates", "emoji": "🍫"},
  {"name": "Macarons", "emoji": "🫶"},
  {"name": "Cheesecakes", "emoji": "🍮"},
  {"name": "Beverages", "emoji": "🥤"},
  {"name": "Breads", "emoji": "🍞"},
];

// ─── State ────────────────────────────────────────────────────────────────────

final ValueNotifier<List<Map<String, dynamic>>> cartNotifier = ValueNotifier(
  [],
);
final ValueNotifier<List<Map<String, dynamic>>> orderHistoryNotifier =
    ValueNotifier([]);
final ValueNotifier<Set<String>> wishlistNotifier = ValueNotifier({});
final ValueNotifier<List<Map<String, dynamic>>> recentlyViewedNotifier =
    ValueNotifier([]);
final ValueNotifier<String> locationNotifier = ValueNotifier(
  "Connaught Place, New Delhi",
);

// ─── Theme ────────────────────────────────────────────────────────────────────

const Color kRoseDark = Color(0xFF8B6060);
const Color kRoseMid = Color(0xFFC8938A);
const Color kRoseLight = Color(0xFFDDB8B0);
const Color kIvory = Color(0xFFF2EEE9);
const Color kChampagne = Color(0xFFE8D5C0);
const Color kTaupe = Color(0xFF9E8080);
const Color kTaupeDark = Color(0xFF6B5050);
const Color kTaupeLight = Color(0xFFBFA8A8);
const Color kGold = Color(0xFFD4A96A);
const Color kGoldLight = Color(0xFFF5E8D8);
const Color kSuccess = Color(0xFF5A8A6A);
const Color kSurface = Color(0xFFFFFFFF);

// ─── App ──────────────────────────────────────────────────────────────────────

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Cookie Cloud",
      theme: ThemeData(
        scaffoldBackgroundColor: kIvory,
        textTheme: GoogleFonts.dmSansTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: kRoseMid),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

// ─── Login ────────────────────────────────────────────────────────────────────

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;
  bool _loading = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _login() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    Navigator.pushReplacement(context, _fadeRoute(const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF6B4545),
                  Color(0xFF8B6060),
                  Color(0xFFC8938A),
                  Color(0xFFDDB8B0),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned(
            top: -80,
            right: -80,
            child: _decorCircle(260, Colors.white.withOpacity(0.06)),
          ),
          Positioned(
            bottom: 60,
            left: -100,
            child: _decorCircle(320, Colors.white.withOpacity(0.04)),
          ),
          Positioned(
            top: 160,
            left: -50,
            child: _decorCircle(140, kGold.withOpacity(0.12)),
          ),
          Positioned(
            bottom: 200,
            right: -40,
            child: _decorCircle(180, kGold.withOpacity(0.08)),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 220,
            child: Stack(
              children: [
                ClipRect(
                  child: Image.network(
                    "https://images.unsplash.com/photo-1558961363-fa8fdf82db35?w=800&q=80",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 220,
                    errorBuilder: (_, __, ___) => const SizedBox(),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF6B4545).withOpacity(0.75),
                        const Color(0xFF8B6060).withOpacity(0.85),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: FadeTransition(
                  opacity: _fadeAnim,
                  child: SlideTransition(
                    position: _slideAnim,
                    child: Column(
                      children: [
                        const SizedBox(height: 32),
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: kGold.withOpacity(0.6),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: kGold.withOpacity(0.2),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text("🍪", style: TextStyle(fontSize: 46)),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          "Cookie Cloud",
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: kGold.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: kGold.withOpacity(0.35)),
                          ),
                          child: Text(
                            "✦  Baked with love, delivered with care  ✦",
                            style: GoogleFonts.dmSans(
                              color: kGoldLight,
                              fontSize: 12,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 36),
                        Container(
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            color: kSurface,
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.18),
                                blurRadius: 48,
                                offset: const Offset(0, 20),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 4,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: kRoseDark,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Welcome back 👋",
                                        style: GoogleFonts.cormorantGaramond(
                                          fontSize: 26,
                                          fontWeight: FontWeight.w700,
                                          color: kTaupeDark,
                                        ),
                                      ),
                                      Text(
                                        "Sign in to continue",
                                        style: GoogleFonts.dmSans(
                                          color: kTaupeLight,
                                          fontSize: 13.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 26),
                              _inputField(
                                Icons.email_outlined,
                                "Email address",
                              ),
                              const SizedBox(height: 14),
                              _passwordField(),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Forgot password?",
                                  style: GoogleFonts.dmSans(
                                    color: kRoseMid,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                height: 54,
                                child: ElevatedButton(
                                  onPressed: _loading ? null : _login,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: kRoseDark,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: _loading
                                      ? const SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2.5,
                                          ),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Sign In",
                                              style: GoogleFonts.dmSans(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            const Icon(
                                              Icons.arrow_forward_rounded,
                                              size: 18,
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: kTaupeLight.withOpacity(0.4),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: Text(
                                      "or",
                                      style: GoogleFonts.dmSans(
                                        color: kTaupeLight,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: kTaupeLight.withOpacity(0.4),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account? ",
                                    style: GoogleFonts.dmSans(
                                      color: kTaupeLight,
                                      fontSize: 14,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      _fadeRoute(const SignUpPage()),
                                    ),
                                    child: Text(
                                      "Sign up",
                                      style: GoogleFonts.dmSans(
                                        color: kRoseDark,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        decoration: TextDecoration.underline,
                                        decorationColor: kRoseDark,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputField(IconData icon, String hint, {bool obscure = false}) {
    return TextField(
      obscureText: obscure,
      style: GoogleFonts.dmSans(color: kTaupeDark),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.dmSans(
          color: kTaupeLight.withOpacity(0.7),
          fontSize: 14,
        ),
        prefixIcon: Icon(icon, color: kRoseLight, size: 20),
        filled: true,
        fillColor: kIvory,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: kRoseMid, width: 1.5),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return TextField(
      obscureText: _obscurePassword,
      style: GoogleFonts.dmSans(color: kTaupeDark),
      decoration: InputDecoration(
        hintText: "Password",
        hintStyle: GoogleFonts.dmSans(
          color: kTaupeLight.withOpacity(0.7),
          fontSize: 14,
        ),
        prefixIcon: const Icon(
          Icons.lock_outline_rounded,
          color: kRoseLight,
          size: 20,
        ),
        suffixIcon: GestureDetector(
          onTap: () => setState(() => _obscurePassword = !_obscurePassword),
          child: Icon(
            _obscurePassword
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: kTaupeLight,
            size: 20,
          ),
        ),
        filled: true,
        fillColor: kIvory,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: kRoseMid, width: 1.5),
        ),
      ),
    );
  }

  Widget _decorCircle(double size, Color color) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
  );
}

// ─── Sign Up Page ─────────────────────────────────────────────────────────────

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  bool _loading = false;
  bool _obscurePwd = true;
  bool _obscureConfirm = true;

  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _pwdCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  String? _error;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _pwdCtrl.dispose();
    _confirmCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _signUp() async {
    setState(() => _error = null);
    final name = _nameCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final pwd = _pwdCtrl.text.trim();
    final confirm = _confirmCtrl.text.trim();
    final phone = _phoneCtrl.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        pwd.isEmpty ||
        confirm.isEmpty ||
        phone.isEmpty) {
      setState(() => _error = "Please fill in all fields.");
      return;
    }
    if (!email.contains('@') || !email.contains('.')) {
      setState(() => _error = "Please enter a valid email address.");
      return;
    }
    if (pwd.length < 6) {
      setState(() => _error = "Password must be at least 6 characters.");
      return;
    }
    if (pwd != confirm) {
      setState(() => _error = "Passwords do not match.");
      return;
    }
    if (phone.length < 10) {
      setState(() => _error = "Please enter a valid phone number.");
      return;
    }
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      _fadeRoute(const HomeScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF6B4545),
                  Color(0xFF8B6060),
                  Color(0xFFC8938A),
                  Color(0xFFDDB8B0),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.18),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Text("🍪", style: TextStyle(fontSize: 28)),
                      const SizedBox(width: 8),
                      Text(
                        "Cookie Cloud",
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(width: 40),
                    ],
                  ),
                ),
                Expanded(
                  child: FadeTransition(
                    opacity: _fade,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(28),
                            decoration: BoxDecoration(
                              color: kSurface,
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.18),
                                  blurRadius: 48,
                                  offset: const Offset(0, 20),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 4,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: kRoseDark,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Create Account 🎉",
                                          style: GoogleFonts.cormorantGaramond(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700,
                                            color: kTaupeDark,
                                          ),
                                        ),
                                        Text(
                                          "Join Cookie Cloud today",
                                          style: GoogleFonts.dmSans(
                                            color: kTaupeLight,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                if (_error != null) ...[
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.08),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.red.withOpacity(0.25),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.error_outline_rounded,
                                          color: Colors.red,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            _error!,
                                            style: GoogleFonts.dmSans(
                                              color: Colors.red,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                                _signUpField(
                                  Icons.person_outline_rounded,
                                  "Full Name",
                                  _nameCtrl,
                                ),
                                const SizedBox(height: 14),
                                _signUpField(
                                  Icons.email_outlined,
                                  "Email Address",
                                  _emailCtrl,
                                  type: TextInputType.emailAddress,
                                ),
                                const SizedBox(height: 14),
                                _signUpField(
                                  Icons.phone_outlined,
                                  "Phone Number",
                                  _phoneCtrl,
                                  type: TextInputType.phone,
                                ),
                                const SizedBox(height: 14),
                                _signUpPwdField(
                                  "Password",
                                  _pwdCtrl,
                                  _obscurePwd,
                                  () {
                                    setState(() => _obscurePwd = !_obscurePwd);
                                  },
                                ),
                                const SizedBox(height: 14),
                                _signUpPwdField(
                                  "Confirm Password",
                                  _confirmCtrl,
                                  _obscureConfirm,
                                  () {
                                    setState(
                                      () => _obscureConfirm = !_obscureConfirm,
                                    );
                                  },
                                ),
                                const SizedBox(height: 26),
                                SizedBox(
                                  width: double.infinity,
                                  height: 54,
                                  child: ElevatedButton(
                                    onPressed: _loading ? null : _signUp,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: kRoseDark,
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: _loading
                                        ? const SizedBox(
                                            width: 22,
                                            height: 22,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2.5,
                                            ),
                                          )
                                        : Text(
                                            "Create Account",
                                            style: GoogleFonts.dmSans(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already have an account? ",
                                      style: GoogleFonts.dmSans(
                                        color: kTaupeLight,
                                        fontSize: 13.5,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => Navigator.pop(context),
                                      child: Text(
                                        "Sign in",
                                        style: GoogleFonts.dmSans(
                                          color: kRoseDark,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13.5,
                                          decoration: TextDecoration.underline,
                                          decorationColor: kRoseDark,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _signUpField(
    IconData icon,
    String hint,
    TextEditingController ctrl, {
    TextInputType type = TextInputType.text,
  }) {
    return TextField(
      controller: ctrl,
      keyboardType: type,
      style: GoogleFonts.dmSans(color: kTaupeDark),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.dmSans(
          color: kTaupeLight.withOpacity(0.7),
          fontSize: 14,
        ),
        prefixIcon: Icon(icon, color: kRoseLight, size: 20),
        filled: true,
        fillColor: kIvory,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: kRoseMid, width: 1.5),
        ),
      ),
    );
  }

  Widget _signUpPwdField(
    String hint,
    TextEditingController ctrl,
    bool obscure,
    VoidCallback toggle,
  ) {
    return TextField(
      controller: ctrl,
      obscureText: obscure,
      style: GoogleFonts.dmSans(color: kTaupeDark),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.dmSans(
          color: kTaupeLight.withOpacity(0.7),
          fontSize: 14,
        ),
        prefixIcon: const Icon(
          Icons.lock_outline_rounded,
          color: kRoseLight,
          size: 20,
        ),
        suffixIcon: GestureDetector(
          onTap: toggle,
          child: Icon(
            obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: kTaupeLight,
            size: 20,
          ),
        ),
        filled: true,
        fillColor: kIvory,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: kRoseMid, width: 1.5),
        ),
      ),
    );
  }
}

// ─── Home Shell ───────────────────────────────────────────────────────────────

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<_NavItem> _navItems = const [
    _NavItem(Icons.home_rounded, Icons.home_outlined, "Home"),
    _NavItem(Icons.explore_rounded, Icons.explore_outlined, "Explore"),
    _NavItem(Icons.shopping_bag_rounded, Icons.shopping_bag_outlined, "Cart"),
    _NavItem(Icons.receipt_long_rounded, Icons.receipt_long_outlined, "Orders"),
    _NavItem(Icons.person_rounded, Icons.person_outline_rounded, "Profile"),
  ];

  void _onNavTap(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kIvory,
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: [
              HomeContent(onNavigate: _onNavTap),
              const ExploreScreen(),
              CartScreen(onNavigate: _onNavTap),
              const OrderHistoryScreen(),
              ProfileScreen(onNavigate: _onNavTap),
            ],
          ),
          const Positioned(right: 22, bottom: 95, child: PixiChatbot()),
        ],
      ),
      bottomNavigationBar: _FloatingNavBar(
        items: _navItems,
        selectedIndex: _selectedIndex,
        onTap: _onNavTap,
      ),
    );
  }
}

class _NavItem {
  final IconData activeIcon;
  final IconData icon;
  final String label;
  const _NavItem(this.activeIcon, this.icon, this.label);
}

// ─── Floating Nav Bar ─────────────────────────────────────────────────────────

class _FloatingNavBar extends StatelessWidget {
  final List<_NavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _FloatingNavBar({
    required this.items,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      height: 68,
      decoration: BoxDecoration(
        color: kRoseDark,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: kRoseDark.withOpacity(0.4),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (i) {
          final isSelected = i == selectedIndex;
          final isCart = i == 2;
          return GestureDetector(
            onTap: () => onTap(i),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.18)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: isCart
                  ? ValueListenableBuilder<List<Map<String, dynamic>>>(
                      valueListenable: cartNotifier,
                      builder: (_, cart, __) => Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(
                            isSelected ? items[i].activeIcon : items[i].icon,
                            color: isSelected
                                ? Colors.white
                                : Colors.white.withOpacity(0.45),
                            size: 26,
                          ),
                          if (cart.isNotEmpty)
                            Positioned(
                              right: -4,
                              top: -4,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: const BoxDecoration(
                                  color: kGold,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    "${cart.length}",
                                    style: const TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      color: kTaupeDark,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isSelected ? items[i].activeIcon : items[i].icon,
                          color: isSelected
                              ? Colors.white
                              : Colors.white.withOpacity(0.45),
                          size: 24,
                        ),
                        if (isSelected) ...[
                          const SizedBox(height: 3),
                          Container(
                            width: 4,
                            height: 4,
                            decoration: const BoxDecoration(
                              color: kGold,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ],
                    ),
            ),
          );
        }),
      ),
    );
  }
}

// ─── Pixi Chatbot ─────────────────────────────────────────────────────────────

class PixiMessage {
  final String text;
  final bool isPixi;
  const PixiMessage({required this.text, required this.isPixi});
}

class PixiChatbot extends StatefulWidget {
  const PixiChatbot({super.key});
  @override
  State<PixiChatbot> createState() => _PixiChatbotState();
}

class _PixiChatbotState extends State<PixiChatbot>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  final TextEditingController _inputCtrl = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();
  final FocusNode _focusNode = FocusNode();
  late AnimationController _animCtrl;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  final List<PixiMessage> _messages = [
    const PixiMessage(
      text:
          "Hi! I'm Pixi 🍪 Your Cookie Cloud assistant. Ask me about our menu, offers, or anything sweet!",
      isPixi: true,
    ),
  ];

  String _getPixiReply(String input) {
    final q = input.toLowerCase().trim();
    if (q.contains('hello') || q.contains('hi') || q.contains('hey')) {
      return "Hey there! 🍪 I'm Pixi! How can I sweeten your day?";
    } else if (q.contains('offer') ||
        q.contains('discount') ||
        q.contains('deal')) {
      return "🎉 Today's special: Vanilla Dream Cake at ₹1232 (was ₹1450) — 15% off! Check the Home screen for more deals.";
    } else if (q.contains('bestseller') ||
        q.contains('popular') ||
        q.contains('best')) {
      return "Our bestsellers: Classic Chocolate Chip (₹220), Red Velvet Cupcake (₹240), Cappuccino (₹220), and Belgian Truffles (₹580)! 🌟";
    } else if (q.contains('coffee')) {
      return "We have Cappuccino (₹220), Caramel Latte (₹260), Cold Brew (₹280), and Espresso (₹170)! ☕ All made fresh!";
    } else if (q.contains('cake')) {
      return "We have Vanilla Dream Cake (₹1450), Cheesecake (₹1180), Strawberry Shortcake (₹1250), and Dark Chocolate Cake (₹1380)! 🎂";
    } else if (q.contains('cookie')) {
      return "Cookies are our specialty! Classic Chocolate Chip (₹220), Red Velvet (₹260), Double Choco (₹240)! All rated 4.8+⭐";
    } else if (q.contains('delivery') || q.contains('deliver')) {
      return "We offer FREE delivery on all orders above ₹500! 🚀 Your treats are baked fresh and delivered with love.";
    } else if (q.contains('order') || q.contains('track')) {
      return "You can track your orders in the Orders tab! 📦 Tap the receipt icon in the bottom bar.";
    } else if (q.contains('cart')) {
      return "Tap the bag icon in the bottom bar to view your cart. Happy shopping! 🛒";
    } else if (q.contains('thank')) {
      return "You're welcome! 🍪 Enjoy your treats and have a sweet day!";
    } else {
      return "I can help with cookies, cakes, coffee, sandwiches, chocolates, macarons, orders, delivery & more! What would you like? 😊";
    }
  }

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _scaleAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutBack);
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _inputCtrl.dispose();
    _scrollCtrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleChat() {
    setState(() => _isOpen = !_isOpen);
    if (_isOpen) {
      _animCtrl.forward();
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted && _isOpen) _focusNode.requestFocus();
      });
    } else {
      _animCtrl.reverse();
      _focusNode.unfocus();
    }
  }

  void _sendMessage() {
    final text = _inputCtrl.text.trim();
    if (text.isEmpty) return;
    setState(() => _messages.add(PixiMessage(text: text, isPixi: false)));
    _inputCtrl.clear();
    _scrollToBottom();
    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      setState(
        () =>
            _messages.add(PixiMessage(text: _getPixiReply(text), isPixi: true)),
      );
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 120), () {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (_isOpen)
          FadeTransition(
            opacity: _fadeAnim,
            child: ScaleTransition(
              scale: _scaleAnim,
              alignment: Alignment.bottomRight,
              child: Container(
                width: 300,
                height: 420,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: kSurface,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: kRoseDark.withOpacity(0.22),
                      blurRadius: 28,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
                      decoration: const BoxDecoration(
                        color: kRoseDark,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: kGold.withOpacity(0.25),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: kGold.withOpacity(0.5),
                                width: 1.5,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.support_agent_rounded,
                                color: kGold,
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pixi",
                                  style: GoogleFonts.cormorantGaramond(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Cookie Cloud Assistant",
                                  style: GoogleFonts.dmSans(
                                    fontSize: 11,
                                    color: Colors.white60,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFF7EC97E),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: _toggleChat,
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollCtrl,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        itemCount: _messages.length,
                        itemBuilder: (_, i) =>
                            _PixiMessageBubble(message: _messages[i]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 14),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _inputCtrl,
                              focusNode: _focusNode,
                              textInputAction: TextInputAction.send,
                              onSubmitted: (_) => _sendMessage(),
                              style: GoogleFonts.dmSans(
                                fontSize: 13,
                                color: kTaupeDark,
                              ),
                              decoration: InputDecoration(
                                hintText: "Ask Pixi anything...",
                                hintStyle: GoogleFonts.dmSans(
                                  fontSize: 13,
                                  color: kTaupeLight.withOpacity(0.7),
                                ),
                                filled: true,
                                fillColor: kIvory,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 10,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                    color: kRoseMid,
                                    width: 1.5,
                                  ),
                                ),
                                isDense: true,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: _sendMessage,
                            child: Container(
                              width: 38,
                              height: 38,
                              decoration: const BoxDecoration(
                                color: kRoseDark,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                                size: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        GestureDetector(
          onTap: _toggleChat,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: _isOpen ? kTaupeDark : kRoseDark,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: kRoseDark.withOpacity(0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: _isOpen
                    ? const Icon(
                        Icons.close_rounded,
                        key: ValueKey('close'),
                        color: Colors.white,
                        size: 24,
                      )
                    : const Icon(
                        Icons.support_agent_rounded,
                        key: ValueKey('agent'),
                        color: Colors.white,
                        size: 26,
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PixiMessageBubble extends StatelessWidget {
  final PixiMessage message;
  const _PixiMessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isPixi = message.isPixi;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: isPixi
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isPixi) ...[
            Container(
              width: 26,
              height: 26,
              decoration: const BoxDecoration(
                color: kChampagne,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.support_agent_rounded,
                  color: kRoseDark,
                  size: 15,
                ),
              ),
            ),
            const SizedBox(width: 6),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
              decoration: BoxDecoration(
                color: isPixi ? kChampagne.withOpacity(0.55) : kRoseDark,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isPixi ? 4 : 16),
                  bottomRight: Radius.circular(isPixi ? 16 : 4),
                ),
              ),
              child: Text(
                message.text,
                style: GoogleFonts.dmSans(
                  fontSize: 12.5,
                  height: 1.45,
                  color: isPixi ? kTaupeDark : Colors.white,
                ),
              ),
            ),
          ),
          if (!isPixi) ...[
            const SizedBox(width: 6),
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: kGold.withOpacity(0.25),
                shape: BoxShape.circle,
                border: Border.all(color: kGold.withOpacity(0.5)),
              ),
              child: const Center(
                child: Text(
                  "A",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: kGold,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─── Home Content ─────────────────────────────────────────────────────────────

class HomeContent extends StatefulWidget {
  final void Function(int) onNavigate;
  const HomeContent({super.key, required this.onNavigate});
  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String _searchQuery = "";
  String _selectedCategory = "All";
  final ScrollController _scrollController = ScrollController();
  bool _stickySearch = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final sticky = _scrollController.offset > 280;
      if (sticky != _stickySearch) setState(() => _stickySearch = sticky);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filtered {
    return products.where((p) {
      final matchCat =
          _selectedCategory == "All" || p["category"] == _selectedCategory;
      final matchSearch = p["name"].toString().toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      return matchCat && matchSearch;
    }).toList();
  }

  void _handleSearch(String q) => setState(() => _searchQuery = q);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kIvory,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: _HeroHeader(
                  onSearch: _handleSearch,
                  controller: _searchController,
                  onCartTap: () => widget.onNavigate(2),
                  onProfileTap: () => widget.onNavigate(4),
                ),
              ),
              SliverToBoxAdapter(
                child: _TodaySpecialBanner(
                  onAddToCart: () {
                    final special = products.firstWhere(
                      (p) => p["name"] == "Vanilla Dream Cake",
                    );
                    cartNotifier.value = [
                      ...cartNotifier.value,
                      Map<String, dynamic>.from(special),
                    ];
                    ScaffoldMessenger.of(context).showSnackBar(
                      _cartSnackBar("Vanilla Dream Cake", context),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: _CategoriesRow(
                  selected: _selectedCategory,
                  onSelect: (c) => setState(() => _selectedCategory = c),
                ),
              ),
              SliverToBoxAdapter(
                child: _SectionHeader(
                  title: "Bestsellers ✨",
                  onSeeAll: () => widget.onNavigate(1),
                ),
              ),
              SliverToBoxAdapter(
                child: _BestsellersCarousel(
                  products: products
                      .where((p) => p["tag"] == "Bestseller")
                      .toList(),
                ),
              ),
              SliverToBoxAdapter(
                child: _SectionHeader(
                  title: "Recommended for You 🌹",
                  onSeeAll: () => widget.onNavigate(1),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _ProductCard(product: filtered[index]),
                    childCount: filtered.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.72,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                ),
              ),
              SliverToBoxAdapter(child: _RecentlyViewedSection()),
              SliverToBoxAdapter(child: const _ReviewsSnippet()),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            top: _stickySearch ? 0 : -80,
            left: 0,
            right: 0,
            child: _StickySearchBar(
              controller: _searchController,
              onSearch: _handleSearch,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Shared Snackbar ──────────────────────────────────────────────────────────

SnackBar _cartSnackBar(String name, BuildContext context) {
  return SnackBar(
    content: Row(
      children: [
        const Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            "$name added to cart!",
            style: GoogleFonts.dmSans(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
    backgroundColor: kRoseDark,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    margin: const EdgeInsets.fromLTRB(16, 0, 16, 90),
    duration: const Duration(seconds: 2),
    action: SnackBarAction(
      label: "View Cart",
      textColor: kGold,
      onPressed: () {},
    ),
  );
}

// ─── Skeleton Image ───────────────────────────────────────────────────────────

class _SkeletonImage extends StatefulWidget {
  final String url;
  final double width;
  final double height;
  final BorderRadius? borderRadius;
  final BoxFit fit;
  const _SkeletonImage({
    required this.url,
    required this.width,
    required this.height,
    this.borderRadius,
    this.fit = BoxFit.cover,
  });
  @override
  State<_SkeletonImage> createState() => _SkeletonImageState();
}

class _SkeletonImageState extends State<_SkeletonImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmer;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _shimmer = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _anim = Tween<double>(
      begin: 0.4,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _shimmer, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _shimmer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.zero,
      child: Image.network(
        widget.url,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return AnimatedBuilder(
            animation: _anim,
            builder: (_, __) => Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    kChampagne.withOpacity(_anim.value),
                    kChampagne.withOpacity(_anim.value * 0.5),
                    kChampagne.withOpacity(_anim.value),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.bakery_dining_rounded,
                  color: kTaupeLight.withOpacity(0.4),
                  size: 32,
                ),
              ),
            ),
          );
        },
        errorBuilder: (_, __, ___) => Container(
          width: widget.width,
          height: widget.height,
          color: kChampagne,
          child: Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              color: kTaupeLight.withOpacity(0.5),
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Hero Header ──────────────────────────────────────────────────────────────

class _HeroHeader extends StatelessWidget {
  final ValueChanged<String> onSearch;
  final TextEditingController controller;
  final VoidCallback onCartTap;
  final VoidCallback onProfileTap;
  const _HeroHeader({
    required this.onSearch,
    required this.controller,
    required this.onCartTap,
    required this.onProfileTap,
  });

  void _showLocationSheet(BuildContext context) {
    final locations = [
      "Connaught Place, New Delhi",
      "Hauz Khas, New Delhi",
      "Cyber City, Gurugram",
      "Indiranagar, Bengaluru",
      "Bandra West, Mumbai",
    ];
    showModalBottomSheet(
      context: context,
      backgroundColor: kSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: kTaupeLight,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Choose Location",
              style: GoogleFonts.cormorantGaramond(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: kTaupeDark,
              ),
            ),
            const SizedBox(height: 12),
            ...locations.map(
              (loc) => ListTile(
                leading: const Icon(
                  Icons.location_on_rounded,
                  color: kRoseMid,
                  size: 20,
                ),
                title: Text(
                  loc,
                  style: GoogleFonts.dmSans(fontSize: 14, color: kTaupeDark),
                ),
                onTap: () {
                  locationNotifier.value = loc;
                  Navigator.pop(context);
                },
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            ),
            child: _SkeletonImage(
              url:
                  "https://images.unsplash.com/photo-1499636136210-6f4ee915583e?w=900&q=85",
              width: double.infinity,
              height: 310,
              fit: BoxFit.cover,
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            ),
            child: Container(
              height: 310,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF4A2C2C).withOpacity(0.88),
                    const Color(0xFF7B4F4F).withOpacity(0.78),
                    const Color(0xFFC8938A).withOpacity(0.50),
                    Colors.transparent,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0.0, 0.35, 0.70, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            top: -30,
            right: -30,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kGold.withOpacity(0.12),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => _showLocationSheet(context),
                        child: ValueListenableBuilder<String>(
                          valueListenable: locationNotifier,
                          builder: (_, loc, __) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.18),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.25),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.location_on_rounded,
                                  color: kGold,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 160,
                                  ),
                                  child: Text(
                                    loc,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.dmSans(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 3),
                                const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.white60,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: onCartTap,
                        child:
                            ValueListenableBuilder<List<Map<String, dynamic>>>(
                              valueListenable: cartNotifier,
                              builder: (_, cart, __) => Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  _iconBtn(Icons.shopping_bag_outlined),
                                  if (cart.isNotEmpty)
                                    Positioned(
                                      right: -2,
                                      top: -2,
                                      child: Container(
                                        width: 18,
                                        height: 18,
                                        decoration: const BoxDecoration(
                                          color: kGold,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "${cart.length}",
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: kTaupeDark,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                      ),
                      const SizedBox(width: 8),
                      _iconBtn(Icons.notifications_none_rounded),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: onProfileTap,
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kGold.withOpacity(0.25),
                            border: Border.all(
                              color: kGold.withOpacity(0.6),
                              width: 1.5,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "A",
                              style: TextStyle(
                                color: kGold,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      const Text("🍪", style: TextStyle(fontSize: 32)),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Cookie Cloud",
                            style: GoogleFonts.cormorantGaramond(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            "Baked with love, every cloud",
                            style: GoogleFonts.dmSans(
                              color: kGold,
                              fontSize: 12,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: TextField(
                      controller: controller,
                      onChanged: onSearch,
                      style: GoogleFonts.dmSans(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText: "Search cookies, cakes, coffee & more...",
                        hintStyle: GoogleFonts.dmSans(
                          color: Colors.white60,
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: Colors.white60,
                          size: 22,
                        ),
                        suffixIcon: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: kGold.withOpacity(0.35),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.tune_rounded,
                            color: kGold,
                            size: 18,
                          ),
                        ),
                        filled: false,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconBtn(IconData icon) => Container(
    width: 38,
    height: 38,
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.18),
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white.withOpacity(0.22)),
    ),
    child: Icon(icon, color: Colors.white, size: 20),
  );
}

// ─── Sticky Search Bar ────────────────────────────────────────────────────────

class _StickySearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSearch;
  const _StickySearchBar({required this.controller, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        MediaQuery.of(context).padding.top + 8,
        16,
        10,
      ),
      decoration: BoxDecoration(
        color: kRoseDark.withOpacity(0.97),
        boxShadow: [
          BoxShadow(color: kRoseDark.withOpacity(0.3), blurRadius: 12),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onSearch,
        style: GoogleFonts.dmSans(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          hintText: "Search cookies, cakes, coffee & more...",
          hintStyle: GoogleFonts.dmSans(color: Colors.white54, fontSize: 14),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Colors.white54,
            size: 20,
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          isDense: true,
        ),
      ),
    );
  }
}

// ─── Today's Special Banner ───────────────────────────────────────────────────

class _TodaySpecialBanner extends StatelessWidget {
  final VoidCallback onAddToCart;
  const _TodaySpecialBanner({required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF5E8D8), Color(0xFFEDD8C0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: kGold.withOpacity(0.30), width: 1),
        boxShadow: [
          BoxShadow(
            color: kGold.withOpacity(0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 8, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: kGold.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "TODAY'S SPECIAL",
                        style: GoogleFonts.dmSans(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: kTaupeDark,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Vanilla Dream Cake",
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: kTaupeDark,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          "₹1232",
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: kRoseDark,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "₹1450",
                          style: GoogleFonts.dmSans(
                            fontSize: 11,
                            color: kTaupeLight,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: kSuccess.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            "15% off",
                            style: GoogleFonts.dmSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: kSuccess,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: onAddToCart,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: kRoseDark,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Add to Cart",
                          style: GoogleFonts.dmSans(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(22),
                bottomRight: Radius.circular(22),
              ),
              child: _SkeletonImage(
                url:
                    "https://images.unsplash.com/photo-1464349095431-e9a21285b5f3?w=300&q=80",
                width: 120,
                height: 145,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Categories Row ───────────────────────────────────────────────────────────

class _CategoriesRow extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelect;
  const _CategoriesRow({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 22, 16, 12),
          child: Text(
            "Categories",
            style: GoogleFonts.cormorantGaramond(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: kTaupeDark,
            ),
          ),
        ),
        SizedBox(
          height: 88,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categories.length,
            itemBuilder: (_, i) {
              final cat = categories[i];
              final isActive = selected == cat["name"];
              return GestureDetector(
                onTap: () => onSelect(cat["name"]!),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(right: 12),
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: isActive ? kRoseDark : kSurface,
                          shape: BoxShape.circle,
                          boxShadow: isActive
                              ? [
                                  BoxShadow(
                                    color: kRoseDark.withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.06),
                                    blurRadius: 8,
                                  ),
                                ],
                        ),
                        child: Center(
                          child: Text(
                            cat["emoji"]!,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        cat["name"]!,
                        style: GoogleFonts.dmSans(
                          fontSize: 11.5,
                          fontWeight: isActive
                              ? FontWeight.w700
                              : FontWeight.w400,
                          color: isActive ? kRoseDark : kTaupeLight,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ─── Section Header ───────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;
  const _SectionHeader({required this.title, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: kTaupeDark,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onSeeAll,
            child: Text(
              "See all",
              style: GoogleFonts.dmSans(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: kRoseMid,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Bestsellers Carousel ─────────────────────────────────────────────────────

class _BestsellersCarousel extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  const _BestsellersCarousel({required this.products});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 265,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: products.length,
        itemBuilder: (_, i) => _BestsellerCard(product: products[i]),
      ),
    );
  }
}

class _BestsellerCard extends StatefulWidget {
  final Map<String, dynamic> product;
  const _BestsellerCard({required this.product});
  @override
  State<_BestsellerCard> createState() => _BestsellerCardState();
}

class _BestsellerCardState extends State<_BestsellerCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _addAnim;

  @override
  void initState() {
    super.initState();
    _addAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _addAnim.dispose();
    super.dispose();
  }

  void _addToCart() {
    cartNotifier.value = [
      ...cartNotifier.value,
      Map<String, dynamic>.from(widget.product),
    ];
    _addAnim.forward().then((_) => _addAnim.reverse());
    final rv = List<Map<String, dynamic>>.from(recentlyViewedNotifier.value);
    rv.removeWhere((p) => p["name"] == widget.product["name"]);
    rv.insert(0, widget.product);
    recentlyViewedNotifier.value = rv.take(6).toList();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(_cartSnackBar(widget.product["name"], context));
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    return ValueListenableBuilder<Set<String>>(
      valueListenable: wishlistNotifier,
      builder: (_, wishlist, __) {
        final isWishlisted = wishlist.contains(p["name"]);
        return Container(
          width: 175,
          margin: const EdgeInsets.only(right: 14),
          decoration: BoxDecoration(
            color: kSurface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 16,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  _SkeletonImage(
                    url: p["image"],
                    width: 175,
                    height: 148,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  if ((p["tag"] as String).isNotEmpty)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: kRoseDark,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          p["tag"],
                          style: GoogleFonts.dmSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        final set = Set<String>.from(wishlistNotifier.value);
                        isWishlisted
                            ? set.remove(p["name"])
                            : set.add(p["name"] as String);
                        wishlistNotifier.value = set;
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Icon(
                          isWishlisted
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          size: 17,
                          color: isWishlisted ? kRoseMid : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(11, 9, 11, 11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      p["name"],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 13.5,
                        color: kTaupeDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, size: 13, color: kGold),
                        const SizedBox(width: 2),
                        Text(
                          "${p["rating"]}",
                          style: GoogleFonts.dmSans(
                            fontSize: 12,
                            color: kTaupe,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          "(${p["reviews"]})",
                          style: GoogleFonts.dmSans(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "₹${p["price"]}",
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            color: kRoseDark,
                          ),
                        ),
                        ScaleTransition(
                          scale: Tween<double>(
                            begin: 1.0,
                            end: 0.82,
                          ).animate(_addAnim),
                          child: GestureDetector(
                            onTap: _addToCart,
                            child: Container(
                              width: 34,
                              height: 34,
                              decoration: const BoxDecoration(
                                color: kRoseDark,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─── Product Card (Grid) ──────────────────────────────────────────────────────

class _ProductCard extends StatefulWidget {
  final Map<String, dynamic> product;
  const _ProductCard({required this.product});
  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _bounce;

  @override
  void initState() {
    super.initState();
    _bounce = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      lowerBound: 0.95,
      upperBound: 1.0,
    )..value = 1.0;
  }

  @override
  void dispose() {
    _bounce.dispose();
    super.dispose();
  }

  void _addToCart() {
    _bounce.reverse().then((_) => _bounce.forward());
    cartNotifier.value = [
      ...cartNotifier.value,
      Map<String, dynamic>.from(widget.product),
    ];
    final rv = List<Map<String, dynamic>>.from(recentlyViewedNotifier.value);
    rv.removeWhere((p) => p["name"] == widget.product["name"]);
    rv.insert(0, widget.product);
    recentlyViewedNotifier.value = rv.take(6).toList();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(_cartSnackBar(widget.product["name"], context));
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    return ValueListenableBuilder<Set<String>>(
      valueListenable: wishlistNotifier,
      builder: (_, wishlist, __) {
        final isWishlisted = wishlist.contains(p["name"]);
        return ScaleTransition(
          scale: _bounce,
          child: Container(
            decoration: BoxDecoration(
              color: kSurface,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(18),
                      ),
                      child: Image.network(
                        p["image"],
                        width: double.infinity,
                        height: 120,
                        fit: BoxFit.cover,
                        loadingBuilder: (_, child, progress) {
                          if (progress == null) return child;
                          return Container(
                            height: 120,
                            color: kChampagne,
                            child: const Center(
                              child: Icon(
                                Icons.bakery_dining_rounded,
                                color: kTaupeLight,
                                size: 28,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (_, __, ___) => Container(
                          height: 120,
                          color: kChampagne,
                          child: const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              color: kTaupeLight,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if ((p["tag"] as String).isNotEmpty)
                      Positioned(
                        top: 7,
                        left: 7,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: p["tag"] == "New"
                                ? kSuccess
                                : (p["tag"] == "Premium" ? kGold : kRoseDark),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            p["tag"],
                            style: GoogleFonts.dmSans(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      top: 7,
                      right: 7,
                      child: GestureDetector(
                        onTap: () {
                          final set = Set<String>.from(wishlistNotifier.value);
                          isWishlisted
                              ? set.remove(p["name"])
                              : set.add(p["name"] as String);
                          wishlistNotifier.value = set;
                        },
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Icon(
                            isWishlisted
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            size: 15,
                            color: isWishlisted ? kRoseMid : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        p["name"],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 12.5,
                          color: kTaupeDark,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            size: 11,
                            color: kGold,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            "${p["rating"]}",
                            style: GoogleFonts.dmSans(
                              fontSize: 11,
                              color: kTaupe,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "  (${p["reviews"]})",
                            style: GoogleFonts.dmSans(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "₹${p["price"]}",
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              color: kRoseDark,
                            ),
                          ),
                          GestureDetector(
                            onTap: _addToCart,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                color: kRoseDark,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add_rounded,
                                color: Colors.white,
                                size: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ─── Recently Viewed ──────────────────────────────────────────────────────────

class _RecentlyViewedSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Map<String, dynamic>>>(
      valueListenable: recentlyViewedNotifier,
      builder: (_, items, __) {
        if (items.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionHeader(title: "Recently Viewed 👀", onSeeAll: () {}),
            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: items.length,
                itemBuilder: (_, i) {
                  final p = items[i];
                  return Container(
                    width: 70,
                    margin: const EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.network(
                            p["image"],
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 60,
                              height: 60,
                              color: kChampagne,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          p["name"],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.dmSans(
                            fontSize: 9.5,
                            color: kTaupeLight,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

// ─── Reviews Snippet ──────────────────────────────────────────────────────────

class _ReviewsSnippet extends StatelessWidget {
  const _ReviewsSnippet();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(title: "What customers say 💬", onSeeAll: () {}),
        SizedBox(
          height: 155,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: customerReviews.length,
            itemBuilder: (_, i) {
              final r = customerReviews[i];
              return Container(
                width: 240,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: kSurface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: r["avatarColor"] as Color,
                          child: Text(
                            r["avatar"],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                r["name"],
                                style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.5,
                                  color: kTaupeDark,
                                ),
                              ),
                              Text(
                                r["item"],
                                style: GoogleFonts.dmSans(
                                  fontSize: 10.5,
                                  color: kRoseMid,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          r["date"],
                          style: GoogleFonts.dmSans(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: List.generate(
                        r["rating"] as int,
                        (_) => const Icon(
                          Icons.star_rounded,
                          color: kGold,
                          size: 13,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      r["comment"],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        height: 1.4,
                        color: kTaupeLight,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ─── Explore Screen ───────────────────────────────────────────────────────────

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});
  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _sort = "Popular";
  final List<String> _sorts = [
    "Popular",
    "Price: Low",
    "Price: High",
    "Rating",
  ];

  List<Map<String, dynamic>> get _sorted {
    final list = List<Map<String, dynamic>>.from(products);
    switch (_sort) {
      case "Price: Low":
        list.sort((a, b) => (a["price"] as int).compareTo(b["price"] as int));
        break;
      case "Price: High":
        list.sort((a, b) => (b["price"] as int).compareTo(a["price"] as int));
        break;
      case "Rating":
        list.sort(
          (a, b) => (b["rating"] as double).compareTo(a["rating"] as double),
        );
        break;
      default:
        break;
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kIvory,
      appBar: AppBar(
        backgroundColor: kIvory,
        elevation: 0,
        titleSpacing: 16,
        title: Text(
          "Explore",
          style: GoogleFonts.cormorantGaramond(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: kTaupeDark,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: DropdownButton<String>(
              value: _sort,
              underline: const SizedBox(),
              style: GoogleFonts.dmSans(
                color: kRoseMid,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              icon: const Icon(Icons.sort_rounded, color: kRoseMid, size: 18),
              items: _sorts
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (v) => setState(() => _sort = v!),
            ),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
        itemCount: _sorted.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.72,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (_, i) => _ProductCard(product: _sorted[i]),
      ),
    );
  }
}

// ─── Enhanced Cart Screen ─────────────────────────────────────────────────────

class CartScreen extends StatefulWidget {
  final void Function(int) onNavigate;
  const CartScreen({super.key, required this.onNavigate});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _couponCtrl = TextEditingController();
  String? _appliedCoupon;
  int _discountAmount = 0;

  void _applyCoupon() {
    final code = _couponCtrl.text.trim().toUpperCase();
    if (code == "SWEET10") {
      setState(() {
        _appliedCoupon = code;
        _discountAmount = 10;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Coupon SWEET10 applied — 10% off!",
            style: GoogleFonts.dmSans(fontWeight: FontWeight.w600),
          ),
          backgroundColor: kSuccess,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 90),
        ),
      );
    } else if (code == "CLOUD20") {
      setState(() {
        _appliedCoupon = code;
        _discountAmount = 20;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Coupon CLOUD20 applied — 20% off!",
            style: GoogleFonts.dmSans(fontWeight: FontWeight.w600),
          ),
          backgroundColor: kSuccess,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 90),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Invalid coupon code.",
            style: GoogleFonts.dmSans(fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 90),
        ),
      );
    }
  }

  void _updateQty(List<Map<String, dynamic>> cart, int index, int delta) {
    final updated = List<Map<String, dynamic>>.from(cart);
    if (delta < 0) {
      updated.removeAt(index);
    } else {
      updated.insert(index + 1, Map<String, dynamic>.from(cart[index]));
    }
    cartNotifier.value = updated;
  }

  Map<String, int> _getQuantities(List<Map<String, dynamic>> cart) {
    final Map<String, int> qtys = {};
    for (final item in cart) {
      qtys[item["name"]] = (qtys[item["name"]] ?? 0) + 1;
    }
    return qtys;
  }

  List<Map<String, dynamic>> _getUniqueItems(List<Map<String, dynamic>> cart) {
    final seen = <String>{};
    final unique = <Map<String, dynamic>>[];
    for (final item in cart) {
      if (seen.add(item["name"] as String)) unique.add(item);
    }
    return unique;
  }

  int _subtotal(List<Map<String, dynamic>> cart) =>
      cart.fold(0, (s, i) => s + (i["price"] as int));

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Map<String, dynamic>>>(
      valueListenable: cartNotifier,
      builder: (_, cart, __) {
        final subtotal = _subtotal(cart);
        final deliveryFee = subtotal >= 800 ? 0 : 49;
        final gst = (subtotal * 0.05).round();
        final discount = _appliedCoupon != null
            ? (subtotal * _discountAmount ~/ 100)
            : 0;
        final total = subtotal + deliveryFee + gst - discount;
        final uniqueItems = _getUniqueItems(cart);
        final quantities = _getQuantities(cart);

        return Scaffold(
          backgroundColor: kIvory,
          appBar: AppBar(
            backgroundColor: kIvory,
            elevation: 0,
            titleSpacing: 16,
            title: Text(
              "My Cart",
              style: GoogleFonts.cormorantGaramond(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: kTaupeDark,
              ),
            ),
            actions: [
              if (cart.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    onTap: () => cartNotifier.value = [],
                    child: Text(
                      "Clear all",
                      style: GoogleFonts.dmSans(
                        color: Colors.red,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          body: cart.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: kChampagne.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text("🛒", style: TextStyle(fontSize: 56)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Your cart is empty",
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: kTaupeDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Add some delicious treats!",
                        style: GoogleFonts.dmSans(color: kTaupeLight),
                      ),
                      const SizedBox(height: 28),
                      GestureDetector(
                        onTap: () => widget.onNavigate(1),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: kRoseDark,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            "Browse Menu",
                            style: GoogleFonts.dmSans(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                  children: [
                    ...uniqueItems.map((item) {
                      final qty = quantities[item["name"]] ?? 1;
                      final itemIndex = cart.lastIndexWhere(
                        (c) => c["name"] == item["name"],
                      );
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: kSurface,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 12,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.network(
                                  item["image"],
                                  width: 78,
                                  height: 78,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    width: 78,
                                    height: 78,
                                    color: kChampagne,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item["name"],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.dmSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                              color: kTaupeDark,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            final updated =
                                                List<Map<String, dynamic>>.from(
                                                  cartNotifier.value,
                                                );
                                            updated.removeWhere(
                                              (c) => c["name"] == item["name"],
                                            );
                                            cartNotifier.value = updated;
                                          },
                                          child: Container(
                                            width: 26,
                                            height: 26,
                                            decoration: BoxDecoration(
                                              color: Colors.red.withOpacity(
                                                0.08,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.close_rounded,
                                              color: Colors.red,
                                              size: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      item["category"],
                                      style: GoogleFonts.dmSans(
                                        fontSize: 11.5,
                                        color: kTaupeLight,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "₹${(item["price"] as int) * qty}",
                                          style: GoogleFonts.dmSans(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 16,
                                            color: kRoseDark,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () => _updateQty(
                                                cart,
                                                itemIndex,
                                                -1,
                                              ),
                                              child: Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: kIvory,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                    color: kRoseLight
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                                child: const Icon(
                                                  Icons.remove,
                                                  size: 15,
                                                  color: kTaupeDark,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 34,
                                              alignment: Alignment.center,
                                              child: Text(
                                                "$qty",
                                                style: GoogleFonts.dmSans(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  color: kTaupeDark,
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () => _updateQty(
                                                cart,
                                                itemIndex,
                                                1,
                                              ),
                                              child: Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: kRoseDark,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: const Icon(
                                                  Icons.add,
                                                  size: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 8),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: kSurface,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.local_offer_outlined,
                                color: kRoseMid,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Apply Coupon",
                                style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: kTaupeDark,
                                ),
                              ),
                              if (_appliedCoupon != null) ...[
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: kSuccess.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    _appliedCoupon!,
                                    style: GoogleFonts.dmSans(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: kSuccess,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          if (_appliedCoupon == null) ...[
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _couponCtrl,
                                    style: GoogleFonts.dmSans(
                                      color: kTaupeDark,
                                      fontSize: 13,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Try SWEET10 or CLOUD20",
                                      hintStyle: GoogleFonts.dmSans(
                                        color: kTaupeLight.withOpacity(0.7),
                                        fontSize: 13,
                                      ),
                                      filled: true,
                                      fillColor: kIvory,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 12,
                                          ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                      isDense: true,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: _applyCoupon,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: kRoseDark,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      "Apply",
                                      style: GoogleFonts.dmSans(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: kSurface,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order Summary",
                            style: GoogleFonts.cormorantGaramond(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: kTaupeDark,
                            ),
                          ),
                          const SizedBox(height: 14),
                          _summaryRow("Subtotal", "₹$subtotal"),
                          const SizedBox(height: 8),
                          _summaryRow(
                            "Delivery Fee",
                            deliveryFee == 0 ? "FREE" : "₹$deliveryFee",
                            valueColor: deliveryFee == 0 ? kSuccess : null,
                          ),
                          const SizedBox(height: 8),
                          _summaryRow("GST (5%)", "₹$gst"),
                          if (_appliedCoupon != null) ...[
                            const SizedBox(height: 8),
                            _summaryRow(
                              "Discount ($_appliedCoupon)",
                              "−₹$discount",
                              valueColor: kSuccess,
                            ),
                          ],
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Divider(color: kChampagne),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Payable",
                                style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: kTaupeDark,
                                ),
                              ),
                              Text(
                                "₹$total",
                                style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20,
                                  color: kRoseDark,
                                ),
                              ),
                            ],
                          ),
                          if (subtotal > 0 && subtotal < 800) ...[
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: kGoldLight,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.info_outline_rounded,
                                    color: kGold,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      "Add ₹${800 - subtotal} more for FREE delivery!",
                                      style: GoogleFonts.dmSans(
                                        fontSize: 12,
                                        color: kTaupeDark,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            _fadeRoute(
                              CheckoutPage(
                                cart: cart,
                                subtotal: subtotal,
                                deliveryFee: deliveryFee,
                                gst: gst,
                                discount: discount,
                                total: total,
                                onNavigate: widget.onNavigate,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kRoseDark,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Proceed to Checkout",
                              style: GoogleFonts.dmSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward_rounded, size: 18),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
        );
      },
    );
  }

  Widget _summaryRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.dmSans(color: kTaupeLight, fontSize: 13.5),
        ),
        Text(
          value,
          style: GoogleFonts.dmSans(
            color: valueColor ?? kTaupeDark,
            fontWeight: FontWeight.w600,
            fontSize: 13.5,
          ),
        ),
      ],
    );
  }
}

// ─── Checkout Page ────────────────────────────────────────────────────────────

class CheckoutPage extends StatefulWidget {
  final List<Map<String, dynamic>> cart;
  final int subtotal;
  final int deliveryFee;
  final int gst;
  final int discount;
  final int total;
  final void Function(int) onNavigate;

  const CheckoutPage({
    super.key,
    required this.cart,
    required this.subtotal,
    required this.deliveryFee,
    required this.gst,
    required this.discount,
    required this.total,
    required this.onNavigate,
  });
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _nameCtrl = TextEditingController(text: "Aanya Sharma");
  final _phoneCtrl = TextEditingController(text: "+91 98765 43210");
  final _addressCtrl = TextEditingController(
    text: "B-24, Greater Kailash I, New Delhi, Delhi 110048",
  );
  final _instructionsCtrl = TextEditingController();
  String _paymentMethod = "cod";
  bool _placing = false;

  final List<Map<String, dynamic>> _paymentOptions = [
    {
      "id": "cod",
      "title": "Cash on Delivery",
      "subtitle": "Pay when your order arrives",
      "icon": Icons.money_rounded,
    },
    {
      "id": "upi",
      "title": "UPI",
      "subtitle": "GPay, PhonePe, Paytm & more",
      "icon": Icons.account_balance_wallet_rounded,
    },
    {
      "id": "card",
      "title": "Credit / Debit Card",
      "subtitle": "Visa, Mastercard, RuPay",
      "icon": Icons.credit_card_rounded,
    },
    {
      "id": "wallet",
      "title": "Wallet",
      "subtitle": "Cookie Cloud Wallet Balance: ₹500",
      "icon": Icons.wallet_rounded,
    },
  ];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _instructionsCtrl.dispose();
    super.dispose();
  }

  void _confirmOrder() async {
    if (_nameCtrl.text.trim().isEmpty ||
        _phoneCtrl.text.trim().isEmpty ||
        _addressCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please fill in all required fields.",
            style: GoogleFonts.dmSans(fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 90),
        ),
      );
      return;
    }
    setState(() => _placing = true);
    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;

    orderHistoryNotifier.value = [
      {
        "items": List<Map<String, dynamic>>.from(widget.cart),
        "total": widget.total,
        "date": "Today",
        "status": "Confirmed",
        "payment": _paymentMethod,
        "address": _addressCtrl.text.trim(),
      },
      ...orderHistoryNotifier.value,
    ];
    cartNotifier.value = [];
    setState(() => _placing = false);

    if (!mounted) return;
    Navigator.pop(context);
    widget.onNavigate(3);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle_rounded,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 10),
            Text(
              "Order placed! 🎉 Your goodies are on the way.",
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: kSuccess,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 90),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final uniqueItems = <Map<String, dynamic>>[];
    final seen = <String>{};
    final qtys = <String, int>{};
    for (final item in widget.cart) {
      qtys[item["name"]] = (qtys[item["name"]] ?? 0) + 1;
      if (seen.add(item["name"] as String)) uniqueItems.add(item);
    }

    return Scaffold(
      backgroundColor: kIvory,
      appBar: AppBar(
        backgroundColor: kIvory,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: kTaupeDark,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Checkout",
          style: GoogleFonts.cormorantGaramond(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: kTaupeDark,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
        children: [
          _sectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle(Icons.location_on_outlined, "Delivery Details"),
                const SizedBox(height: 16),
                _checkoutField(
                  Icons.person_outline_rounded,
                  "Full Name",
                  _nameCtrl,
                ),
                const SizedBox(height: 12),
                _checkoutField(
                  Icons.phone_outlined,
                  "Phone Number",
                  _phoneCtrl,
                  type: TextInputType.phone,
                ),
                const SizedBox(height: 12),
                _checkoutField(
                  Icons.home_outlined,
                  "Delivery Address",
                  _addressCtrl,
                  maxLines: 2,
                ),
                const SizedBox(height: 12),
                _checkoutField(
                  Icons.notes_rounded,
                  "Delivery Instructions (optional)",
                  _instructionsCtrl,
                  maxLines: 2,
                  required: false,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          _sectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle(Icons.payment_outlined, "Payment Method"),
                const SizedBox(height: 14),
                ..._paymentOptions.map((opt) {
                  final isSelected = _paymentMethod == opt["id"];
                  return GestureDetector(
                    onTap: () => setState(() => _paymentMethod = opt["id"]),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? kRoseDark.withOpacity(0.06)
                            : kIvory,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected
                              ? kRoseDark
                              : kTaupeLight.withOpacity(0.3),
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? kRoseDark
                                  : kChampagne.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              opt["icon"] as IconData,
                              color: isSelected ? Colors.white : kRoseMid,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  opt["title"],
                                  style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13.5,
                                    color: kTaupeDark,
                                  ),
                                ),
                                Text(
                                  opt["subtitle"],
                                  style: GoogleFonts.dmSans(
                                    fontSize: 12,
                                    color: kTaupeLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected
                                  ? kRoseDark
                                  : Colors.transparent,
                              border: Border.all(
                                color: isSelected
                                    ? kRoseDark
                                    : kTaupeLight.withOpacity(0.5),
                                width: 2,
                              ),
                            ),
                            child: isSelected
                                ? const Icon(
                                    Icons.check_rounded,
                                    color: Colors.white,
                                    size: 13,
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                  );
                }),

                if (_paymentMethod == "upi") ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: kIvory,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            style: GoogleFonts.dmSans(
                              color: kTaupeDark,
                              fontSize: 13,
                            ),
                            decoration: InputDecoration(
                              hintText: "Enter UPI ID (e.g. name@upi)",
                              hintStyle: GoogleFonts.dmSans(
                                color: kTaupeLight.withOpacity(0.7),
                                fontSize: 13,
                              ),
                              filled: true,
                              fillColor: kSurface,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              isDense: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: kRoseDark,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Verify",
                            style: GoogleFonts.dmSans(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                if (_paymentMethod == "card") ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: kIvory,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _checkoutField(
                          Icons.credit_card_rounded,
                          "Card Number",
                          TextEditingController(text: ""),
                          required: false,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: _checkoutField(
                                Icons.calendar_today_outlined,
                                "MM / YY",
                                TextEditingController(),
                                required: false,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _checkoutField(
                                Icons.lock_outline_rounded,
                                "CVV",
                                TextEditingController(),
                                required: false,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 14),

          _sectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle(Icons.receipt_long_outlined, "Order Summary"),
                const SizedBox(height: 14),
                ...uniqueItems.map((item) {
                  final qty = qtys[item["name"]] ?? 1;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            item["image"],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 50,
                              height: 50,
                              color: kChampagne,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["name"],
                                style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: kTaupeDark,
                                ),
                              ),
                              Text(
                                "× $qty",
                                style: GoogleFonts.dmSans(
                                  fontSize: 12,
                                  color: kTaupeLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "₹${(item["price"] as int) * qty}",
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 13.5,
                            color: kRoseDark,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const Divider(color: kChampagne),
                const SizedBox(height: 8),
                _checkoutSummaryRow("Item Total", "₹${widget.subtotal}"),
                const SizedBox(height: 6),
                _checkoutSummaryRow(
                  "Delivery",
                  widget.deliveryFee == 0 ? "FREE" : "₹${widget.deliveryFee}",
                  valueColor: widget.deliveryFee == 0 ? kSuccess : null,
                ),
                const SizedBox(height: 6),
                _checkoutSummaryRow("GST (5%)", "₹${widget.gst}"),
                if (widget.discount > 0) ...[
                  const SizedBox(height: 6),
                  _checkoutSummaryRow(
                    "Coupon Discount",
                    "−₹${widget.discount}",
                    valueColor: kSuccess,
                  ),
                ],
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(color: kChampagne),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Payable",
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: kTaupeDark,
                      ),
                    ),
                    Text(
                      "₹${widget.total}",
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: kRoseDark,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),

          SizedBox(
            height: 58,
            child: ElevatedButton(
              onPressed: _placing ? null : _confirmOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: kRoseDark,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: _placing
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.check_circle_outline_rounded,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Confirm Order • ₹${widget.total}",
                          style: GoogleFonts.dmSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _sectionCard({required Widget child}) => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: kSurface,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 12,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: child,
  );

  Widget _sectionTitle(IconData icon, String title) => Row(
    children: [
      Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: kChampagne.withOpacity(0.6),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: kRoseMid, size: 18),
      ),
      const SizedBox(width: 10),
      Text(
        title,
        style: GoogleFonts.cormorantGaramond(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: kTaupeDark,
        ),
      ),
    ],
  );

  // ── FIX: removed `const` from EdgeInsets.only so maxLines > 1 evaluates at runtime
  Widget _checkoutField(
    IconData icon,
    String hint,
    TextEditingController ctrl, {
    TextInputType type = TextInputType.text,
    int maxLines = 1,
    bool required = true,
  }) {
    return TextField(
      controller: ctrl,
      keyboardType: type,
      maxLines: maxLines,
      style: GoogleFonts.dmSans(color: kTaupeDark, fontSize: 13.5),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.dmSans(
          color: kTaupeLight.withOpacity(0.7),
          fontSize: 13,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.only(bottom: maxLines > 1 ? 24 : 0), // ← FIXED
          child: Icon(icon, color: kRoseLight, size: 18),
        ),
        filled: true,
        fillColor: kIvory,
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: kRoseMid, width: 1.5),
        ),
        isDense: true,
      ),
    );
  }

  Widget _checkoutSummaryRow(String label, String value, {Color? valueColor}) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.dmSans(color: kTaupeLight, fontSize: 13),
          ),
          Text(
            value,
            style: GoogleFonts.dmSans(
              color: valueColor ?? kTaupeDark,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      );
}

// ─── Order History ────────────────────────────────────────────────────────────

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kIvory,
      appBar: AppBar(
        backgroundColor: kIvory,
        elevation: 0,
        titleSpacing: 16,
        title: Text(
          "Orders",
          style: GoogleFonts.cormorantGaramond(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: kTaupeDark,
          ),
        ),
      ),
      body: ValueListenableBuilder<List<Map<String, dynamic>>>(
        valueListenable: orderHistoryNotifier,
        builder: (_, orders, __) {
          if (orders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("📦", style: TextStyle(fontSize: 60)),
                  const SizedBox(height: 16),
                  Text(
                    "No orders yet",
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: kTaupeDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Your order history will appear here",
                    style: GoogleFonts.dmSans(color: kTaupeLight),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
            itemCount: orders.length,
            itemBuilder: (_, i) {
              final order = orders[i];
              final items = order["items"] as List<Map<String, dynamic>>;
              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  color: kSurface,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: kSuccess.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.check_circle_rounded,
                                  color: kSuccess,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "Confirmed",
                                  style: GoogleFonts.dmSans(
                                    color: kSuccess,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Text(
                            order["date"] ?? "",
                            style: GoogleFonts.dmSans(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        itemCount: items.length,
                        itemBuilder: (_, j) => Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              items[j]["image"],
                              width: 52,
                              height: 52,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                width: 52,
                                height: 52,
                                color: kChampagne,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
                      child: Row(
                        children: [
                          Text(
                            "${items.length} item${items.length > 1 ? 's' : ''}",
                            style: GoogleFonts.dmSans(
                              color: kTaupeLight,
                              fontSize: 13,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "₹${order["total"]}",
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              color: kRoseDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
                      decoration: BoxDecoration(
                        color: kChampagne.withOpacity(0.4),
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _trackStep("Placed", true),
                          _trackLine(),
                          _trackStep("Baking", true),
                          _trackLine(),
                          _trackStep("On Way", false),
                          _trackLine(),
                          _trackStep("Delivered", false),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _trackStep(String label, bool done) => Column(
    children: [
      Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: done ? kRoseDark : Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: done ? kRoseDark : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: done
            ? const Icon(Icons.check_rounded, color: Colors.white, size: 13)
            : null,
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: GoogleFonts.dmSans(
          fontSize: 9.5,
          fontWeight: FontWeight.w500,
          color: done ? kRoseDark : Colors.grey,
        ),
      ),
    ],
  );

  Widget _trackLine() => Expanded(
    child: Container(
      height: 1.5,
      color: Colors.grey.shade200,
      margin: const EdgeInsets.only(bottom: 16),
    ),
  );
}

// ─── Addresses Screen ─────────────────────────────────────────────────────────

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});
  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  int _defaultIndex = 0;
  final List<Map<String, dynamic>> _addresses = [
    {
      "type": "Home",
      "icon": Icons.home_rounded,
      "name": "Aanya Sharma",
      "address": "B-24, Greater Kailash I, New Delhi, Delhi 110048",
      "phone": "+91 98765 43210",
    },
    {
      "type": "Office",
      "icon": Icons.business_rounded,
      "name": "Aanya Sharma",
      "address": "Tower A, Cyber City, Sector 25, Gurugram, Haryana 122002",
      "phone": "+91 98765 43210",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kIvory,
      appBar: AppBar(
        backgroundColor: kIvory,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: kTaupeDark,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Delivery Addresses",
          style: GoogleFonts.cormorantGaramond(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: kTaupeDark,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...List.generate(_addresses.length, (i) {
            final addr = _addresses[i];
            final isDefault = i == _defaultIndex;
            return Container(
              margin: const EdgeInsets.only(bottom: 14),
              decoration: BoxDecoration(
                color: kSurface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: isDefault
                      ? kRoseMid.withOpacity(0.6)
                      : Colors.transparent,
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: isDefault
                                ? kRoseDark
                                : kChampagne.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            addr["icon"] as IconData,
                            color: isDefault ? Colors.white : kRoseMid,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          addr["type"] as String,
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: kTaupeDark,
                          ),
                        ),
                        const Spacer(),
                        if (isDefault)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: kSuccess.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              "Default",
                              style: GoogleFonts.dmSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: kSuccess,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      addr["name"] as String,
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: kTaupeDark,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      addr["address"] as String,
                      style: GoogleFonts.dmSans(
                        fontSize: 13,
                        color: kTaupeLight,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      addr["phone"] as String,
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        color: kTaupeLight,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: kRoseMid.withOpacity(0.4),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.edit_outlined,
                                color: kRoseMid,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "Edit",
                                style: GoogleFonts.dmSans(
                                  color: kRoseMid,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (!isDefault)
                          GestureDetector(
                            onTap: () => setState(() => _defaultIndex = i),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: kRoseDark,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "Set as Default",
                                style: GoogleFonts.dmSans(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ─── Wishlist Screen ──────────────────────────────────────────────────────────

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kIvory,
      appBar: AppBar(
        backgroundColor: kIvory,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: kTaupeDark,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "My Wishlist",
          style: GoogleFonts.cormorantGaramond(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: kTaupeDark,
          ),
        ),
      ),
      body: ValueListenableBuilder<Set<String>>(
        valueListenable: wishlistNotifier,
        builder: (_, wishlist, __) {
          final items = products
              .where((p) => wishlist.contains(p["name"]))
              .toList();
          if (items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("🤍", style: TextStyle(fontSize: 60)),
                  const SizedBox(height: 16),
                  Text(
                    "Your wishlist is empty",
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: kTaupeDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Save items you love!",
                    style: GoogleFonts.dmSans(color: kTaupeLight),
                  ),
                ],
              ),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.72,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (_, i) => _ProductCard(product: items[i]),
          );
        },
      ),
    );
  }
}

// ─── Placeholder Screen ───────────────────────────────────────────────────────

class _PlaceholderScreen extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  const _PlaceholderScreen({
    required this.emoji,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kIvory,
      appBar: AppBar(
        backgroundColor: kIvory,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: kTaupeDark,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title,
          style: GoogleFonts.cormorantGaramond(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: kTaupeDark,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 60)),
            const SizedBox(height: 16),
            Text(
              title,
              style: GoogleFonts.cormorantGaramond(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: kTaupeDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: GoogleFonts.dmSans(color: kTaupeLight, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Profile Screen ───────────────────────────────────────────────────────────

class ProfileScreen extends StatelessWidget {
  final void Function(int) onNavigate;
  const ProfileScreen({super.key, required this.onNavigate});

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: kSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          "Help & Support",
          style: GoogleFonts.cormorantGaramond(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: kTaupeDark,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "📧 Email: support@cookiecloud.in",
              style: GoogleFonts.dmSans(color: kTaupeDark, fontSize: 13),
            ),
            const SizedBox(height: 8),
            Text(
              "📞 Phone: +91 98765 43210",
              style: GoogleFonts.dmSans(color: kTaupeDark, fontSize: 13),
            ),
            const SizedBox(height: 8),
            Text(
              "🕐 Hours: Mon–Sat, 9 AM – 6 PM",
              style: GoogleFonts.dmSans(color: kTaupeDark, fontSize: 13),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Close",
              style: GoogleFonts.dmSans(
                color: kRoseMid,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kIvory,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [kRoseDark, Color(0xFFC8938A)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              padding: EdgeInsets.fromLTRB(
                20,
                MediaQuery.of(context).padding.top + 16,
                20,
                28,
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kGold.withOpacity(0.25),
                      border: Border.all(
                        color: kGold.withOpacity(0.6),
                        width: 2,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "A",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: kGold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Aanya Sharma",
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "aanya@example.com",
                    style: GoogleFonts.dmSans(
                      color: Colors.white60,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ValueListenableBuilder<List<Map<String, dynamic>>>(
                        valueListenable: orderHistoryNotifier,
                        builder: (_, orders, __) =>
                            _statChip("${orders.length}", "Orders"),
                      ),
                      const SizedBox(width: 20),
                      ValueListenableBuilder<Set<String>>(
                        valueListenable: wishlistNotifier,
                        builder: (_, w, __) =>
                            _statChip("${w.length}", "Wishlist"),
                      ),
                      const SizedBox(width: 20),
                      _statChip("4.9", "Rating"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Column(
                children: [
                  _profileTile(
                    Icons.shopping_bag_outlined,
                    "My Orders",
                    "Track your orders",
                    onTap: () => onNavigate(3),
                  ),
                  _profileTile(
                    Icons.favorite_border_rounded,
                    "Wishlist",
                    "Saved for later",
                    onTap: () => Navigator.push(
                      context,
                      _fadeRoute(const WishlistScreen()),
                    ),
                  ),
                  _profileTile(
                    Icons.location_on_outlined,
                    "Addresses",
                    "Manage delivery addresses",
                    onTap: () => Navigator.push(
                      context,
                      _fadeRoute(const AddressesScreen()),
                    ),
                  ),
                  _profileTile(
                    Icons.payment_outlined,
                    "Payment",
                    "Cards & UPI",
                    onTap: () => Navigator.push(
                      context,
                      _fadeRoute(
                        const _PlaceholderScreen(
                          emoji: "💳",
                          title: "Payment",
                          subtitle: "Manage your cards & UPI",
                        ),
                      ),
                    ),
                  ),
                  _profileTile(
                    Icons.help_outline_rounded,
                    "Help & Support",
                    "FAQs & contact",
                    onTap: () => _showHelpDialog(context),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        _fadeRoute(const LoginPage()),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        "Sign Out",
                        style: GoogleFonts.dmSans(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _statChip(String value, String label) => Column(
    children: [
      Text(
        value,
        style: GoogleFonts.cormorantGaramond(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      Text(
        label,
        style: GoogleFonts.dmSans(fontSize: 11, color: Colors.white60),
      ),
    ],
  );

  static Widget _profileTile(
    IconData icon,
    String title,
    String subtitle, {
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: kSurface,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: kChampagne.withOpacity(0.6),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: kRoseMid, size: 20),
        ),
        title: Text(
          title,
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: kTaupeDark,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.dmSans(fontSize: 12, color: kTaupeLight),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: Colors.grey,
          size: 20,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}

// ─── Utils ────────────────────────────────────────────────────────────────────

PageRouteBuilder _fadeRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, anim, __, child) =>
        FadeTransition(opacity: anim, child: child),
    transitionDuration: const Duration(milliseconds: 400),
  );
}
