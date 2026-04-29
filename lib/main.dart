// ============================================================
//  Cookie Cloud — Final Complete Flutter App
//  All features working: Chatbot, Profile, Item Details,
//  Checkout with Gift, Address & Payment management
// ============================================================
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

// ─── Config ───────────────────────────────────────────────────────────────────
class AppConfig {
  // Replace 'YOUR_ANTHROPIC_API_KEY' with your real Anthropic API key.
  // When set to the placeholder, the chatbot uses smart keyword fallback responses.
  static const String anthropicApiKey = 'YOUR_ANTHROPIC_API_KEY';

  // Google Apps Script web-app URL for Sheets logging (optional)
  static const String sheetsWebAppUrl =
      'https://script.google.com/macros/s/YOUR_APPS_SCRIPT_ID/exec';
}

// ─── Google Sheets Service ────────────────────────────────────────────────────
class SheetsService {
  static Future<void> appendRow(List<String> row) async {
    try {
      await http
          .post(
            Uri.parse(AppConfig.sheetsWebAppUrl),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'row': row}),
          )
          .timeout(const Duration(seconds: 8));
    } catch (_) {}
  }

  static Future<void> logSignUp({
    required String name,
    required String email,
    required String phone,
    required String dob,
  }) async {
    await appendRow([name, email, phone, dob, DateTime.now().toIso8601String(), 'SIGNUP']);
  }

  static Future<void> logLogin({required String email}) async {
    await appendRow(['', email, '', '', DateTime.now().toIso8601String(), 'LOGIN']);
  }
}

// ─── In-memory user store ─────────────────────────────────────────────────────
class UserStore {
  static final Map<String, Map<String, String>> _users = {};

  static bool exists(String email) =>
      _users.containsKey(email.trim().toLowerCase());

  static bool register({
    required String name,
    required String email,
    required String phone,
    required String dob,
    required String password,
  }) {
    final key = email.trim().toLowerCase();
    if (_users.containsKey(key)) return false;
    _users[key] = {
      'name': name.trim(),
      'email': key,
      'phone': phone.trim(),
      'dob': dob,
      'password': password,
    };
    return true;
  }

  static bool login({required String email, required String password}) {
    final key = email.trim().toLowerCase();
    final user = _users[key];
    if (user == null) return false;
    return user['password'] == password;
  }

  static Map<String, String>? getUser(String email) =>
      _users[email.trim().toLowerCase()];
}

// ─── Global State ─────────────────────────────────────────────────────────────
final ValueNotifier<List<Map<String, dynamic>>> cartNotifier = ValueNotifier([]);
final ValueNotifier<List<Map<String, dynamic>>> orderHistoryNotifier = ValueNotifier([]);
final ValueNotifier<Set<String>> wishlistNotifier = ValueNotifier({});
final ValueNotifier<List<Map<String, dynamic>>> recentlyViewedNotifier = ValueNotifier([]);
final ValueNotifier<String> locationNotifier = ValueNotifier("Connaught Place, New Delhi");

final ValueNotifier<List<Map<String, dynamic>>> savedAddressesNotifier =
    ValueNotifier([
  {
    "type": "Home",
    "houseNo": "B-24",
    "street": "Greater Kailash I",
    "city": "New Delhi",
    "state": "Delhi",
    "pincode": "110048",
    "landmark": "Near Market",
    "name": "Aanya Sharma",
    "phone": "+91 98765 43210",
    "isDefault": true,
  }
]);

final ValueNotifier<List<Map<String, dynamic>>> savedPaymentsNotifier =
    ValueNotifier([]);

String _loggedInEmail = '';

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

// ─── Products Data ────────────────────────────────────────────────────────────
final List<Map<String, dynamic>> products = [
  {
    "name": "Classic Chocolate Chip",
    "price": 220,
    "category": "Cookies",
    "image": "https://images.unsplash.com/photo-1499636136210-6f4ee915583e?w=400&q=80",
    "rating": 4.8,
    "reviews": 312,
    "tag": "Bestseller",
    "description": "Our signature cookie baked fresh daily. Golden edges with a perfectly gooey centre, loaded with premium Belgian chocolate chips and a pinch of sea salt.",
    "ingredients": "Flour, Butter, Sugar, Eggs, Belgian Chocolate Chips, Vanilla Extract, Sea Salt, Baking Soda",
    "calories": 280,
    "isEggless": false,
    "servingSize": "1 cookie (60g)",
    "deliveryTime": "30–45 mins",
    "available": true,
  },
  {
    "name": "Red Velvet Cookie",
    "price": 260,
    "category": "Cookies",
    "image": "https://images.unsplash.com/photo-1558961363-fa8fdf82db35?w=400&q=80",
    "rating": 4.9,
    "reviews": 204,
    "tag": "New",
    "description": "A stunning crimson cookie with a rich cocoa base, white chocolate chips and a delicate cream cheese swirl on top.",
    "ingredients": "Flour, Butter, Sugar, Eggs, Cocoa Powder, White Chocolate Chips, Cream Cheese, Red Food Colouring",
    "calories": 310,
    "isEggless": false,
    "servingSize": "1 cookie (65g)",
    "deliveryTime": "30–45 mins",
    "available": true,
  },
  {
    "name": "Oatmeal Raisin Cookie",
    "price": 190,
    "category": "Cookies",
    "image": "https://images.unsplash.com/photo-1590080875515-8a3a8dc5735e?w=400&q=80",
    "rating": 4.5,
    "reviews": 98,
    "tag": "",
    "description": "Hearty rolled oats, plump raisins and warm cinnamon make this a wholesome treat that satisfies every time.",
    "ingredients": "Rolled Oats, Flour, Butter, Brown Sugar, Eggs, Raisins, Cinnamon, Nutmeg, Vanilla",
    "calories": 240,
    "isEggless": false,
    "servingSize": "1 cookie (55g)",
    "deliveryTime": "30–45 mins",
    "available": true,
  },
  {
    "name": "Double Choco Cookie",
    "price": 240,
    "category": "Cookies",
    "image": "https://images.unsplash.com/photo-1606312619070-d48b4c652a52?w=400&q=80",
    "rating": 4.7,
    "reviews": 176,
    "tag": "Bestseller",
    "description": "Twice the chocolate, twice the joy. A dark cocoa dough packed with milk and dark chocolate chunks.",
    "ingredients": "Flour, Dark Cocoa, Butter, Sugar, Eggs, Milk Chocolate Chunks, Dark Chocolate Chunks",
    "calories": 320,
    "isEggless": false,
    "servingSize": "1 cookie (70g)",
    "deliveryTime": "30–45 mins",
    "available": true,
  },
  {
    "name": "Vanilla Dream Cake",
    "price": 1450,
    "category": "Cakes",
    "image": "https://images.unsplash.com/photo-1464349095431-e9a21285b5f3?w=400&q=80",
    "rating": 5.0,
    "reviews": 98,
    "tag": "Premium",
    "description": "Layers of moist Madagascar vanilla sponge, filled with Swiss meringue buttercream and topped with edible flowers.",
    "ingredients": "Flour, Butter, Sugar, Eggs, Madagascar Vanilla, Whole Milk, Swiss Meringue, Edible Flowers",
    "calories": 420,
    "isEggless": false,
    "servingSize": "1 slice (120g)",
    "deliveryTime": "45–60 mins",
    "available": true,
  },
  {
    "name": "Cheesecake",
    "price": 1180,
    "category": "Cakes",
    "image": "https://images.unsplash.com/photo-1533134242443-d4fd215305ad?w=400&q=80",
    "rating": 4.9,
    "reviews": 87,
    "tag": "Premium",
    "description": "Silky New-York-style baked cheesecake on a buttery graham cracker crust, finished with a glossy berry compote.",
    "ingredients": "Cream Cheese, Sugar, Eggs, Sour Cream, Vanilla, Graham Crackers, Butter, Berry Compote",
    "calories": 390,
    "isEggless": false,
    "servingSize": "1 slice (110g)",
    "deliveryTime": "45–60 mins",
    "available": true,
  },
  {
    "name": "Strawberry Shortcake",
    "price": 1250,
    "category": "Cakes",
    "image": "https://images.unsplash.com/photo-1488477181946-6428a0291777?w=400&q=80",
    "rating": 4.8,
    "reviews": 143,
    "tag": "",
    "description": "Light genoise layers soaked in strawberry syrup, filled with fresh cream and seasonal strawberries.",
    "ingredients": "Flour, Eggs, Sugar, Butter, Strawberry Syrup, Fresh Cream, Seasonal Strawberries",
    "calories": 360,
    "isEggless": false,
    "servingSize": "1 slice (115g)",
    "deliveryTime": "45–60 mins",
    "available": true,
  },
  {
    "name": "Dark Chocolate Cake",
    "price": 1380,
    "category": "Cakes",
    "image": "https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=400&q=80",
    "rating": 4.9,
    "reviews": 211,
    "tag": "Bestseller",
    "description": "Intensely dark, fudgy layers frosted with a glossy 70% ganache. Pure chocolate indulgence.",
    "ingredients": "Dark Cocoa, Flour, Butter, Sugar, Eggs, 70% Dark Chocolate, Fresh Cream, Vanilla",
    "calories": 450,
    "isEggless": false,
    "servingSize": "1 slice (125g)",
    "deliveryTime": "45–60 mins",
    "available": true,
  },
  {
    "name": "Chocolate Brownie",
    "price": 280,
    "category": "Brownies",
    "image": "https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=400&q=80",
    "rating": 4.6,
    "reviews": 241,
    "tag": "Bestseller",
    "description": "Dense, fudgy and crinkle-topped. Made with 70% dark chocolate and real butter for ultimate richness.",
    "ingredients": "Dark Chocolate (70%), Butter, Sugar, Eggs, Flour, Cocoa Powder, Vanilla Extract",
    "calories": 350,
    "isEggless": false,
    "servingSize": "1 piece (80g)",
    "deliveryTime": "30–45 mins",
    "available": true,
  },
  {
    "name": "Walnut Fudge Brownie",
    "price": 320,
    "category": "Brownies",
    "image": "https://images.unsplash.com/photo-1589985270826-4b7bb135bc9d?w=400&q=80",
    "rating": 4.7,
    "reviews": 134,
    "tag": "",
    "description": "Classic fudge brownie studded with crunchy California walnuts for the perfect textural contrast.",
    "ingredients": "Dark Chocolate, Butter, Sugar, Eggs, Flour, California Walnuts, Cocoa Powder",
    "calories": 380,
    "isEggless": false,
    "servingSize": "1 piece (85g)",
    "deliveryTime": "30–45 mins",
    "available": true,
  },
  {
    "name": "Cream Cheese Brownie",
    "price": 350,
    "category": "Brownies",
    "image": "https://images.unsplash.com/photo-1564355808539-22fda35bed7e?w=400&q=80",
    "rating": 4.8,
    "reviews": 89,
    "tag": "New",
    "description": "Ribbons of tangy cream cheese swirled into our signature dark chocolate brownie batter.",
    "ingredients": "Dark Chocolate, Butter, Sugar, Eggs, Flour, Cream Cheese, Vanilla, Cocoa Powder",
    "calories": 370,
    "isEggless": false,
    "servingSize": "1 piece (85g)",
    "deliveryTime": "30–45 mins",
    "available": true,
  },
  {
    "name": "Chocolate Donut",
    "price": 160,
    "category": "Donuts",
    "image": "https://images.unsplash.com/photo-1551024709-8f23befc6f87?w=400&q=80",
    "rating": 4.4,
    "reviews": 155,
    "tag": "",
    "description": "Pillowy yeast donut dipped in a rich chocolate glaze and topped with dark chocolate sprinkles.",
    "ingredients": "Flour, Yeast, Milk, Eggs, Sugar, Butter, Dark Chocolate Glaze, Sprinkles",
    "calories": 290,
    "isEggless": false,
    "servingSize": "1 donut (75g)",
    "deliveryTime": "30–40 mins",
    "available": true,
  },
  {
    "name": "Strawberry Donut",
    "price": 175,
    "category": "Donuts",
    "image": "https://images.unsplash.com/photo-1556913396-7a3c459ef68e?w=400&q=80",
    "rating": 4.5,
    "reviews": 119,
    "tag": "",
    "description": "Soft ring donut crowned with pink strawberry glaze and rainbow sprinkles — fun for all ages.",
    "ingredients": "Flour, Yeast, Milk, Eggs, Sugar, Butter, Strawberry Glaze, Rainbow Sprinkles",
    "calories": 280,
    "isEggless": false,
    "servingSize": "1 donut (72g)",
    "deliveryTime": "30–40 mins",
    "available": true,
  },
  {
    "name": "Glazed Ring Donut",
    "price": 150,
    "category": "Donuts",
    "image": "https://images.unsplash.com/photo-1527515637462-cff94eecc1ac?w=400&q=80",
    "rating": 4.3,
    "reviews": 92,
    "tag": "",
    "description": "The timeless classic. Light, airy dough with a sheer vanilla glaze that shatters at first bite.",
    "ingredients": "Flour, Yeast, Milk, Eggs, Sugar, Butter, Vanilla Glaze",
    "calories": 250,
    "isEggless": false,
    "servingSize": "1 donut (70g)",
    "deliveryTime": "30–40 mins",
    "available": true,
  },
  {
    "name": "Sprinkle Donut",
    "price": 185,
    "category": "Donuts",
    "image": "https://images.unsplash.com/photo-1562777717-dc6984f65a63?w=400&q=80",
    "rating": 4.6,
    "reviews": 177,
    "tag": "New",
    "description": "White glaze topped with a generous shower of multicoloured sugar sprinkles. Pure joy in every bite.",
    "ingredients": "Flour, Yeast, Milk, Eggs, Sugar, Butter, White Glaze, Multicolor Sprinkles",
    "calories": 275,
    "isEggless": false,
    "servingSize": "1 donut (72g)",
    "deliveryTime": "30–40 mins",
    "available": true,
  },
  {
    "name": "Butter Croissant",
    "price": 195,
    "category": "Pastries",
    "image": "https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=400&q=80",
    "rating": 4.7,
    "reviews": 176,
    "tag": "",
    "description": "72-hour laminated dough baked to produce impossibly flaky layers with a honeyed, buttery aroma.",
    "ingredients": "Flour, Butter (Lamination), Sugar, Salt, Yeast, Milk, Eggs (Egg Wash)",
    "calories": 320,
    "isEggless": false,
    "servingSize": "1 croissant (65g)",
    "deliveryTime": "30–45 mins",
    "available": true,
  },
  {
    "name": "Pain au Chocolat",
    "price": 240,
    "category": "Pastries",
    "image": "https://images.unsplash.com/photo-1549834125-82d3c38b6ad9?w=400&q=80",
    "rating": 4.8,
    "reviews": 143,
    "tag": "Premium",
    "description": "Two dark-chocolate batons wrapped in classic croissant dough. Paris in every bite.",
    "ingredients": "Flour, Butter, Sugar, Salt, Yeast, Milk, Dark Chocolate Batons, Eggs",
    "calories": 370,
    "isEggless": false,
    "servingSize": "1 piece (75g)",
    "deliveryTime": "30–45 mins",
    "available": true,
  },
  {
    "name": "Almond Danish",
    "price": 270,
    "category": "Pastries",
    "image": "https://images.unsplash.com/photo-1509440159596-0249088772ff?w=400&q=80",
    "rating": 4.6,
    "reviews": 88,
    "tag": "",
    "description": "Flaky pastry filled with almond frangipane, topped with toasted flaked almonds and a pearl sugar glaze.",
    "ingredients": "Flour, Butter, Almond Frangipane, Flaked Almonds, Pearl Sugar, Eggs, Milk",
    "calories": 340,
    "isEggless": false,
    "servingSize": "1 danish (70g)",
    "deliveryTime": "30–45 mins",
    "available": true,
  },
  {
    "name": "Blueberry Muffin",
    "price": 210,
    "category": "Muffins",
    "image": "https://images.unsplash.com/photo-1607958996333-41aef7caefaa?w=400&q=80",
    "rating": 4.6,
    "reviews": 188,
    "tag": "New",
    "description": "Tall domed muffin bursting with fresh blueberries and a crunchy lemon-sugar topping.",
    "ingredients": "Flour, Butter, Sugar, Eggs, Fresh Blueberries, Lemon Zest, Lemon Sugar, Buttermilk",
    "calories": 295,
    "isEggless": false,
    "servingSize": "1 muffin (90g)",
    "deliveryTime": "30–40 mins",
    "available": true,
  },
  {
    "name": "Chocolate Chip Muffin",
    "price": 230,
    "category": "Muffins",
    "image": "https://images.unsplash.com/photo-1558303578-2a3c65f6e3c4?w=400&q=80",
    "rating": 4.7,
    "reviews": 144,
    "tag": "",
    "description": "Fluffy vanilla muffin loaded with semi-sweet chocolate chips from top to bottom.",
    "ingredients": "Flour, Butter, Sugar, Eggs, Vanilla, Semi-Sweet Chocolate Chips, Buttermilk",
    "calories": 315,
    "isEggless": false,
    "servingSize": "1 muffin (90g)",
    "deliveryTime": "30–40 mins",
    "available": true,
  },
  {
    "name": "Banana Walnut Muffin",
    "price": 220,
    "category": "Muffins",
    "image": "https://images.unsplash.com/photo-1612198790700-6c5c47bef18c?w=400&q=80",
    "rating": 4.5,
    "reviews": 97,
    "tag": "",
    "description": "Super-moist banana muffin with crunchy walnut pieces and a hint of cinnamon.",
    "ingredients": "Ripe Bananas, Flour, Butter, Sugar, Eggs, Walnuts, Cinnamon, Vanilla",
    "calories": 305,
    "isEggless": false,
    "servingSize": "1 muffin (90g)",
    "deliveryTime": "30–40 mins",
    "available": true,
  },
  {
    "name": "Vanilla Cupcake",
    "price": 200,
    "category": "Cupcakes",
    "image": "https://images.unsplash.com/photo-1576618148400-f54bed99fcfd?w=400&q=80",
    "rating": 4.5,
    "reviews": 133,
    "tag": "",
    "description": "Classic vanilla sponge topped with a tall swirl of vanilla buttercream and colourful sprinkles.",
    "ingredients": "Flour, Butter, Sugar, Eggs, Vanilla Extract, Milk, Buttercream Frosting, Sprinkles",
    "calories": 310,
    "isEggless": false,
    "servingSize": "1 cupcake (75g)",
    "deliveryTime": "30–40 mins",
    "available": true,
  },
  {
    "name": "Red Velvet Cupcake",
    "price": 240,
    "category": "Cupcakes",
    "image": "https://images.unsplash.com/photo-1614707267537-b85aaf00c4b7?w=400&q=80",
    "rating": 4.8,
    "reviews": 201,
    "tag": "Bestseller",
    "description": "Velvety red cocoa sponge crowned with luscious cream cheese frosting. A fan favourite.",
    "ingredients": "Flour, Butter, Sugar, Eggs, Cocoa, Buttermilk, Red Colouring, Cream Cheese Frosting",
    "calories": 340,
    "isEggless": false,
    "servingSize": "1 cupcake (80g)",
    "deliveryTime": "30–40 mins",
    "available": true,
  },
  {
    "name": "Lemon Zest Cupcake",
    "price": 220,
    "category": "Cupcakes",
    "image": "https://images.unsplash.com/photo-1599785209707-a456fc1337bb?w=400&q=80",
    "rating": 4.6,
    "reviews": 115,
    "tag": "New",
    "description": "Zingy lemon sponge with a hidden curd centre, topped with whipped lemon buttercream.",
    "ingredients": "Flour, Butter, Sugar, Eggs, Lemon Zest, Lemon Curd, Lemon Buttercream, Milk",
    "calories": 300,
    "isEggless": false,
    "servingSize": "1 cupcake (75g)",
    "deliveryTime": "30–40 mins",
    "available": true,
  },
  {
    "name": "Cappuccino",
    "price": 220,
    "category": "Coffee",
    "image": "https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=400&q=80",
    "rating": 4.7,
    "reviews": 289,
    "tag": "Bestseller",
    "description": "One part espresso, one part steamed milk, one part velvety microfoam. Balanced and beautiful.",
    "ingredients": "Single-Origin Espresso Blend, Whole Milk, Microfoam",
    "calories": 80,
    "isEggless": true,
    "servingSize": "180ml",
    "deliveryTime": "20–30 mins",
    "available": true,
  },
  {
    "name": "Caramel Latte",
    "price": 260,
    "category": "Coffee",
    "image": "https://images.unsplash.com/photo-1561882468-9110e03e0f78?w=400&q=80",
    "rating": 4.8,
    "reviews": 234,
    "tag": "Premium",
    "description": "Double espresso with silky steamed milk and house-made salted caramel sauce, finished with sea salt.",
    "ingredients": "Double Espresso, Whole Milk, House-made Salted Caramel Sauce, Sea Salt Flakes",
    "calories": 210,
    "isEggless": true,
    "servingSize": "300ml",
    "deliveryTime": "20–30 mins",
    "available": true,
  },
  {
    "name": "Cold Brew",
    "price": 280,
    "category": "Coffee",
    "image": "https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=400&q=80",
    "rating": 4.6,
    "reviews": 178,
    "tag": "New",
    "description": "Steeped for 18 hours in cold water, our cold brew is smooth, low-acid and naturally sweet.",
    "ingredients": "Single-Origin Coffee, Filtered Cold Water, Ice",
    "calories": 10,
    "isEggless": true,
    "servingSize": "350ml",
    "deliveryTime": "20–30 mins",
    "available": true,
  },
  {
    "name": "Espresso Shot",
    "price": 170,
    "category": "Coffee",
    "image": "https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?w=400&q=80",
    "rating": 4.5,
    "reviews": 143,
    "tag": "",
    "description": "A concentrated shot of our single-origin blend — bold, aromatic and full of character.",
    "ingredients": "Single-Origin Espresso Blend, Filtered Water",
    "calories": 5,
    "isEggless": true,
    "servingSize": "30ml",
    "deliveryTime": "15–25 mins",
    "available": true,
  },
  {
    "name": "Club Sandwich",
    "price": 340,
    "category": "Sandwiches",
    "image": "https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=400&q=80",
    "rating": 4.6,
    "reviews": 167,
    "tag": "Bestseller",
    "description": "Triple-decker with grilled chicken, crispy bacon, lettuce, tomato, and herb mayo on toasted bread.",
    "ingredients": "Sourdough Bread, Grilled Chicken, Bacon, Lettuce, Tomato, Herb Mayo, Cheese",
    "calories": 480,
    "isEggless": false,
    "servingSize": "1 sandwich (220g)",
    "deliveryTime": "30–45 mins",
    "available": true,
  },
  {
    "name": "Grilled Veggie Panini",
    "price": 300,
    "category": "Sandwiches",
    "image": "https://images.unsplash.com/photo-1509722747041-616f39b57569?w=400&q=80",
    "rating": 4.5,
    "reviews": 112,
    "tag": "",
    "description": "Zucchini, peppers, portobello and sun-dried tomatoes pressed in a rosemary focaccia with pesto.",
    "ingredients": "Focaccia, Zucchini, Bell Peppers, Portobello Mushroom, Sun-dried Tomatoes, Basil Pesto, Mozzarella",
    "calories": 390,
    "isEggless": true,
    "servingSize": "1 panini (200g)",
    "deliveryTime": "30–45 mins",
    "available": true,
  },
  {
    "name": "Chicken Pesto Sub",
    "price": 380,
    "category": "Sandwiches",
    "image": "https://images.unsplash.com/photo-1553909489-cd47e0907980?w=400&q=80",
    "rating": 4.7,
    "reviews": 198,
    "tag": "New",
    "description": "Tender grilled chicken, fresh basil pesto, mozzarella and rocket in a crusty ciabatta roll.",
    "ingredients": "Ciabatta, Grilled Chicken, Basil Pesto, Fresh Mozzarella, Rocket Leaves, Olive Oil",
    "calories": 450,
    "isEggless": false,
    "servingSize": "1 sub (230g)",
    "deliveryTime": "30–45 mins",
    "available": true,
  },
  {
    "name": "Belgian Truffle Box",
    "price": 580,
    "category": "Chocolates",
    "image": "https://images.unsplash.com/photo-1549007953-2f2dc0b24019?w=400&q=80",
    "rating": 4.9,
    "reviews": 301,
    "tag": "Premium",
    "description": "A curated box of 12 hand-rolled Belgian truffles in dark, milk and white chocolate — the perfect gift.",
    "ingredients": "Belgian Chocolate (Dark/Milk/White), Fresh Cream, Butter, Cocoa Powder, Various Fillings",
    "calories": 80,
    "isEggless": true,
    "servingSize": "1 box (12 truffles)",
    "deliveryTime": "45–60 mins",
    "available": true,
  },
  {
    "name": "Dark Chocolate Bar",
    "price": 320,
    "category": "Chocolates",
    "image": "https://images.unsplash.com/photo-1481391319762-47dff72954d9?w=400&q=80",
    "rating": 4.7,
    "reviews": 145,
    "tag": "",
    "description": "72% single-origin dark chocolate with subtle notes of dried cherry and toasted hazelnuts.",
    "ingredients": "Single-Origin Cocoa, Cocoa Butter, Sugar, Dried Cherries, Toasted Hazelnuts",
    "calories": 170,
    "isEggless": true,
    "servingSize": "1 bar (50g)",
    "deliveryTime": "45–60 mins",
    "available": true,
  },
  {
    "name": "Hazelnut Pralines",
    "price": 480,
    "category": "Chocolates",
    "image": "https://images.unsplash.com/photo-1582176604856-e824b4736522?w=400&q=80",
    "rating": 4.8,
    "reviews": 212,
    "tag": "Bestseller",
    "description": "Belgian milk chocolate shells filled with smooth hazelnut praline and a whole toasted hazelnut.",
    "ingredients": "Belgian Milk Chocolate, Hazelnut Praline, Toasted Whole Hazelnuts, Fresh Cream",
    "calories": 90,
    "isEggless": true,
    "servingSize": "3 pralines (45g)",
    "deliveryTime": "45–60 mins",
    "available": true,
  },
  {
    "name": "Assorted Macarons (6)",
    "price": 440,
    "category": "Macarons",
    "image": "https://images.unsplash.com/photo-1558326567-98ae2405596b?w=400&q=80",
    "rating": 4.9,
    "reviews": 277,
    "tag": "Premium",
    "description": "Six chef-selected macarons: raspberry, pistachio, salted caramel, vanilla, lemon and rose.",
    "ingredients": "Almond Flour, Egg Whites, Sugar, Cream, Butter, Various Natural Flavourings & Fillings",
    "calories": 90,
    "isEggless": false,
    "servingSize": "6 macarons (90g)",
    "deliveryTime": "45–60 mins",
    "available": true,
  },
  {
    "name": "Rose Macaron",
    "price": 260,
    "category": "Macarons",
    "image": "https://images.unsplash.com/photo-1569864358642-9d1684040f43?w=400&q=80",
    "rating": 4.8,
    "reviews": 189,
    "tag": "Bestseller",
    "description": "Delicate almond shells tinted blush pink, filled with a fragrant rose lychee ganache.",
    "ingredients": "Almond Flour, Egg Whites, Sugar, Rose Water, Lychee Purée, White Chocolate, Cream",
    "calories": 85,
    "isEggless": false,
    "servingSize": "2 macarons (30g)",
    "deliveryTime": "45–60 mins",
    "available": true,
  },
  {
    "name": "Pistachio Macaron",
    "price": 280,
    "category": "Macarons",
    "image": "https://images.unsplash.com/photo-1610450949065-1f2841536c88?w=400&q=80",
    "rating": 4.7,
    "reviews": 134,
    "tag": "New",
    "description": "Vibrant green shells made with Sicilian pistachios, filled with a rich pistachio buttercream.",
    "ingredients": "Almond Flour, Sicilian Pistachio Paste, Egg Whites, Sugar, Butter, Cream",
    "calories": 95,
    "isEggless": false,
    "servingSize": "2 macarons (30g)",
    "deliveryTime": "45–60 mins",
    "available": true,
  },
  {
    "name": "NY Baked Cheesecake",
    "price": 1320,
    "category": "Cheesecakes",
    "image": "https://images.unsplash.com/photo-1567171466295-4afa63d45416?w=400&q=80",
    "rating": 4.9,
    "reviews": 244,
    "tag": "Premium",
    "description": "Authentic New York-style baked cheesecake — dense, creamy and perfectly set with a buttery graham base.",
    "ingredients": "Cream Cheese, Sugar, Eggs, Sour Cream, Vanilla, Graham Crackers, Butter",
    "calories": 400,
    "isEggless": false,
    "servingSize": "1 slice (110g)",
    "deliveryTime": "45–60 mins",
    "available": true,
  },
  {
    "name": "Mango Cheesecake",
    "price": 1280,
    "category": "Cheesecakes",
    "image": "https://images.unsplash.com/photo-1565958011703-44f9829ba187?w=400&q=80",
    "rating": 4.8,
    "reviews": 188,
    "tag": "New",
    "description": "No-bake cheesecake with a mango jelly layer on top, made from Alphonso mango purée.",
    "ingredients": "Cream Cheese, Sugar, Mango Purée (Alphonso), Gelatine, Digestive Biscuits, Butter",
    "calories": 370,
    "isEggless": true,
    "servingSize": "1 slice (110g)",
    "deliveryTime": "45–60 mins",
    "available": true,
  },
  {
    "name": "Blueberry Cheesecake",
    "price": 1300,
    "category": "Cheesecakes",
    "image": "https://images.unsplash.com/photo-1533134242443-d4fd215305ad?w=400&q=80",
    "rating": 4.9,
    "reviews": 156,
    "tag": "Bestseller",
    "description": "Creamy baked cheesecake with a generous blueberry compote topping. A crowd-pleaser.",
    "ingredients": "Cream Cheese, Sugar, Eggs, Sour Cream, Fresh Blueberries, Graham Crackers, Butter",
    "calories": 390,
    "isEggless": false,
    "servingSize": "1 slice (115g)",
    "deliveryTime": "45–60 mins",
    "available": true,
  },
  {
    "name": "Mango Smoothie",
    "price": 230,
    "category": "Beverages",
    "image": "https://images.unsplash.com/photo-1546173159-315724a31696?w=400&q=80",
    "rating": 4.6,
    "reviews": 143,
    "tag": "New",
    "description": "Thick, chilled Alphonso mango purée blended with yoghurt and a touch of cardamom.",
    "ingredients": "Alphonso Mango Purée, Whole Milk Yoghurt, Sugar, Cardamom, Ice",
    "calories": 190,
    "isEggless": true,
    "servingSize": "300ml",
    "deliveryTime": "20–30 mins",
    "available": true,
  },
  {
    "name": "Iced Matcha Latte",
    "price": 270,
    "category": "Beverages",
    "image": "https://images.unsplash.com/photo-1536256263959-770b48d82b0a?w=400&q=80",
    "rating": 4.7,
    "reviews": 198,
    "tag": "Bestseller",
    "description": "Ceremonial-grade matcha whisked with oat milk and poured over ice for a smooth, earthy refresher.",
    "ingredients": "Ceremonial-Grade Matcha, Oat Milk, Cane Sugar Syrup, Ice",
    "calories": 130,
    "isEggless": true,
    "servingSize": "350ml",
    "deliveryTime": "20–30 mins",
    "available": true,
  },
  {
    "name": "Hot Chocolate",
    "price": 250,
    "category": "Beverages",
    "image": "https://images.unsplash.com/photo-1542990253-0d0f5be5f0ed?w=400&q=80",
    "rating": 4.8,
    "reviews": 222,
    "tag": "Premium",
    "description": "Steamed whole milk with rich 60% cocoa, topped with hand-whipped cream and cocoa dust.",
    "ingredients": "Whole Milk, 60% Cocoa Powder, Sugar, Hand-Whipped Cream, Cocoa Dust",
    "calories": 250,
    "isEggless": true,
    "servingSize": "300ml",
    "deliveryTime": "20–30 mins",
    "available": true,
  },
  {
    "name": "Sourdough Loaf",
    "price": 420,
    "category": "Breads",
    "image": "https://images.unsplash.com/photo-1585478259715-876acc5be8eb?w=400&q=80",
    "rating": 4.7,
    "reviews": 134,
    "tag": "",
    "description": "Long-fermented sourdough with a shattering crust and tangy, open crumb. Baked in a cast iron.",
    "ingredients": "Bread Flour, Sourdough Starter, Water, Sea Salt",
    "calories": 240,
    "isEggless": true,
    "servingSize": "2 slices (100g)",
    "deliveryTime": "45–60 mins",
    "available": true,
  },
  {
    "name": "Multigrain Bread",
    "price": 360,
    "category": "Breads",
    "image": "https://images.unsplash.com/photo-1509440159596-0249088772ff?w=400&q=80",
    "rating": 4.5,
    "reviews": 98,
    "tag": "",
    "description": "Seven-seed blend with whole wheat, oats, flaxseed and sunflower seeds for a nutty, hearty loaf.",
    "ingredients": "Whole Wheat Flour, Oats, Flaxseed, Sunflower Seeds, Pumpkin Seeds, Sesame, Yeast",
    "calories": 220,
    "isEggless": true,
    "servingSize": "2 slices (100g)",
    "deliveryTime": "45–60 mins",
    "available": true,
  },
  {
    "name": "Garlic Herb Focaccia",
    "price": 390,
    "category": "Breads",
    "image": "https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=400&q=80",
    "rating": 4.8,
    "reviews": 167,
    "tag": "New",
    "description": "Dimpled, olive-oil-drenched focaccia with roasted garlic, fresh rosemary and flaky sea salt.",
    "ingredients": "Flour, Olive Oil, Roasted Garlic, Fresh Rosemary, Sea Salt, Yeast, Water",
    "calories": 260,
    "isEggless": true,
    "servingSize": "1 portion (120g)",
    "deliveryTime": "45–60 mins",
    "available": true,
  },
];

final List<Map<String, dynamic>> customerReviews = [
  {"name": "Aanya Sharma", "avatar": "A", "avatarColor": Color(0xFFC8938A), "rating": 5, "comment": "The cookies are absolutely divine! Crispy outside and gooey inside. Will order again!", "date": "2 days ago", "item": "Classic Chocolate Chip"},
  {"name": "Rohan Mehta", "avatar": "R", "avatarColor": Color(0xFF9E8080), "rating": 5, "comment": "The cake looked beautiful and tasted even better. Perfect for our anniversary!", "date": "4 days ago", "item": "Vanilla Dream Cake"},
  {"name": "Priya Nair", "avatar": "P", "avatarColor": Color(0xFF6B5050), "rating": 4, "comment": "Loved the packaging and the freshness. The brownies were fudgy perfection.", "date": "1 week ago", "item": "Chocolate Brownie"},
  {"name": "Kabir Singh", "avatar": "K", "avatarColor": Color(0xFF8B6060), "rating": 5, "comment": "Best cappuccino I've had outside a café! Rich, creamy and perfectly balanced.", "date": "3 days ago", "item": "Cappuccino"},
  {"name": "Meera Iyer", "avatar": "M", "avatarColor": Color(0xFFBFA8A8), "rating": 5, "comment": "The macarons are straight out of Paris! Delicate shells and perfect filling.", "date": "5 days ago", "item": "Assorted Macarons (6)"},
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

// ─── Utilities ────────────────────────────────────────────────────────────────
PageRouteBuilder _fadeRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, anim, __, child) => FadeTransition(opacity: anim, child: child),
    transitionDuration: const Duration(milliseconds: 350),
  );
}

SnackBar _cartSnackBar(String name, BuildContext context) {
  return SnackBar(
    content: Row(children: [
      const Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
      const SizedBox(width: 8),
      Expanded(child: Text("$name added to cart!", style: GoogleFonts.dmSans(fontWeight: FontWeight.w600, color: Colors.white))),
    ]),
    backgroundColor: kRoseDark,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    margin: const EdgeInsets.fromLTRB(16, 0, 16, 90),
    duration: const Duration(seconds: 2),
  );
}

// ─── Login Page ───────────────────────────────────────────────────────────────
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  bool _loading = false, _obscure = true;
  String? _error;
  final _emailCtrl = TextEditingController();
  final _pwdCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _ctrl.forward();
  }

  @override
  void dispose() { _ctrl.dispose(); _emailCtrl.dispose(); _pwdCtrl.dispose(); super.dispose(); }

  void _login() async {
    setState(() => _error = null);
    final email = _emailCtrl.text.trim();
    final pwd = _pwdCtrl.text.trim();
    if (email.isEmpty || pwd.isEmpty) { setState(() => _error = "Please enter email and password."); return; }
    if (!email.contains('@')) { setState(() => _error = "Please enter a valid email."); return; }
    if (!UserStore.exists(email)) { setState(() => _error = "Account not found. Please sign up."); return; }
    if (!UserStore.login(email: email, password: pwd)) { setState(() => _error = "Incorrect password."); return; }
    setState(() => _loading = true);
    _loggedInEmail = email.trim().toLowerCase();
    SheetsService.logLogin(email: email);
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    Navigator.pushReplacement(context, _fadeRoute(const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(decoration: const BoxDecoration(gradient: LinearGradient(
          colors: [Color(0xFF6B4545), Color(0xFF8B6060), Color(0xFFC8938A), Color(0xFFDDB8B0)],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ))),
        SafeArea(child: Center(child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: FadeTransition(opacity: _fade, child: Column(children: [
            const SizedBox(height: 40),
            Container(width: 88, height: 88,
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), shape: BoxShape.circle,
                border: Border.all(color: kGold.withOpacity(0.6), width: 2)),
              child: const Center(child: Text("🍪", style: TextStyle(fontSize: 44)))),
            const SizedBox(height: 14),
            Text("Cookie Cloud", style: GoogleFonts.cormorantGaramond(fontSize: 38, fontWeight: FontWeight.w600, color: Colors.white, letterSpacing: 1.5)),
            const SizedBox(height: 5),
            Text("✦  Baked with love, delivered with care  ✦", style: GoogleFonts.dmSans(color: kGoldLight, fontSize: 12)),
            const SizedBox(height: 36),
            Container(padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(color: kSurface, borderRadius: BorderRadius.circular(28),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.18), blurRadius: 48, offset: const Offset(0, 20))]),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("Welcome back 👋", style: GoogleFonts.cormorantGaramond(fontSize: 26, fontWeight: FontWeight.w700, color: kTaupeDark)),
                Text("Sign in to continue", style: GoogleFonts.dmSans(color: kTaupeLight, fontSize: 13.5)),
                const SizedBox(height: 24),
                if (_error != null) ...[
                  Container(padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.red.withOpacity(0.08), borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red.withOpacity(0.25))),
                    child: Row(children: [const Icon(Icons.error_outline_rounded, color: Colors.red, size: 18),
                      const SizedBox(width: 8), Expanded(child: Text(_error!, style: GoogleFonts.dmSans(color: Colors.red, fontSize: 13)))])),
                  const SizedBox(height: 16),
                ],
                _field(Icons.email_outlined, "Email address", ctrl: _emailCtrl),
                const SizedBox(height: 14),
                TextField(controller: _pwdCtrl, obscureText: _obscure, style: GoogleFonts.dmSans(color: kTaupeDark),
                  decoration: InputDecoration(hintText: "Password",
                    hintStyle: GoogleFonts.dmSans(color: kTaupeLight.withOpacity(0.7), fontSize: 14),
                    prefixIcon: const Icon(Icons.lock_outline_rounded, color: kRoseLight, size: 20),
                    suffixIcon: GestureDetector(onTap: () => setState(() => _obscure = !_obscure),
                      child: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: kTaupeLight, size: 20)),
                    filled: true, fillColor: kIvory, contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: kRoseMid, width: 1.5)))),
                const SizedBox(height: 24),
                SizedBox(width: double.infinity, height: 54, child: ElevatedButton(
                  onPressed: _loading ? null : _login,
                  style: ElevatedButton.styleFrom(backgroundColor: kRoseDark, foregroundColor: Colors.white, elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                  child: _loading
                      ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                      : Text("Sign In", style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w700)))),
                const SizedBox(height: 18),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Don't have an account? ", style: GoogleFonts.dmSans(color: kTaupeLight, fontSize: 14)),
                  GestureDetector(onTap: () => Navigator.push(context, _fadeRoute(const SignUpPage())),
                    child: Text("Sign up", style: GoogleFonts.dmSans(color: kRoseDark, fontWeight: FontWeight.w700, fontSize: 14,
                      decoration: TextDecoration.underline, decorationColor: kRoseDark))),
                ]),
              ])),
            const SizedBox(height: 40),
          ])),
        ))),
      ]),
    );
  }

  Widget _field(IconData icon, String hint, {TextEditingController? ctrl}) {
    return TextField(controller: ctrl, style: GoogleFonts.dmSans(color: kTaupeDark),
      decoration: InputDecoration(hintText: hint, hintStyle: GoogleFonts.dmSans(color: kTaupeLight.withOpacity(0.7), fontSize: 14),
        prefixIcon: Icon(icon, color: kRoseLight, size: 20), filled: true, fillColor: kIvory,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: kRoseMid, width: 1.5))));
  }
}

// ─── Sign Up Page ─────────────────────────────────────────────────────────────
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  bool _loading = false, _obscurePwd = true, _obscureConfirm = true;
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _pwdCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  DateTime? _dob;
  String? _error;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _ctrl.forward();
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  Future<void> _pickDob() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context, initialDate: _dob ?? DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(1920), lastDate: DateTime(now.year - 5, now.month, now.day),
      builder: (ctx, child) => Theme(data: Theme.of(ctx).copyWith(
        colorScheme: const ColorScheme.light(primary: kRoseDark, onPrimary: Colors.white, surface: kSurface, onSurface: kTaupeDark)), child: child!));
    if (picked != null) setState(() => _dob = picked);
  }

  String get _dobStr => _dob == null ? '' : '${_dob!.day.toString().padLeft(2,'0')} / ${_dob!.month.toString().padLeft(2,'0')} / ${_dob!.year}';

  void _signUp() async {
    setState(() => _error = null);
    final name = _nameCtrl.text.trim(); final email = _emailCtrl.text.trim();
    final pwd = _pwdCtrl.text.trim(); final confirm = _confirmCtrl.text.trim(); final phone = _phoneCtrl.text.trim();
    if (name.isEmpty || email.isEmpty || pwd.isEmpty || confirm.isEmpty || phone.isEmpty) { setState(() => _error = "Please fill in all fields."); return; }
    if (!email.contains('@')) { setState(() => _error = "Enter a valid email address."); return; }
    if (pwd.length < 6) { setState(() => _error = "Password must be at least 6 characters."); return; }
    if (pwd != confirm) { setState(() => _error = "Passwords do not match."); return; }
    if (phone.length < 10) { setState(() => _error = "Enter a valid phone number."); return; }
    if (_dob == null) { setState(() => _error = "Please select your date of birth."); return; }
    if (UserStore.exists(email)) { setState(() => _error = "Account already exists. Please sign in."); return; }
    setState(() => _loading = true);
    UserStore.register(name: name, email: email, phone: phone, dob: _dobStr, password: pwd);
    SheetsService.logSignUp(name: name, email: email, phone: phone, dob: _dobStr);
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    _loggedInEmail = email.trim().toLowerCase();
    Navigator.pushAndRemoveUntil(context, _fadeRoute(const HomeScreen()), (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Stack(children: [
      Container(decoration: const BoxDecoration(gradient: LinearGradient(
        colors: [Color(0xFF6B4545), Color(0xFF8B6060), Color(0xFFC8938A), Color(0xFFDDB8B0)],
        begin: Alignment.topLeft, end: Alignment.bottomRight))),
      SafeArea(child: FadeTransition(opacity: _fade, child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(children: [
          const SizedBox(height: 8),
          Container(padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(color: kSurface, borderRadius: BorderRadius.circular(28),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.18), blurRadius: 48, offset: const Offset(0, 20))]),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Create Account 🎉", style: GoogleFonts.cormorantGaramond(fontSize: 24, fontWeight: FontWeight.w700, color: kTaupeDark)),
              Text("Join Cookie Cloud today", style: GoogleFonts.dmSans(color: kTaupeLight, fontSize: 13)),
              const SizedBox(height: 22),
              if (_error != null) ...[
                Container(padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.red.withOpacity(0.08), borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red.withOpacity(0.25))),
                  child: Row(children: [const Icon(Icons.error_outline_rounded, color: Colors.red, size: 18),
                    const SizedBox(width: 8), Expanded(child: Text(_error!, style: GoogleFonts.dmSans(color: Colors.red, fontSize: 13)))])),
                const SizedBox(height: 14),
              ],
              _suField(Icons.person_outline_rounded, "Full Name", _nameCtrl),
              const SizedBox(height: 12),
              _suField(Icons.email_outlined, "Email Address", _emailCtrl, type: TextInputType.emailAddress),
              const SizedBox(height: 12),
              _suField(Icons.phone_outlined, "Phone Number", _phoneCtrl, type: TextInputType.phone),
              const SizedBox(height: 12),
              GestureDetector(onTap: _pickDob, child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                decoration: BoxDecoration(color: kIvory, borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: _dob != null ? kRoseMid.withOpacity(0.6) : Colors.transparent, width: 1.5)),
                child: Row(children: [
                  const Icon(Icons.cake_outlined, color: kRoseLight, size: 20), const SizedBox(width: 12),
                  Expanded(child: Text(_dob == null ? "Date of Birth" : _dobStr,
                    style: GoogleFonts.dmSans(color: _dob == null ? kTaupeLight.withOpacity(0.7) : kTaupeDark, fontSize: 14))),
                  const Icon(Icons.calendar_today_outlined, color: kTaupeLight, size: 18),
                ]))),
              const SizedBox(height: 12),
              _suPwdField("Password", _pwdCtrl, _obscurePwd, () => setState(() => _obscurePwd = !_obscurePwd)),
              const SizedBox(height: 12),
              _suPwdField("Confirm Password", _confirmCtrl, _obscureConfirm, () => setState(() => _obscureConfirm = !_obscureConfirm)),
              const SizedBox(height: 24),
              SizedBox(width: double.infinity, height: 54, child: ElevatedButton(
                onPressed: _loading ? null : _signUp,
                style: ElevatedButton.styleFrom(backgroundColor: kRoseDark, foregroundColor: Colors.white, elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                child: _loading
                    ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                    : Text("Create Account", style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w700)))),
              const SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Already have an account? ", style: GoogleFonts.dmSans(color: kTaupeLight, fontSize: 13.5)),
                GestureDetector(onTap: () => Navigator.pop(context),
                  child: Text("Sign in", style: GoogleFonts.dmSans(color: kRoseDark, fontWeight: FontWeight.w700, fontSize: 13.5,
                    decoration: TextDecoration.underline, decorationColor: kRoseDark))),
              ]),
            ])),
          const SizedBox(height: 40),
        ])))),
    ]));
  }

  Widget _suField(IconData icon, String hint, TextEditingController ctrl, {TextInputType type = TextInputType.text}) {
    return TextField(controller: ctrl, keyboardType: type, style: GoogleFonts.dmSans(color: kTaupeDark),
      decoration: InputDecoration(hintText: hint, hintStyle: GoogleFonts.dmSans(color: kTaupeLight.withOpacity(0.7), fontSize: 14),
        prefixIcon: Icon(icon, color: kRoseLight, size: 20), filled: true, fillColor: kIvory,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: kRoseMid, width: 1.5))));
  }

  Widget _suPwdField(String hint, TextEditingController ctrl, bool obscure, VoidCallback toggle) {
    return TextField(controller: ctrl, obscureText: obscure, style: GoogleFonts.dmSans(color: kTaupeDark),
      decoration: InputDecoration(hintText: hint, hintStyle: GoogleFonts.dmSans(color: kTaupeLight.withOpacity(0.7), fontSize: 14),
        prefixIcon: const Icon(Icons.lock_outline_rounded, color: kRoseLight, size: 20),
        suffixIcon: GestureDetector(onTap: toggle, child: Icon(obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: kTaupeLight, size: 20)),
        filled: true, fillColor: kIvory, contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: kRoseMid, width: 1.5))));
  }
}

// ─── Home Shell ───────────────────────────────────────────────────────────────
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _idx = 0;
  void _nav(int i) => setState(() => _idx = i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kIvory,
      body: Stack(children: [
        IndexedStack(index: _idx, children: [
          HomeContent(onNavigate: _nav),
          const ExploreScreen(),
          CartScreen(onNavigate: _nav),
          const OrderHistoryScreen(),
          ProfileScreen(onNavigate: _nav),
        ]),
        const Positioned(right: 22, bottom: 95, child: PixiChatbot()),
      ]),
      bottomNavigationBar: _FloatingNavBar(selectedIndex: _idx, onTap: _nav),
    );
  }
}

// ─── Floating Nav Bar ─────────────────────────────────────────────────────────
class _FloatingNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  const _FloatingNavBar({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final icons = [
      [Icons.home_rounded, Icons.home_outlined],
      [Icons.explore_rounded, Icons.explore_outlined],
      [Icons.shopping_bag_rounded, Icons.shopping_bag_outlined],
      [Icons.receipt_long_rounded, Icons.receipt_long_outlined],
      [Icons.person_rounded, Icons.person_outline_rounded],
    ];
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      height: 68,
      decoration: BoxDecoration(color: kRoseDark, borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: kRoseDark.withOpacity(0.4), blurRadius: 24, offset: const Offset(0, 8))]),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: List.generate(5, (i) {
        final isSelected = i == selectedIndex;
        final isCart = i == 2;
        return GestureDetector(onTap: () => onTap(i), behavior: HitTestBehavior.opaque,
          child: AnimatedContainer(duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(color: isSelected ? Colors.white.withOpacity(0.18) : Colors.transparent, borderRadius: BorderRadius.circular(16)),
            child: isCart
                ? ValueListenableBuilder<List<Map<String, dynamic>>>(valueListenable: cartNotifier, builder: (_, cart, __) =>
                    Stack(clipBehavior: Clip.none, children: [
                      Icon(isSelected ? icons[i][0] : icons[i][1], color: isSelected ? Colors.white : Colors.white.withOpacity(0.45), size: 26),
                      if (cart.isNotEmpty) Positioned(right: -4, top: -4, child: Container(width: 16, height: 16,
                        decoration: const BoxDecoration(color: kGold, shape: BoxShape.circle),
                        child: Center(child: Text("${cart.length}", style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: kTaupeDark))))),
                    ]))
                : Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(isSelected ? icons[i][0] : icons[i][1], color: isSelected ? Colors.white : Colors.white.withOpacity(0.45), size: 24),
                    if (isSelected) ...[const SizedBox(height: 3), Container(width: 4, height: 4, decoration: const BoxDecoration(color: kGold, shape: BoxShape.circle))],
                  ])));
      })),
    );
  }
}

// ─── Pixi Chatbot ─────────────────────────────────────────────────────────────
class _PixiMsg { final String text; final bool isPixi; const _PixiMsg({required this.text, required this.isPixi}); }

class PixiChatbot extends StatefulWidget {
  const PixiChatbot({super.key});
  @override
  State<PixiChatbot> createState() => _PixiChatbotState();
}

class _PixiChatbotState extends State<PixiChatbot> with SingleTickerProviderStateMixin {
  bool _open = false;
  bool _loading = false;
  final _inputCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();
  final _focus = FocusNode();
  late AnimationController _animCtrl;
  late Animation<double> _scale, _fadeAnim;
  final List<_PixiMsg> _msgs = [const _PixiMsg(text: "Hi! I'm Pixi 🍪 Your Cookie Cloud assistant. Ask me about our menu, offers, or anything sweet!", isPixi: true)];
  final List<Map<String, String>> _history = [];

  static const _sys = '''You are Pixi, the friendly Cookie Cloud bakery assistant. Cookie Cloud is a premium Indian bakery. Prices in ₹. Reply in 2-4 sentences, warm, emoji-rich. Help with menu, delivery (free above ₹500), coupons (SWEET10=10%, CLOUD20=20%). Contact: support@cookiecloud.in''';

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 280));
    _scale = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutBack);
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
  }

  @override
  void dispose() { _animCtrl.dispose(); _inputCtrl.dispose(); _scrollCtrl.dispose(); _focus.dispose(); super.dispose(); }

  // Smart keyword fallback — works without API key
  String _fallback(String msg) {
    final m = msg.toLowerCase();
    if (m.contains('cookie') || m.contains('cookies')) return "Our bestselling Classic Chocolate Chip Cookie (₹220) is baked fresh daily! 🍪 We also have Red Velvet, Double Choco, and Oatmeal Raisin. Which one sounds good?";
    if (m.contains('cake')) return "Our cakes are showstoppers! 🎂 The Vanilla Dream Cake (₹1450) and Dark Chocolate Cake (₹1380) are customer favorites. Perfect for celebrations!";
    if (m.contains('brownie')) return "Our fudgy Chocolate Brownie (₹280) is a bestseller! 🍫 We also have Walnut Fudge and Cream Cheese Brownies. Dense, rich and utterly indulgent!";
    if (m.contains('deliver') || m.contains('free')) return "Delivery is FREE on orders above ₹500! 🚚 For smaller orders, there's a small ₹49 fee. We deliver in 30–60 mins!";
    if (m.contains('coupon') || m.contains('discount') || m.contains('offer')) return "We have two active coupons! 🎉 Use SWEET10 for 10% off or CLOUD20 for 20% off. Apply them in your cart!";
    if (m.contains('coffee')) return "Our coffee is crafted with love! ☕ Try the Caramel Latte (₹260) or 18-hour Cold Brew (₹280). Cappuccino is our bestseller!";
    if (m.contains('macaron')) return "Our macarons are divine! 🫶 Try the Assorted Box of 6 (₹440) — rose, pistachio, raspberry & more. Rose Macaron is the crowd favorite!";
    if (m.contains('cheesecake')) return "Cheesecake lovers, rejoice! 🍮 Our NY Baked Cheesecake (₹1320) is creamy perfection. Mango Cheesecake with Alphonso purée is also incredible!";
    if (m.contains('hello') || m.contains('hi') || m.contains('hey')) return "Hello there! 👋 Welcome to Cookie Cloud! I'm Pixi, your sweet assistant. What can I help you with today? 🍪";
    if (m.contains('price') || m.contains('cost') || m.contains('menu')) return "Our prices start from ₹150 for donuts to ₹1450 for premium cakes! 💰 All items are freshly baked. Check the menu for full pricing!";
    if (m.contains('hour') || m.contains('open') || m.contains('timing')) return "We're open Monday to Saturday, 8 AM – 10 PM, and Sundays 9 AM – 8 PM! 🕐 Fresh bakes are out of the oven every morning!";
    if (m.contains('eggless') || m.contains('veg')) return "Great news! 🌱 Many items are eggless — coffees, beverages, chocolates, breads, matcha latte. Check the 🌱 badge on item detail pages!";
    if (m.contains('gift')) return "We have a Gift option at checkout! 🎁 Add a personal message to make your order extra special. Perfect for birthdays and anniversaries!";
    if (m.contains('contact') || m.contains('support') || m.contains('help')) return "Need help? 📞 8882626610, 📧 support@cookiecloud.in, or Instagram @cookiecloudofficial. We're here!";
    if (m.contains('donut') || m.contains('doughnut')) return "Our donuts are freshly glazed! 🍩 Try the Chocolate Donut (₹160), Strawberry Donut (₹175), or the fun Sprinkle Donut (₹185)!";
    if (m.contains('sandwich') || m.contains('food')) return "Beyond sweets, we serve sandwiches! 🥪 Our Club Sandwich (₹340) and Chicken Pesto Sub (₹380) are absolute hits!";
    return "That's a great question! 🍪 I'm here to help with our menu, prices, delivery, and more. What would you like to know about Cookie Cloud?";
  }

  Future<String> _callApi(String userMsg) async {
    // Use fallback if API key is not configured
    if (AppConfig.anthropicApiKey == 'YOUR_ANTHROPIC_API_KEY') {
      await Future.delayed(const Duration(milliseconds: 600));
      return _fallback(userMsg);
    }
    _history.add({'role': 'user', 'content': userMsg});
    try {
      final resp = await http.post(
        Uri.parse('https://api.anthropic.com/v1/messages'),
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': AppConfig.anthropicApiKey,
          'anthropic-version': '2023-06-01',
        },
        body: jsonEncode({'model': 'claude-sonnet-4-20250514', 'max_tokens': 300, 'system': _sys, 'messages': _history}),
      ).timeout(const Duration(seconds: 20));

      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body);
        final text = (data['content'] as List).firstWhere((b) => b['type'] == 'text', orElse: () => {'text': ''})['text'] as String;
        final reply = text.isNotEmpty ? text : _fallback(userMsg);
        _history.add({'role': 'assistant', 'content': reply});
        return reply;
      } else {
        if (_history.isNotEmpty && _history.last['role'] == 'user') _history.removeLast();
        return "Sorry, something went wrong. Please try again. 🙏";
      }
    } catch (_) {
      if (_history.isNotEmpty && _history.last['role'] == 'user') _history.removeLast();
      return "Sorry, something went wrong. Please try again. 🙏";
    }
  }

  void _toggle() {
    setState(() => _open = !_open);
    if (_open) { _animCtrl.forward(); Future.delayed(const Duration(milliseconds: 300), () { if (mounted && _open) _focus.requestFocus(); }); }
    else { _animCtrl.reverse(); _focus.unfocus(); }
  }

  void _send() async {
    final text = _inputCtrl.text.trim();
    if (text.isEmpty || _loading) return;
    setState(() { _msgs.add(_PixiMsg(text: text, isPixi: false)); _loading = true; });
    _inputCtrl.clear();
    _scrollBottom();
    final reply = await _callApi(text);
    if (!mounted) return;
    setState(() { _msgs.add(_PixiMsg(text: reply, isPixi: true)); _loading = false; });
    _scrollBottom();
  }

  void _scrollBottom() {
    Future.delayed(const Duration(milliseconds: 120), () {
      if (_scrollCtrl.hasClients) _scrollCtrl.animateTo(_scrollCtrl.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.end, children: [
      if (_open) FadeTransition(opacity: _fadeAnim, child: ScaleTransition(scale: _scale, alignment: Alignment.bottomRight,
        child: Container(width: 300, height: 420, margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(color: kSurface, borderRadius: BorderRadius.circular(24),
            boxShadow: [BoxShadow(color: kRoseDark.withOpacity(0.22), blurRadius: 28, offset: const Offset(0, 8))]),
          child: Column(children: [
            // Header
            Container(padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
              decoration: const BoxDecoration(color: kRoseDark, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
              child: Row(children: [
                Container(width: 36, height: 36,
                  decoration: BoxDecoration(color: kGold.withOpacity(0.25), shape: BoxShape.circle, border: Border.all(color: kGold.withOpacity(0.5), width: 1.5)),
                  child: const Center(child: Icon(Icons.support_agent_rounded, color: kGold, size: 20))),
                const SizedBox(width: 10),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Pixi", style: GoogleFonts.cormorantGaramond(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
                  Text("Cookie Cloud Assistant", style: GoogleFonts.dmSans(fontSize: 11, color: Colors.white60)),
                ])),
                Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF7EC97E), shape: BoxShape.circle)),
                const SizedBox(width: 10),
                GestureDetector(onTap: _toggle, child: Container(width: 28, height: 28,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), shape: BoxShape.circle),
                  child: const Icon(Icons.close_rounded, color: Colors.white, size: 16))),
              ])),
            // Messages
            Expanded(child: ListView.builder(controller: _scrollCtrl, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              itemCount: _msgs.length + (_loading ? 1 : 0),
              itemBuilder: (_, i) {
                if (_loading && i == _msgs.length) return _TypingDots();
                final m = _msgs[i];
                final isPixi = m.isPixi;
                return Padding(padding: const EdgeInsets.only(bottom: 10),
                  child: Row(mainAxisAlignment: isPixi ? MainAxisAlignment.start : MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.end, children: [
                    if (isPixi) ...[Container(width: 26, height: 26, decoration: const BoxDecoration(color: kChampagne, shape: BoxShape.circle),
                      child: const Center(child: Icon(Icons.support_agent_rounded, color: kRoseDark, size: 15))), const SizedBox(width: 6)],
                    Flexible(child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                      decoration: BoxDecoration(
                        color: isPixi ? kChampagne.withOpacity(0.55) : kRoseDark,
                        borderRadius: BorderRadius.only(topLeft: const Radius.circular(16), topRight: const Radius.circular(16),
                          bottomLeft: Radius.circular(isPixi ? 4 : 16), bottomRight: Radius.circular(isPixi ? 16 : 4))),
                      child: Text(m.text, style: GoogleFonts.dmSans(fontSize: 12.5, height: 1.45, color: isPixi ? kTaupeDark : Colors.white)))),
                    if (!isPixi) ...[const SizedBox(width: 6),
                      Container(width: 26, height: 26, decoration: BoxDecoration(color: kGold.withOpacity(0.25), shape: BoxShape.circle, border: Border.all(color: kGold.withOpacity(0.5))),
                        child: const Center(child: Text("A", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: kGold))))],
                  ]));
              })),
            // Input
            Padding(padding: const EdgeInsets.fromLTRB(12, 0, 12, 14), child: Row(children: [
              Expanded(child: TextField(controller: _inputCtrl, focusNode: _focus, textInputAction: TextInputAction.send,
                onSubmitted: (_) => _send(), enabled: !_loading, style: GoogleFonts.dmSans(fontSize: 13, color: kTaupeDark),
                decoration: InputDecoration(
                  hintText: _loading ? "Pixi is typing..." : "Ask Pixi anything...",
                  hintStyle: GoogleFonts.dmSans(fontSize: 13, color: kTaupeLight.withOpacity(0.7)),
                  filled: true, fillColor: kIvory, contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: kRoseMid, width: 1.5)),
                  isDense: true))),
              const SizedBox(width: 8),
              GestureDetector(onTap: _loading ? null : _send,
                child: AnimatedContainer(duration: const Duration(milliseconds: 200), width: 38, height: 38,
                  decoration: BoxDecoration(color: _loading ? kTaupeLight : kRoseDark, shape: BoxShape.circle),
                  child: const Icon(Icons.send_rounded, color: Colors.white, size: 17))),
            ])),
          ])))),
      GestureDetector(onTap: _toggle, child: AnimatedContainer(duration: const Duration(milliseconds: 200), width: 54, height: 54,
        decoration: BoxDecoration(color: _open ? kTaupeDark : kRoseDark, shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: kRoseDark.withOpacity(0.4), blurRadius: 16, offset: const Offset(0, 6))]),
        child: Center(child: AnimatedSwitcher(duration: const Duration(milliseconds: 200),
          child: _open
              ? const Icon(Icons.close_rounded, key: ValueKey('c'), color: Colors.white, size: 24)
              : const Icon(Icons.support_agent_rounded, key: ValueKey('a'), color: Colors.white, size: 26))))),
    ]);
  }
}

class _TypingDots extends StatefulWidget {
  @override
  State<_TypingDots> createState() => _TypingDotsState();
}
class _TypingDotsState extends State<_TypingDots> with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _a;
  @override void initState() { super.initState(); _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))..repeat(reverse: true); _a = Tween(begin: 0.3, end: 1.0).animate(_c); }
  @override void dispose() { _c.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(bottom: 10), child: Row(children: [
      Container(width: 26, height: 26, decoration: const BoxDecoration(color: kChampagne, shape: BoxShape.circle),
        child: const Center(child: Icon(Icons.support_agent_rounded, color: kRoseDark, size: 15))),
      const SizedBox(width: 6),
      AnimatedBuilder(animation: _a, builder: (_, __) => Opacity(opacity: _a.value,
        child: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(color: kChampagne.withOpacity(0.55),
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16), bottomRight: Radius.circular(16), bottomLeft: Radius.circular(4))),
          child: Text("Pixi is typing…", style: GoogleFonts.dmSans(fontSize: 12, color: kTaupeLight))))),
    ]));
  }
}

// ─── Item Details Page ────────────────────────────────────────────────────────
class ItemDetailsPage extends StatefulWidget {
  final Map<String, dynamic> product;
  const ItemDetailsPage({super.key, required this.product});
  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  int _qty = 1;

  @override
  void initState() {
    super.initState();
    final rv = List<Map<String, dynamic>>.from(recentlyViewedNotifier.value);
    rv.removeWhere((p) => p["name"] == widget.product["name"]);
    rv.insert(0, widget.product);
    recentlyViewedNotifier.value = rv.take(6).toList();
  }

  void _addToCart() {
    for (int i = 0; i < _qty; i++) cartNotifier.value = [...cartNotifier.value, Map<String, dynamic>.from(widget.product)];
    ScaffoldMessenger.of(context).showSnackBar(_cartSnackBar(widget.product["name"], context));
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final tag = (p["tag"] as String?) ?? '';
    final tagColor = tag == "New" ? kSuccess : (tag == "Premium" ? kGold : kRoseDark);
    final bool avail = p["available"] as bool? ?? true;
    final bool eggless = p["isEggless"] as bool? ?? false;

    return Scaffold(backgroundColor: kIvory, body: Stack(children: [
      CustomScrollView(slivers: [
        SliverAppBar(expandedHeight: 300, pinned: true, backgroundColor: kRoseDark,
          leading: Padding(padding: const EdgeInsets.all(8), child: GestureDetector(onTap: () => Navigator.pop(context),
            child: Container(decoration: BoxDecoration(color: Colors.white.withOpacity(0.25), shape: BoxShape.circle),
              child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18)))),
          actions: [Padding(padding: const EdgeInsets.all(8),
            child: ValueListenableBuilder<Set<String>>(valueListenable: wishlistNotifier, builder: (_, wl, __) {
              final isWl = wl.contains(p["name"]);
              return GestureDetector(onTap: () { final s = Set<String>.from(wl); isWl ? s.remove(p["name"]) : s.add(p["name"] as String); wishlistNotifier.value = s; },
                child: Container(decoration: BoxDecoration(color: Colors.white.withOpacity(0.25), shape: BoxShape.circle), padding: const EdgeInsets.all(8),
                  child: Icon(isWl ? Icons.favorite_rounded : Icons.favorite_border_rounded, color: isWl ? Colors.redAccent : Colors.white, size: 20)));
            }))],
          flexibleSpace: FlexibleSpaceBar(background: Stack(fit: StackFit.expand, children: [
            Image.network(p["image"], fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: kChampagne, child: const Center(child: Icon(Icons.bakery_dining_rounded, color: kTaupeLight, size: 60)))),
            Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
              colors: [Colors.transparent, kIvory.withOpacity(0.7)], stops: const [0.5, 1.0]))),
            if (tag.isNotEmpty) Positioned(bottom: 16, left: 16, child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(color: tagColor, borderRadius: BorderRadius.circular(8)),
              child: Text(tag, style: GoogleFonts.dmSans(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)))),
          ]))),
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(20, 20, 20, 130), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(p["name"], style: GoogleFonts.cormorantGaramond(fontSize: 26, fontWeight: FontWeight.w700, color: kTaupeDark)),
              Text(p["category"], style: GoogleFonts.dmSans(fontSize: 13, color: kRoseMid)),
            ])),
            const SizedBox(width: 12),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: avail ? kSuccess.withOpacity(0.12) : Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Text(avail ? "In Stock" : "Unavailable", style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w700, color: avail ? kSuccess : Colors.red))),
              const SizedBox(height: 6),
              Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: eggless ? kSuccess.withOpacity(0.12) : kRoseMid.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(eggless ? "🌱" : "🥚", style: const TextStyle(fontSize: 12)), const SizedBox(width: 4),
                  Text(eggless ? "Eggless" : "Contains Egg", style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w600, color: eggless ? kSuccess : kRoseMid)),
                ])),
            ]),
          ]),
          const SizedBox(height: 12),
          Row(children: [
            const Icon(Icons.star_rounded, size: 16, color: kGold), const SizedBox(width: 4),
            Text("${p["rating"]}", style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 14, color: kTaupeDark)),
            Text("  (${p["reviews"]} reviews)", style: GoogleFonts.dmSans(fontSize: 13, color: kTaupeLight)),
            const Spacer(),
            const Icon(Icons.delivery_dining_rounded, size: 16, color: kRoseMid), const SizedBox(width: 4),
            Text(p["deliveryTime"] ?? "30–45 mins", style: GoogleFonts.dmSans(fontSize: 13, color: kTaupeLight)),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            _chip(Icons.local_fire_department_outlined, "${p["calories"] ?? '--'} kcal"),
            const SizedBox(width: 8),
            _chip(Icons.restaurant_outlined, p["servingSize"] ?? "1 serving"),
          ]),
          const SizedBox(height: 20),
          Text("About", style: GoogleFonts.cormorantGaramond(fontSize: 20, fontWeight: FontWeight.w600, color: kTaupeDark)),
          const SizedBox(height: 6),
          Text(p["description"] ?? "A delicious treat from Cookie Cloud, baked fresh daily.",
            style: GoogleFonts.dmSans(fontSize: 14, height: 1.6, color: kTaupeLight)),
          const SizedBox(height: 20),
          if (p["ingredients"] != null) ...[
            Text("Ingredients", style: GoogleFonts.cormorantGaramond(fontSize: 20, fontWeight: FontWeight.w600, color: kTaupeDark)),
            const SizedBox(height: 8),
            Container(padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: kChampagne.withOpacity(0.4), borderRadius: BorderRadius.circular(14)),
              child: Text(p["ingredients"], style: GoogleFonts.dmSans(fontSize: 13.5, height: 1.6, color: kTaupeDark))),
            const SizedBox(height: 20),
          ],
          Container(padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: kGoldLight, borderRadius: BorderRadius.circular(12), border: Border.all(color: kGold.withOpacity(0.3))),
            child: Row(children: [const Icon(Icons.info_outline_rounded, color: kGold, size: 18), const SizedBox(width: 8),
              Expanded(child: Text("May contain traces of nuts, gluten and dairy. Please inform us of any allergies.",
                style: GoogleFonts.dmSans(fontSize: 12, color: kTaupeDark, height: 1.4)))])),
          const SizedBox(height: 20),
          Row(children: [
            Text("Quantity", style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 15, color: kTaupeDark)),
            const Spacer(),
            Container(decoration: BoxDecoration(color: kSurface, borderRadius: BorderRadius.circular(14),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10)]),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                GestureDetector(onTap: () { if (_qty > 1) setState(() => _qty--); },
                  child: Container(width: 36, height: 36,
                    decoration: BoxDecoration(color: _qty > 1 ? kRoseDark : kTaupeLight.withOpacity(0.3), borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.remove, color: Colors.white, size: 16))),
                SizedBox(width: 40, child: Center(child: Text("$_qty", style: GoogleFonts.dmSans(fontWeight: FontWeight.w800, fontSize: 16, color: kTaupeDark)))),
                GestureDetector(onTap: () => setState(() => _qty++),
                  child: Container(width: 36, height: 36, decoration: BoxDecoration(color: kRoseDark, borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.add, color: Colors.white, size: 16))),
              ])),
          ]),
        ]))),
      ]),
      Positioned(bottom: 0, left: 0, right: 0, child: Container(
        padding: EdgeInsets.fromLTRB(20, 16, 20, MediaQuery.of(context).padding.bottom + 16),
        decoration: BoxDecoration(color: kSurface, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 16, offset: const Offset(0, -4))]),
        child: Row(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
            Text("Total", style: GoogleFonts.dmSans(fontSize: 12, color: kTaupeLight)),
            Text("₹${(p["price"] as int) * _qty}", style: GoogleFonts.dmSans(fontWeight: FontWeight.w800, fontSize: 22, color: kRoseDark)),
          ]),
          const SizedBox(width: 16),
          Expanded(child: GestureDetector(onTap: _addToCart, child: Container(height: 52,
            decoration: BoxDecoration(border: Border.all(color: kRoseDark, width: 1.5), borderRadius: BorderRadius.circular(14)),
            child: Center(child: Text("Add to Cart", style: GoogleFonts.dmSans(color: kRoseDark, fontWeight: FontWeight.w700, fontSize: 14)))))),
          const SizedBox(width: 10),
          Expanded(child: GestureDetector(onTap: () { _addToCart(); Navigator.pop(context); },
            child: Container(height: 52, decoration: BoxDecoration(color: kRoseDark, borderRadius: BorderRadius.circular(14)),
              child: Center(child: Text("Buy Now", style: GoogleFonts.dmSans(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)))))),
        ]),
      )),
    ]));
  }

  Widget _chip(IconData icon, String label) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(color: kSurface, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8)]),
    child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, size: 16, color: kRoseMid), const SizedBox(width: 6), Text(label, style: GoogleFonts.dmSans(fontSize: 12.5, fontWeight: FontWeight.w600, color: kTaupeDark))]));
}

// ─── Home Content ─────────────────────────────────────────────────────────────
class HomeContent extends StatefulWidget {
  final void Function(int) onNavigate;
  const HomeContent({super.key, required this.onNavigate});
  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String _search = "", _cat = "All";
  final _scrollCtrl = ScrollController();
  final _searchCtrl = TextEditingController();

  @override
  void dispose() { _scrollCtrl.dispose(); _searchCtrl.dispose(); super.dispose(); }

  List<Map<String, dynamic>> get filtered => products.where((p) {
    final matchCat = _cat == "All" || p["category"] == _cat;
    final matchSearch = p["name"].toString().toLowerCase().contains(_search.toLowerCase());
    return matchCat && matchSearch;
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: kIvory, body: CustomScrollView(controller: _scrollCtrl, slivers: [
      SliverToBoxAdapter(child: _HeroHeader(onSearch: (q) => setState(() => _search = q), controller: _searchCtrl,
        onCartTap: () => widget.onNavigate(2), onProfileTap: () => widget.onNavigate(4))),
      SliverToBoxAdapter(child: _TodaySpecialBanner(onAddToCart: () {
        final s = products.firstWhere((p) => p["name"] == "Vanilla Dream Cake");
        cartNotifier.value = [...cartNotifier.value, Map<String, dynamic>.from(s)];
        ScaffoldMessenger.of(context).showSnackBar(_cartSnackBar("Vanilla Dream Cake", context));
      })),
      SliverToBoxAdapter(child: _CategoriesRow(selected: _cat, onSelect: (c) => setState(() => _cat = c))),
      SliverToBoxAdapter(child: _SectionHeader(title: "Bestsellers ✨", onSeeAll: () => widget.onNavigate(1))),
      SliverToBoxAdapter(child: SizedBox(height: 265, child: ListView.builder(scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: products.where((p) => p["tag"] == "Bestseller").length,
        itemBuilder: (_, i) => _BestsellerCard(product: products.where((p) => p["tag"] == "Bestseller").toList()[i])))),
      SliverToBoxAdapter(child: _SectionHeader(title: "All Items 🌹", onSeeAll: () => widget.onNavigate(1))),
      SliverPadding(padding: const EdgeInsets.fromLTRB(16, 0, 16, 8), sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((ctx, i) => _ProductCard(product: filtered[i]), childCount: filtered.length),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.72, crossAxisSpacing: 12, mainAxisSpacing: 12))),
      SliverToBoxAdapter(child: _RecentlyViewedSection()),
      SliverToBoxAdapter(child: _ReviewsSnippet()),
      const SliverToBoxAdapter(child: SizedBox(height: 120)),
    ]));
  }
}

// ─── Hero Header ──────────────────────────────────────────────────────────────
class _HeroHeader extends StatelessWidget {
  final ValueChanged<String> onSearch;
  final TextEditingController controller;
  final VoidCallback onCartTap, onProfileTap;
  const _HeroHeader({required this.onSearch, required this.controller, required this.onCartTap, required this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return Container(decoration: const BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(36), bottomRight: Radius.circular(36))),
      child: Stack(children: [
        ClipRRect(borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(36), bottomRight: Radius.circular(36)),
          child: Image.network("https://images.unsplash.com/photo-1499636136210-6f4ee915583e?w=900&q=85",
            width: double.infinity, height: 300, fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(height: 300, color: kRoseMid))),
        ClipRRect(borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(36), bottomRight: Radius.circular(36)),
          child: Container(height: 300, decoration: BoxDecoration(gradient: LinearGradient(
            colors: [const Color(0xFF4A2C2C).withOpacity(0.88), const Color(0xFF7B4F4F).withOpacity(0.78), const Color(0xFFC8938A).withOpacity(0.50), Colors.transparent],
            begin: Alignment.topLeft, end: Alignment.bottomRight, stops: const [0.0, 0.35, 0.70, 1.0])))),
        SafeArea(bottom: false, child: Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 28), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            const Spacer(),
            GestureDetector(onTap: onCartTap, child: ValueListenableBuilder<List<Map<String, dynamic>>>(valueListenable: cartNotifier, builder: (_, cart, __) =>
              Stack(clipBehavior: Clip.none, children: [
                _iconBtn(Icons.shopping_bag_outlined),
                if (cart.isNotEmpty) Positioned(right: -2, top: -2, child: Container(width: 18, height: 18,
                  decoration: const BoxDecoration(color: kGold, shape: BoxShape.circle),
                  child: Center(child: Text("${cart.length}", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: kTaupeDark))))),
              ]))),
            const SizedBox(width: 8),
            GestureDetector(onTap: onProfileTap, child: Container(width: 38, height: 38,
              decoration: BoxDecoration(shape: BoxShape.circle, color: kGold.withOpacity(0.25), border: Border.all(color: kGold.withOpacity(0.6), width: 1.5)),
              child: const Center(child: Text("A", style: TextStyle(color: kGold, fontWeight: FontWeight.bold, fontSize: 16))))),
          ]),
          const SizedBox(height: 18),
          Row(children: [const Text("🍪", style: TextStyle(fontSize: 32)), const SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Cookie Cloud", style: GoogleFonts.cormorantGaramond(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600)),
              Text("Baked with love, every cloud", style: GoogleFonts.dmSans(color: kGold, fontSize: 12)),
            ])]),
          const SizedBox(height: 18),
          Container(decoration: BoxDecoration(color: Colors.white.withOpacity(0.18), borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withOpacity(0.3), width: 1)),
            child: TextField(controller: controller, onChanged: onSearch, style: GoogleFonts.dmSans(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(hintText: "Search cookies, cakes, coffee & more...",
                hintStyle: GoogleFonts.dmSans(color: Colors.white60, fontSize: 14),
                prefixIcon: const Icon(Icons.search_rounded, color: Colors.white60, size: 22),
                filled: false, border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(vertical: 16)))),
        ]))),
      ]));
  }

  Widget _iconBtn(IconData icon) => Container(width: 38, height: 38,
    decoration: BoxDecoration(color: Colors.white.withOpacity(0.18), shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.22))),
    child: Icon(icon, color: Colors.white, size: 20));
}

// ─── Today's Special Banner ───────────────────────────────────────────────────
class _TodaySpecialBanner extends StatelessWidget {
  final VoidCallback onAddToCart;
  const _TodaySpecialBanner({required this.onAddToCart});
  @override
  Widget build(BuildContext context) {
    return Container(margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFF5E8D8), Color(0xFFEDD8C0)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(22), border: Border.all(color: kGold.withOpacity(0.30), width: 1)),
      child: IntrinsicHeight(child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(child: Padding(padding: const EdgeInsets.fromLTRB(16, 14, 8, 14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: kGold.withOpacity(0.25), borderRadius: BorderRadius.circular(6)),
            child: Text("TODAY'S SPECIAL", style: GoogleFonts.dmSans(fontSize: 9, fontWeight: FontWeight.w800, color: kTaupeDark, letterSpacing: 1))),
          const SizedBox(height: 6),
          Text("Vanilla Dream Cake", style: GoogleFonts.cormorantGaramond(fontSize: 18, fontWeight: FontWeight.w700, color: kTaupeDark)),
          const SizedBox(height: 4),
          Row(children: [
            Text("₹1232", style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w800, color: kRoseDark)),
            const SizedBox(width: 5), Text("₹1450", style: GoogleFonts.dmSans(fontSize: 11, color: kTaupeLight, decoration: TextDecoration.lineThrough)),
            const SizedBox(width: 5),
            Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: kSuccess.withOpacity(0.12), borderRadius: BorderRadius.circular(6)),
              child: Text("15% off", style: GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.w700, color: kSuccess))),
          ]),
          const SizedBox(height: 10),
          GestureDetector(onTap: onAddToCart, child: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(color: kRoseDark, borderRadius: BorderRadius.circular(10)),
            child: Text("Add to Cart", style: GoogleFonts.dmSans(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)))),
        ]))),
        ClipRRect(borderRadius: const BorderRadius.only(topRight: Radius.circular(22), bottomRight: Radius.circular(22)),
          child: Image.network("https://images.unsplash.com/photo-1464349095431-e9a21285b5f3?w=300&q=80", width: 120, height: 145, fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(width: 120, height: 145, color: kChampagne))),
      ])));
  }
}

// ─── Categories Row ───────────────────────────────────────────────────────────
class _CategoriesRow extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelect;
  const _CategoriesRow({required this.selected, required this.onSelect});
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(padding: const EdgeInsets.fromLTRB(16, 22, 16, 12),
        child: Text("Categories", style: GoogleFonts.cormorantGaramond(fontSize: 20, fontWeight: FontWeight.w600, color: kTaupeDark))),
      SizedBox(height: 88, child: ListView.builder(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length, itemBuilder: (_, i) {
          final cat = categories[i]; final isActive = selected == cat["name"];
          return GestureDetector(onTap: () => onSelect(cat["name"]!),
            child: AnimatedContainer(duration: const Duration(milliseconds: 200), margin: const EdgeInsets.only(right: 12), child: Column(children: [
              AnimatedContainer(duration: const Duration(milliseconds: 200), width: 56, height: 56,
                decoration: BoxDecoration(color: isActive ? kRoseDark : kSurface, shape: BoxShape.circle,
                  boxShadow: isActive ? [BoxShadow(color: kRoseDark.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))] : [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8)]),
                child: Center(child: Text(cat["emoji"]!, style: const TextStyle(fontSize: 24)))),
              const SizedBox(height: 6),
              Text(cat["name"]!, style: GoogleFonts.dmSans(fontSize: 11.5, fontWeight: isActive ? FontWeight.w700 : FontWeight.w400, color: isActive ? kRoseDark : kTaupeLight)),
            ])));
        })),
    ]);
  }
}

// ─── Section Header ───────────────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String title; final VoidCallback onSeeAll;
  const _SectionHeader({required this.title, required this.onSeeAll});
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(16, 20, 16, 12), child: Row(children: [
      Text(title, style: GoogleFonts.cormorantGaramond(fontSize: 20, fontWeight: FontWeight.w600, color: kTaupeDark)),
      const Spacer(),
      GestureDetector(onTap: onSeeAll, child: Text("See all", style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: kRoseMid))),
    ]));
  }
}

// ─── Bestseller Card ──────────────────────────────────────────────────────────
class _BestsellerCard extends StatelessWidget {
  final Map<String, dynamic> product;
  const _BestsellerCard({required this.product});
  @override
  Widget build(BuildContext context) {
    final p = product;
    return GestureDetector(onTap: () => Navigator.push(context, _fadeRoute(ItemDetailsPage(product: p))),
      child: Container(width: 175, margin: const EdgeInsets.only(right: 14),
        decoration: BoxDecoration(color: kSurface, borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 16, offset: const Offset(0, 5))]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
          Stack(children: [
            ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.network(p["image"], width: 175, height: 148, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(height: 148, color: kChampagne))),
            if ((p["tag"] as String).isNotEmpty) Positioned(top: 8, left: 8,
              child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: kRoseDark, borderRadius: BorderRadius.circular(6)),
                child: Text(p["tag"], style: GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)))),
          ]),
          Padding(padding: const EdgeInsets.fromLTRB(11, 9, 11, 11), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
            Text(p["name"], maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 13.5, color: kTaupeDark)),
            const SizedBox(height: 4),
            Row(children: [const Icon(Icons.star_rounded, size: 13, color: kGold), const SizedBox(width: 2),
              Text("${p["rating"]}", style: GoogleFonts.dmSans(fontSize: 12, color: kTaupe, fontWeight: FontWeight.w600)),
              Text("  (${p["reviews"]})", style: GoogleFonts.dmSans(fontSize: 11, color: Colors.grey))]),
            const SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("₹${p["price"]}", style: GoogleFonts.dmSans(fontWeight: FontWeight.w800, fontSize: 16, color: kRoseDark)),
              GestureDetector(onTap: () { cartNotifier.value = [...cartNotifier.value, Map<String, dynamic>.from(p)]; ScaffoldMessenger.of(context).showSnackBar(_cartSnackBar(p["name"], context)); },
                child: Container(width: 34, height: 34, decoration: const BoxDecoration(color: kRoseDark, shape: BoxShape.circle),
                  child: const Icon(Icons.add_rounded, color: Colors.white, size: 20))),
            ]),
          ])),
        ])));
  }
}

// ─── Product Card ─────────────────────────────────────────────────────────────
class _ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  const _ProductCard({required this.product});
  @override
  Widget build(BuildContext context) {
    final p = product;
    return GestureDetector(onTap: () => Navigator.push(context, _fadeRoute(ItemDetailsPage(product: p))),
      child: Container(decoration: BoxDecoration(color: kSurface, borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 12, offset: const Offset(0, 4))]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(children: [
            ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
              child: Image.network(p["image"], width: double.infinity, height: 120, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(height: 120, color: kChampagne))),
            if ((p["tag"] as String).isNotEmpty) Positioned(top: 7, left: 7,
              child: Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(color: p["tag"] == "New" ? kSuccess : (p["tag"] == "Premium" ? kGold : kRoseDark), borderRadius: BorderRadius.circular(6)),
                child: Text(p["tag"], style: GoogleFonts.dmSans(fontSize: 9, fontWeight: FontWeight.w700, color: Colors.white)))),
            Positioned(top: 7, right: 7, child: ValueListenableBuilder<Set<String>>(valueListenable: wishlistNotifier, builder: (_, wl, __) {
              final isWl = wl.contains(p["name"]);
              return GestureDetector(onTap: () { final s = Set<String>.from(wl); isWl ? s.remove(p["name"]) : s.add(p["name"] as String); wishlistNotifier.value = s; },
                child: Container(width: 28, height: 28, decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)]),
                  child: Icon(isWl ? Icons.favorite_rounded : Icons.favorite_border_rounded, size: 15, color: isWl ? kRoseMid : Colors.grey)));
            })),
          ]),
          Padding(padding: const EdgeInsets.fromLTRB(10, 8, 10, 10), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
            Text(p["name"], maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 12.5, color: kTaupeDark)),
            const SizedBox(height: 3),
            Row(children: [const Icon(Icons.star_rounded, size: 11, color: kGold), const SizedBox(width: 2),
              Text("${p["rating"]}", style: GoogleFonts.dmSans(fontSize: 11, color: kTaupe, fontWeight: FontWeight.w600)),
              Text("  (${p["reviews"]})", style: GoogleFonts.dmSans(fontSize: 10, color: Colors.grey))]),
            const SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("₹${p["price"]}", style: GoogleFonts.dmSans(fontWeight: FontWeight.w800, fontSize: 14, color: kRoseDark)),
              GestureDetector(onTap: () { cartNotifier.value = [...cartNotifier.value, Map<String, dynamic>.from(p)]; ScaffoldMessenger.of(context).showSnackBar(_cartSnackBar(p["name"], context)); },
                child: Container(width: 30, height: 30, decoration: const BoxDecoration(color: kRoseDark, shape: BoxShape.circle),
                  child: const Icon(Icons.add_rounded, color: Colors.white, size: 17))),
            ]),
          ])),
        ])));
  }
}

// ─── Recently Viewed ──────────────────────────────────────────────────────────
class _RecentlyViewedSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Map<String, dynamic>>>(valueListenable: recentlyViewedNotifier, builder: (_, items, __) {
      if (items.isEmpty) return const SizedBox.shrink();
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _SectionHeader(title: "Recently Viewed 👀", onSeeAll: () {}),
        SizedBox(height: 90, child: ListView.builder(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: items.length,
          itemBuilder: (_, i) {
            final p = items[i];
            return GestureDetector(onTap: () => Navigator.push(context, _fadeRoute(ItemDetailsPage(product: p))),
              child: Container(width: 70, margin: const EdgeInsets.only(right: 10), child: Column(children: [
                ClipRRect(borderRadius: BorderRadius.circular(14),
                  child: Image.network(p["image"], width: 60, height: 60, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(width: 60, height: 60, color: kChampagne))),
                const SizedBox(height: 4),
                Text(p["name"], maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.dmSans(fontSize: 9.5, color: kTaupeLight)),
              ])));
          })),
      ]);
    });
  }
}

// ─── Reviews Snippet ──────────────────────────────────────────────────────────
class _ReviewsSnippet extends StatelessWidget {
  const _ReviewsSnippet();
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _SectionHeader(title: "What customers say 💬", onSeeAll: () {}),
      SizedBox(height: 155, child: ListView.builder(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: customerReviews.length,
        itemBuilder: (_, i) {
          final r = customerReviews[i];
          return Container(width: 240, margin: const EdgeInsets.only(right: 12), padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: kSurface, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10)]),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                CircleAvatar(radius: 16, backgroundColor: r["avatarColor"] as Color, child: Text(r["avatar"], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))),
                const SizedBox(width: 8),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(r["name"], style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 12.5, color: kTaupeDark)),
                  Text(r["item"], style: GoogleFonts.dmSans(fontSize: 10.5, color: kRoseMid)),
                ])),
                Text(r["date"], style: GoogleFonts.dmSans(fontSize: 10, color: Colors.grey)),
              ]),
              const SizedBox(height: 8),
              Row(children: List.generate(r["rating"] as int, (_) => const Icon(Icons.star_rounded, color: kGold, size: 13))),
              const SizedBox(height: 6),
              Text(r["comment"], maxLines: 2, overflow: TextOverflow.ellipsis, style: GoogleFonts.dmSans(fontSize: 12, height: 1.4, color: kTaupeLight)),
            ]));
        })),
    ]);
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
  final List<String> _sorts = ["Popular", "Price: Low", "Price: High", "Rating"];

  List<Map<String, dynamic>> get _sorted {
    final list = List<Map<String, dynamic>>.from(products);
    switch (_sort) {
      case "Price: Low": list.sort((a, b) => (a["price"] as int).compareTo(b["price"] as int)); break;
      case "Price: High": list.sort((a, b) => (b["price"] as int).compareTo(a["price"] as int)); break;
      case "Rating": list.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double)); break;
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: kIvory,
      appBar: AppBar(backgroundColor: kIvory, elevation: 0, titleSpacing: 16,
        title: Text("Explore", style: GoogleFonts.cormorantGaramond(fontSize: 26, fontWeight: FontWeight.w600, color: kTaupeDark)),
        actions: [Padding(padding: const EdgeInsets.only(right: 16),
          child: DropdownButton<String>(value: _sort, underline: const SizedBox(),
            style: GoogleFonts.dmSans(color: kRoseMid, fontWeight: FontWeight.w600, fontSize: 13),
            icon: const Icon(Icons.sort_rounded, color: kRoseMid, size: 18),
            items: _sorts.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
            onChanged: (v) => setState(() => _sort = v!)))]),
      body: GridView.builder(padding: const EdgeInsets.fromLTRB(16, 8, 16, 100), itemCount: _sorted.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.72, crossAxisSpacing: 12, mainAxisSpacing: 12),
        itemBuilder: (_, i) => _ProductCard(product: _sorted[i])));
  }
}

// ─── Cart Screen ──────────────────────────────────────────────────────────────
class CartScreen extends StatefulWidget {
  final void Function(int) onNavigate;
  const CartScreen({super.key, required this.onNavigate});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _couponCtrl = TextEditingController();
  String? _coupon; int _disc = 0;

  void _applyCoupon() {
    final c = _couponCtrl.text.trim().toUpperCase();
    if (c == "SWEET10") { setState(() { _coupon = c; _disc = 10; }); _snack("SWEET10 applied — 10% off!", kSuccess); }
    else if (c == "CLOUD20") { setState(() { _coupon = c; _disc = 20; }); _snack("CLOUD20 applied — 20% off!", kSuccess); }
    else _snack("Invalid coupon code.", Colors.red.shade400);
  }

  void _snack(String msg, Color color) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg, style: GoogleFonts.dmSans(fontWeight: FontWeight.w600)), backgroundColor: color,
    behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: const EdgeInsets.fromLTRB(16, 0, 16, 90)));

  Map<String, int> _qty(List<Map<String, dynamic>> cart) {
    final q = <String, int>{};
    for (final i in cart) q[i["name"]] = (q[i["name"]] ?? 0) + 1;
    return q;
  }

  List<Map<String, dynamic>> _unique(List<Map<String, dynamic>> cart) {
    final seen = <String>{}; final u = <Map<String, dynamic>>[];
    for (final i in cart) { if (seen.add(i["name"] as String)) u.add(i); }
    return u;
  }

  int _sub(List<Map<String, dynamic>> cart) => cart.fold(0, (s, i) => s + (i["price"] as int));

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Map<String, dynamic>>>(valueListenable: cartNotifier, builder: (_, cart, __) {
      final sub = _sub(cart);
      final del = sub >= 800 ? 0 : 49;
      final gst = (sub * 0.05).round();
      final discount = _coupon != null ? (sub * _disc ~/ 100) : 0;
      final total = sub + del + gst - discount;
      final unique = _unique(cart); final qtys = _qty(cart);

      return Scaffold(backgroundColor: kIvory,
        appBar: AppBar(backgroundColor: kIvory, elevation: 0, titleSpacing: 16,
          title: Text("My Cart", style: GoogleFonts.cormorantGaramond(fontSize: 26, fontWeight: FontWeight.w600, color: kTaupeDark)),
          actions: [if (cart.isNotEmpty) Padding(padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(onTap: () => cartNotifier.value = [],
              child: Text("Clear all", style: GoogleFonts.dmSans(color: Colors.red, fontSize: 13, fontWeight: FontWeight.w600))))]),
        body: cart.isEmpty
            ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("🛒", style: TextStyle(fontSize: 60)), const SizedBox(height: 20),
                Text("Your cart is empty", style: GoogleFonts.cormorantGaramond(fontSize: 26, fontWeight: FontWeight.w600, color: kTaupeDark)),
                const SizedBox(height: 8), Text("Add some delicious treats!", style: GoogleFonts.dmSans(color: kTaupeLight)),
                const SizedBox(height: 28),
                GestureDetector(onTap: () => widget.onNavigate(1), child: Container(padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                  decoration: BoxDecoration(color: kRoseDark, borderRadius: BorderRadius.circular(16)),
                  child: Text("Browse Menu", style: GoogleFonts.dmSans(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)))),
              ]))
            : ListView(padding: const EdgeInsets.fromLTRB(16, 8, 16, 20), children: [
                ...unique.map((item) {
                  final qty = qtys[item["name"]] ?? 1;
                  return Container(margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(color: kSurface, borderRadius: BorderRadius.circular(18),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 3))]),
                    child: Padding(padding: const EdgeInsets.all(12), child: Row(children: [
                      ClipRRect(borderRadius: BorderRadius.circular(14),
                        child: Image.network(item["image"], width: 78, height: 78, fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(width: 78, height: 78, color: kChampagne))),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(children: [
                          Expanded(child: Text(item["name"], maxLines: 1, overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 14, color: kTaupeDark))),
                          GestureDetector(onTap: () { final u = List<Map<String, dynamic>>.from(cartNotifier.value); u.removeWhere((c) => c["name"] == item["name"]); cartNotifier.value = u; },
                            child: Container(width: 26, height: 26, decoration: BoxDecoration(color: Colors.red.withOpacity(0.08), shape: BoxShape.circle),
                              child: const Icon(Icons.close_rounded, color: Colors.red, size: 14))),
                        ]),
                        Text(item["category"], style: GoogleFonts.dmSans(fontSize: 11.5, color: kTaupeLight)),
                        const SizedBox(height: 8),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text("₹${(item["price"] as int) * qty}", style: GoogleFonts.dmSans(fontWeight: FontWeight.w800, fontSize: 16, color: kRoseDark)),
                          Row(children: [
                            GestureDetector(onTap: () { final u = List<Map<String, dynamic>>.from(cartNotifier.value); final idx = u.lastIndexWhere((c) => c["name"] == item["name"]); if (idx >= 0) u.removeAt(idx); cartNotifier.value = u; },
                              child: Container(width: 30, height: 30, decoration: BoxDecoration(color: kIvory, borderRadius: BorderRadius.circular(8), border: Border.all(color: kRoseLight.withOpacity(0.5))),
                                child: const Icon(Icons.remove, size: 15, color: kTaupeDark))),
                            Container(width: 34, alignment: Alignment.center, child: Text("$qty", style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 14, color: kTaupeDark))),
                            GestureDetector(onTap: () { final u = List<Map<String, dynamic>>.from(cartNotifier.value); u.insert(0, Map<String, dynamic>.from(item)); cartNotifier.value = u; },
                              child: Container(width: 30, height: 30, decoration: BoxDecoration(color: kRoseDark, borderRadius: BorderRadius.circular(8)),
                                child: const Icon(Icons.add, size: 15, color: Colors.white))),
                          ]),
                        ]),
                      ])),
                    ])));
                }),
                const SizedBox(height: 8),
                // Coupon
                Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: kSurface, borderRadius: BorderRadius.circular(18), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [const Icon(Icons.local_offer_outlined, color: kRoseMid, size: 18), const SizedBox(width: 8),
                      Text("Apply Coupon", style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 14, color: kTaupeDark)),
                      if (_coupon != null) ...[const Spacer(), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: kSuccess.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                        child: Text(_coupon!, style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w700, color: kSuccess)))]]),
                    if (_coupon == null) ...[const SizedBox(height: 10), Row(children: [
                      Expanded(child: TextField(controller: _couponCtrl, style: GoogleFonts.dmSans(color: kTaupeDark, fontSize: 13),
                        decoration: InputDecoration(hintText: "Try SWEET10 or CLOUD20", hintStyle: GoogleFonts.dmSans(color: kTaupeLight.withOpacity(0.7), fontSize: 13),
                          filled: true, fillColor: kIvory, contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none), isDense: true))),
                      const SizedBox(width: 10),
                      GestureDetector(onTap: _applyCoupon, child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(color: kRoseDark, borderRadius: BorderRadius.circular(12)),
                        child: Text("Apply", style: GoogleFonts.dmSans(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13)))),
                    ])],
                  ])),
                const SizedBox(height: 12),
                // Summary
                Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: kSurface, borderRadius: BorderRadius.circular(18), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text("Order Summary", style: GoogleFonts.cormorantGaramond(fontSize: 18, fontWeight: FontWeight.w600, color: kTaupeDark)),
                    const SizedBox(height: 14),
                    _sRow("Subtotal", "₹$sub"), const SizedBox(height: 8),
                    _sRow("Delivery Fee", del == 0 ? "FREE" : "₹$del", vc: del == 0 ? kSuccess : null), const SizedBox(height: 8),
                    _sRow("GST (5%)", "₹$gst"),
                    if (_coupon != null) ...[const SizedBox(height: 8), _sRow("Discount ($_coupon)", "−₹$discount", vc: kSuccess)],
                    const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(color: kChampagne)),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text("Total Payable", style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 15, color: kTaupeDark)),
                      Text("₹$total", style: GoogleFonts.dmSans(fontWeight: FontWeight.w800, fontSize: 20, color: kRoseDark)),
                    ]),
                  ])),
                const SizedBox(height: 18),
                SizedBox(height: 56, child: ElevatedButton(
                  onPressed: () => Navigator.push(context, _fadeRoute(CheckoutPage(cart: cart, subtotal: sub, deliveryFee: del, gst: gst, discount: discount, total: total, onNavigate: widget.onNavigate))),
                  style: ElevatedButton.styleFrom(backgroundColor: kRoseDark, foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                  child: Text("Proceed to Checkout", style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w700)))),
                const SizedBox(height: 100),
              ]),
      );
    });
  }

  Widget _sRow(String label, String value, {Color? vc}) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Text(label, style: GoogleFonts.dmSans(color: kTaupeLight, fontSize: 13.5)),
    Text(value, style: GoogleFonts.dmSans(color: vc ?? kTaupeDark, fontWeight: FontWeight.w600, fontSize: 13.5)),
  ]);
}

// ─── Checkout Page ────────────────────────────────────────────────────────────
class CheckoutPage extends StatefulWidget {
  final List<Map<String, dynamic>> cart;
  final int subtotal, deliveryFee, gst, discount, total;
  final void Function(int) onNavigate;
  const CheckoutPage({super.key, required this.cart, required this.subtotal, required this.deliveryFee, required this.gst, required this.discount, required this.total, required this.onNavigate});
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _nameCtrl = TextEditingController(text: "Aanya Sharma");
  final _phoneCtrl = TextEditingController(text: "+91 98765 43210");
  final _addressCtrl = TextEditingController(text: "B-24, Greater Kailash I, New Delhi, Delhi 110048");
  final _instructionsCtrl = TextEditingController();
  final _giftMsgCtrl = TextEditingController();
  String _payment = "cod";
  bool _placing = false, _isGift = false;
  int _selAddr = 0;

  @override
  void dispose() { _nameCtrl.dispose(); _phoneCtrl.dispose(); _addressCtrl.dispose(); _instructionsCtrl.dispose(); _giftMsgCtrl.dispose(); super.dispose(); }

  void _confirm() async {
    if (_nameCtrl.text.trim().isEmpty || _phoneCtrl.text.trim().isEmpty || _addressCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill in all required fields.", style: GoogleFonts.dmSans(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.red.shade400, behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), margin: const EdgeInsets.fromLTRB(16, 0, 16, 90)));
      return;
    }
    setState(() => _placing = true);
    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;
    orderHistoryNotifier.value = [{"items": List<Map<String, dynamic>>.from(widget.cart), "total": widget.total, "date": "Today", "status": "Confirmed", "payment": _payment, "address": _addressCtrl.text.trim(), "isGift": _isGift, "giftMessage": _isGift ? _giftMsgCtrl.text.trim() : ""}, ...orderHistoryNotifier.value];
    cartNotifier.value = [];
    setState(() => _placing = false);
    if (!mounted) return;
    Navigator.pop(context); widget.onNavigate(3);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(children: [const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20), const SizedBox(width: 10), const Expanded(child: Text("Order placed! 🎉 Your goodies are on the way.", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)))]),
      backgroundColor: kSuccess, behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), margin: const EdgeInsets.fromLTRB(16, 0, 16, 90), duration: const Duration(seconds: 3)));
  }

  @override
  Widget build(BuildContext context) {
    final uniqueItems = <Map<String, dynamic>>[];
    final seen = <String>{}; final qtys = <String, int>{};
    for (final item in widget.cart) { qtys[item["name"]] = (qtys[item["name"]] ?? 0) + 1; if (seen.add(item["name"] as String)) uniqueItems.add(item); }

    return Scaffold(backgroundColor: kIvory,
      appBar: AppBar(backgroundColor: kIvory, elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, color: kTaupeDark, size: 20), onPressed: () => Navigator.pop(context)),
        title: Text("Checkout", style: GoogleFonts.cormorantGaramond(fontSize: 24, fontWeight: FontWeight.w600, color: kTaupeDark))),
      body: ListView(padding: const EdgeInsets.fromLTRB(16, 8, 16, 20), children: [
        // Delivery address
        _card(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _secTitle(Icons.location_on_outlined, "Delivery Address"), const SizedBox(height: 14),
          ValueListenableBuilder<List<Map<String, dynamic>>>(valueListenable: savedAddressesNotifier, builder: (_, addrs, __) {
            return Column(children: [
              ...List.generate(addrs.length, (i) {
                final addr = addrs[i]; final isSel = i == _selAddr;
                final fullAddr = "${addr["houseNo"]}, ${addr["street"]}, ${addr["city"]}, ${addr["state"]} ${addr["pincode"]}";
                return GestureDetector(onTap: () { setState(() { _selAddr = i; _addressCtrl.text = fullAddr; _nameCtrl.text = addr["name"] ?? _nameCtrl.text; _phoneCtrl.text = addr["phone"] ?? _phoneCtrl.text; }); },
                  child: AnimatedContainer(duration: const Duration(milliseconds: 180), margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: isSel ? kRoseDark.withOpacity(0.06) : kIvory, borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: isSel ? kRoseDark : kTaupeLight.withOpacity(0.3), width: isSel ? 1.5 : 1)),
                    child: Row(children: [
                      Icon(addr["type"] == "Home" ? Icons.home_rounded : Icons.business_rounded, color: isSel ? kRoseDark : kTaupeLight, size: 18),
                      const SizedBox(width: 10),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(addr["type"], style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 13, color: kTaupeDark)),
                        Text(fullAddr, style: GoogleFonts.dmSans(fontSize: 12, color: kTaupeLight), maxLines: 1, overflow: TextOverflow.ellipsis),
                      ])),
                      if (isSel) const Icon(Icons.check_circle_rounded, color: kRoseDark, size: 18),
                    ])));
              }),
              GestureDetector(onTap: () { setState(() { _selAddr = -1; _addressCtrl.clear(); }); },
                child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: kIvory, borderRadius: BorderRadius.circular(12), border: Border.all(color: kTaupeLight.withOpacity(0.3))),
                  child: Row(children: [const Icon(Icons.add_location_alt_outlined, color: kRoseMid, size: 18), const SizedBox(width: 10),
                    Text("Enter a different address", style: GoogleFonts.dmSans(fontSize: 13, color: kRoseMid, fontWeight: FontWeight.w600))]))),
              if (_selAddr == -1) ...[const SizedBox(height: 12),
                _coField(Icons.person_outline_rounded, "Full Name", _nameCtrl), const SizedBox(height: 10),
                _coField(Icons.phone_outlined, "Phone Number", _phoneCtrl, type: TextInputType.phone), const SizedBox(height: 10),
                _coField(Icons.home_outlined, "Delivery Address", _addressCtrl, lines: 2)],
            ]);
          }),
          const SizedBox(height: 10),
          _coField(Icons.notes_rounded, "Delivery Instructions (optional)", _instructionsCtrl, lines: 2),
        ])),
        const SizedBox(height: 14),
        // Gift
        _card(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _secTitle(Icons.card_giftcard_rounded, "Gift Option"), const SizedBox(height: 12),
          GestureDetector(onTap: () => setState(() => _isGift = !_isGift),
            child: AnimatedContainer(duration: const Duration(milliseconds: 180), padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: _isGift ? kRoseDark.withOpacity(0.06) : kIvory, borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _isGift ? kRoseDark : kTaupeLight.withOpacity(0.3), width: _isGift ? 1.5 : 1)),
              child: Row(children: [
                Container(width: 40, height: 40, decoration: BoxDecoration(color: _isGift ? kRoseDark : kChampagne.withOpacity(0.6), borderRadius: BorderRadius.circular(10)),
                  child: Icon(Icons.card_giftcard_rounded, color: _isGift ? Colors.white : kRoseMid, size: 20)),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Send as a Gift 🎁", style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 13.5, color: kTaupeDark)),
                  Text("Add a personal gift message", style: GoogleFonts.dmSans(fontSize: 12, color: kTaupeLight)),
                ])),
                AnimatedContainer(duration: const Duration(milliseconds: 180), width: 22, height: 22,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: _isGift ? kRoseDark : Colors.transparent, border: Border.all(color: _isGift ? kRoseDark : kTaupeLight.withOpacity(0.5), width: 2)),
                  child: _isGift ? const Icon(Icons.check_rounded, color: Colors.white, size: 13) : null),
              ]))),
          if (_isGift) ...[
            const SizedBox(height: 12),
            TextField(controller: _giftMsgCtrl, maxLines: 3, style: GoogleFonts.dmSans(color: kTaupeDark, fontSize: 13.5),
              decoration: InputDecoration(hintText: "Write your gift message... (e.g. Happy Birthday! 🎂)",
                hintStyle: GoogleFonts.dmSans(color: kTaupeLight.withOpacity(0.7), fontSize: 13),
                filled: true, fillColor: kIvory, contentPadding: const EdgeInsets.all(14),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: kRoseMid, width: 1.5)))),
            const SizedBox(height: 8),
            Text("🎀 Your message will be printed on a gift card included with the order.", style: GoogleFonts.dmSans(fontSize: 12, color: kTaupeLight, height: 1.4)),
          ],
        ])),
        const SizedBox(height: 14),
        // Payment
        _card(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _secTitle(Icons.payment_outlined, "Payment Method"), const SizedBox(height: 14),
          ...[
            {"id": "cod", "title": "Cash on Delivery", "sub": "Pay when your order arrives", "icon": Icons.money_rounded},
            {"id": "upi", "title": "UPI", "sub": "GPay, PhonePe, Paytm & more", "icon": Icons.account_balance_wallet_rounded},
            {"id": "card", "title": "Credit / Debit Card", "sub": "Visa, Mastercard, RuPay", "icon": Icons.credit_card_rounded},
            {"id": "wallet", "title": "Cookie Cloud Wallet", "sub": "Balance: ₹500", "icon": Icons.wallet_rounded},
          ].map((opt) {
            final isSel = _payment == opt["id"];
            return GestureDetector(onTap: () => setState(() => _payment = opt["id"] as String),
              child: AnimatedContainer(duration: const Duration(milliseconds: 180), margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: isSel ? kRoseDark.withOpacity(0.06) : kIvory, borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: isSel ? kRoseDark : kTaupeLight.withOpacity(0.3), width: isSel ? 1.5 : 1)),
                child: Row(children: [
                  Container(width: 40, height: 40, decoration: BoxDecoration(color: isSel ? kRoseDark : kChampagne.withOpacity(0.6), borderRadius: BorderRadius.circular(10)),
                    child: Icon(opt["icon"] as IconData, color: isSel ? Colors.white : kRoseMid, size: 20)),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(opt["title"] as String, style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 13.5, color: kTaupeDark)),
                    Text(opt["sub"] as String, style: GoogleFonts.dmSans(fontSize: 12, color: kTaupeLight)),
                  ])),
                  AnimatedContainer(duration: const Duration(milliseconds: 180), width: 22, height: 22,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: isSel ? kRoseDark : Colors.transparent, border: Border.all(color: isSel ? kRoseDark : kTaupeLight.withOpacity(0.5), width: 2)),
                    child: isSel ? const Icon(Icons.check_rounded, color: Colors.white, size: 13) : null),
                ])));
          }),
        ])),
        const SizedBox(height: 14),
        // Summary
        _card(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _secTitle(Icons.receipt_long_outlined, "Order Summary"), const SizedBox(height: 14),
          ...uniqueItems.map((item) {
            final qty = qtys[item["name"]] ?? 1;
            return Padding(padding: const EdgeInsets.only(bottom: 10), child: Row(children: [
              ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.network(item["image"], width: 50, height: 50, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(width: 50, height: 50, color: kChampagne))),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(item["name"], style: GoogleFonts.dmSans(fontWeight: FontWeight.w600, fontSize: 13, color: kTaupeDark)),
                Text("× $qty", style: GoogleFonts.dmSans(fontSize: 12, color: kTaupeLight)),
              ])),
              Text("₹${(item["price"] as int) * qty}", style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 13.5, color: kRoseDark)),
            ]));
          }),
          const Divider(color: kChampagne), const SizedBox(height: 8),
          _cRow("Item Total", "₹${widget.subtotal}"), const SizedBox(height: 6),
          _cRow("Delivery", widget.deliveryFee == 0 ? "FREE" : "₹${widget.deliveryFee}", vc: widget.deliveryFee == 0 ? kSuccess : null), const SizedBox(height: 6),
          _cRow("GST (5%)", "₹${widget.gst}"),
          if (widget.discount > 0) ...[const SizedBox(height: 6), _cRow("Coupon Discount", "−₹${widget.discount}", vc: kSuccess)],
          if (_isGift) ...[const SizedBox(height: 6), _cRow("Gift Wrap", "FREE 🎁", vc: kSuccess)],
          const Padding(padding: EdgeInsets.symmetric(vertical: 10), child: Divider(color: kChampagne)),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Total Payable", style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 15, color: kTaupeDark)),
            Text("₹${widget.total}", style: GoogleFonts.dmSans(fontWeight: FontWeight.w800, fontSize: 20, color: kRoseDark)),
          ]),
        ])),
        const SizedBox(height: 22),
        SizedBox(height: 58, child: ElevatedButton(
          onPressed: _placing ? null : _confirm,
          style: ElevatedButton.styleFrom(backgroundColor: kRoseDark, foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
          child: _placing
              ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
              : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.check_circle_outline_rounded, size: 20), const SizedBox(width: 10),
                  Text("Confirm Order • ₹${widget.total}", style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w700))]))),
        const SizedBox(height: 40),
      ]),
    );
  }

  Widget _card(Widget child) => Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: kSurface, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 3))]), child: child);

  Widget _secTitle(IconData icon, String title) => Row(children: [Container(width: 36, height: 36, decoration: BoxDecoration(color: kChampagne.withOpacity(0.6), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: kRoseMid, size: 18)), const SizedBox(width: 10), Text(title, style: GoogleFonts.cormorantGaramond(fontSize: 18, fontWeight: FontWeight.w600, color: kTaupeDark))]);

  Widget _coField(IconData icon, String hint, TextEditingController ctrl, {TextInputType type = TextInputType.text, int lines = 1}) {
    return TextField(controller: ctrl, keyboardType: type, maxLines: lines, style: GoogleFonts.dmSans(color: kTaupeDark, fontSize: 13.5),
      decoration: InputDecoration(hintText: hint, hintStyle: GoogleFonts.dmSans(color: kTaupeLight.withOpacity(0.7), fontSize: 13),
        prefixIcon: Padding(padding: EdgeInsets.only(bottom: lines > 1 ? 24 : 0), child: Icon(icon, color: kRoseLight, size: 18)),
        filled: true, fillColor: kIvory, contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: kRoseMid, width: 1.5)), isDense: true));
  }

  Widget _cRow(String label, String value, {Color? vc}) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Text(label, style: GoogleFonts.dmSans(color: kTaupeLight, fontSize: 13)),
    Text(value, style: GoogleFonts.dmSans(color: vc ?? kTaupeDark, fontWeight: FontWeight.w600, fontSize: 13)),
  ]);
}

// ─── Order History ────────────────────────────────────────────────────────────
class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: kIvory,
      appBar: AppBar(backgroundColor: kIvory, elevation: 0, titleSpacing: 16,
        title: Text("Orders", style: GoogleFonts.cormorantGaramond(fontSize: 26, fontWeight: FontWeight.w600, color: kTaupeDark))),
      body: ValueListenableBuilder<List<Map<String, dynamic>>>(valueListenable: orderHistoryNotifier, builder: (_, orders, __) {
        if (orders.isEmpty) return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text("📦", style: TextStyle(fontSize: 60)), const SizedBox(height: 16),
          Text("No orders yet", style: GoogleFonts.cormorantGaramond(fontSize: 24, fontWeight: FontWeight.w600, color: kTaupeDark)),
          const SizedBox(height: 8), Text("Your order history will appear here", style: GoogleFonts.dmSans(color: kTaupeLight)),
        ]));
        return ListView.builder(padding: const EdgeInsets.fromLTRB(16, 8, 16, 100), itemCount: orders.length, itemBuilder: (_, i) {
          final order = orders[i]; final items = order["items"] as List<Map<String, dynamic>>;
          final isGift = order["isGift"] as bool? ?? false; final giftMsg = order["giftMessage"] as String? ?? "";
          return Container(margin: const EdgeInsets.only(bottom: 14), decoration: BoxDecoration(color: kSurface, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12)]),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(padding: const EdgeInsets.fromLTRB(16, 14, 16, 10), child: Row(children: [
                Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: kSuccess.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Row(children: [const Icon(Icons.check_circle_rounded, color: kSuccess, size: 14), const SizedBox(width: 4), Text("Confirmed", style: GoogleFonts.dmSans(color: kSuccess, fontWeight: FontWeight.w700, fontSize: 12))])),
                if (isGift) ...[const SizedBox(width: 8), Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: kRoseMid.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Text("🎁 Gift", style: GoogleFonts.dmSans(color: kRoseMid, fontWeight: FontWeight.w700, fontSize: 12)))],
                const Spacer(), Text(order["date"] ?? "", style: GoogleFonts.dmSans(color: Colors.grey, fontSize: 12)),
              ])),
              SizedBox(height: 60, child: ListView.builder(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 14), itemCount: items.length,
                itemBuilder: (_, j) => Container(margin: const EdgeInsets.only(right: 8),
                  child: ClipRRect(borderRadius: BorderRadius.circular(10),
                    child: Image.network(items[j]["image"], width: 52, height: 52, fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(width: 52, height: 52, color: kChampagne)))))),
              if (isGift && giftMsg.isNotEmpty) Padding(padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: kGoldLight, borderRadius: BorderRadius.circular(10)),
                  child: Row(children: [const Text("🎀", style: TextStyle(fontSize: 14)), const SizedBox(width: 8),
                    Expanded(child: Text(giftMsg, style: GoogleFonts.dmSans(fontSize: 12, color: kTaupeDark, fontStyle: FontStyle.italic)))]))),
              Padding(padding: const EdgeInsets.fromLTRB(16, 10, 16, 14), child: Row(children: [
                Text("${items.length} item${items.length > 1 ? 's' : ''}", style: GoogleFonts.dmSans(color: kTaupeLight, fontSize: 13)),
                const Spacer(), Text("₹${order["total"]}", style: GoogleFonts.dmSans(fontWeight: FontWeight.w800, fontSize: 15, color: kRoseDark)),
              ])),
              Container(padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
                decoration: BoxDecoration(color: kChampagne.withOpacity(0.4), borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20))),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  _step("Placed", true), _line(), _step("Baking", true), _line(), _step("On Way", false), _line(), _step("Delivered", false),
                ])),
            ]));
        });
      }),
    );
  }

  Widget _step(String label, bool done) => Column(children: [
    Container(width: 24, height: 24, decoration: BoxDecoration(color: done ? kRoseDark : Colors.white, shape: BoxShape.circle, border: Border.all(color: done ? kRoseDark : Colors.grey.shade300, width: 1.5)),
      child: done ? const Icon(Icons.check_rounded, color: Colors.white, size: 13) : null),
    const SizedBox(height: 4), Text(label, style: GoogleFonts.dmSans(fontSize: 9.5, fontWeight: FontWeight.w500, color: done ? kRoseDark : Colors.grey)),
  ]);
  Widget _line() => Expanded(child: Container(height: 1.5, color: Colors.grey.shade200, margin: const EdgeInsets.only(bottom: 16)));
}

// ─── Add Address Screen ───────────────────────────────────────────────────────
class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});
  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _houseCtrl = TextEditingController(); final _streetCtrl = TextEditingController();
  final _cityCtrl = TextEditingController(); final _stateCtrl = TextEditingController();
  final _pincodeCtrl = TextEditingController(); final _landmarkCtrl = TextEditingController();
  final _nameCtrl = TextEditingController(); final _phoneCtrl = TextEditingController();
  String _type = "Home"; String? _error;

  @override
  void dispose() { for (final c in [_houseCtrl, _streetCtrl, _cityCtrl, _stateCtrl, _pincodeCtrl, _landmarkCtrl, _nameCtrl, _phoneCtrl]) c.dispose(); super.dispose(); }

  void _save() {
    if ([_houseCtrl, _streetCtrl, _cityCtrl, _stateCtrl, _pincodeCtrl, _nameCtrl, _phoneCtrl].any((c) => c.text.trim().isEmpty)) {
      setState(() => _error = "Please fill all required fields."); return;
    }
    if (_pincodeCtrl.text.trim().length != 6) { setState(() => _error = "Enter a valid 6-digit pincode."); return; }
    savedAddressesNotifier.value = [...savedAddressesNotifier.value, {"type": _type, "houseNo": _houseCtrl.text.trim(), "street": _streetCtrl.text.trim(), "city": _cityCtrl.text.trim(), "state": _stateCtrl.text.trim(), "pincode": _pincodeCtrl.text.trim(), "landmark": _landmarkCtrl.text.trim(), "name": _nameCtrl.text.trim(), "phone": _phoneCtrl.text.trim(), "isDefault": false}];
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Address saved!", style: GoogleFonts.dmSans(fontWeight: FontWeight.w600)), backgroundColor: kSuccess, behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), margin: const EdgeInsets.fromLTRB(16, 0, 16, 90)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: kIvory,
      appBar: AppBar(backgroundColor: kIvory, elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, color: kTaupeDark, size: 20), onPressed: () => Navigator.pop(context)),
        title: Text("Add New Address", style: GoogleFonts.cormorantGaramond(fontSize: 22, fontWeight: FontWeight.w600, color: kTaupeDark))),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        if (_error != null) ...[Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.red.withOpacity(0.08), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.red.withOpacity(0.25))), child: Row(children: [const Icon(Icons.error_outline_rounded, color: Colors.red, size: 18), const SizedBox(width: 8), Expanded(child: Text(_error!, style: GoogleFonts.dmSans(color: Colors.red, fontSize: 13)))])), const SizedBox(height: 16)],
        Row(children: ["Home", "Office", "Other"].map((t) => GestureDetector(onTap: () => setState(() => _type = t),
          child: AnimatedContainer(duration: const Duration(milliseconds: 180), margin: const EdgeInsets.only(right: 10), padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(color: _type == t ? kRoseDark : kSurface, borderRadius: BorderRadius.circular(10), border: Border.all(color: _type == t ? kRoseDark : kTaupeLight.withOpacity(0.3))),
            child: Text(t, style: GoogleFonts.dmSans(color: _type == t ? Colors.white : kTaupeLight, fontWeight: FontWeight.w600, fontSize: 13))))).toList()),
        const SizedBox(height: 16),
        _af(Icons.person_outline_rounded, "Full Name *", _nameCtrl), const SizedBox(height: 12),
        _af(Icons.phone_outlined, "Phone Number *", _phoneCtrl, type: TextInputType.phone), const SizedBox(height: 12),
        _af(Icons.home_outlined, "House / Flat / Building No. *", _houseCtrl), const SizedBox(height: 12),
        _af(Icons.streetview_rounded, "Street / Area / Colony *", _streetCtrl), const SizedBox(height: 12),
        Row(children: [Expanded(child: _af(Icons.location_city_outlined, "City *", _cityCtrl)), const SizedBox(width: 12), Expanded(child: _af(Icons.map_outlined, "State *", _stateCtrl))]),
        const SizedBox(height: 12),
        Row(children: [Expanded(child: _af(Icons.pin_outlined, "Pincode *", _pincodeCtrl, type: TextInputType.number)), const SizedBox(width: 12), Expanded(child: _af(Icons.place_outlined, "Landmark", _landmarkCtrl))]),
        const SizedBox(height: 24),
        SizedBox(height: 54, child: ElevatedButton(onPressed: _save,
          style: ElevatedButton.styleFrom(backgroundColor: kRoseDark, foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
          child: Text("Save Address", style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w700)))),
      ]),
    );
  }

  Widget _af(IconData icon, String hint, TextEditingController ctrl, {TextInputType type = TextInputType.text}) {
    return TextField(controller: ctrl, keyboardType: type, style: GoogleFonts.dmSans(color: kTaupeDark, fontSize: 13.5),
      decoration: InputDecoration(hintText: hint, hintStyle: GoogleFonts.dmSans(color: kTaupeLight.withOpacity(0.7), fontSize: 13),
        prefixIcon: Icon(icon, color: kRoseLight, size: 18), filled: true, fillColor: kSurface, contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: kRoseMid, width: 1.5)), isDense: true));
  }
}

// ─── Addresses Screen ─────────────────────────────────────────────────────────
class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: kIvory,
      appBar: AppBar(backgroundColor: kIvory, elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, color: kTaupeDark, size: 20), onPressed: () => Navigator.pop(context)),
        title: Text("Delivery Addresses", style: GoogleFonts.cormorantGaramond(fontSize: 22, fontWeight: FontWeight.w600, color: kTaupeDark))),
      body: ValueListenableBuilder<List<Map<String, dynamic>>>(valueListenable: savedAddressesNotifier, builder: (_, addresses, __) {
        return ListView(padding: const EdgeInsets.all(16), children: [
          ...List.generate(addresses.length, (i) {
            final addr = addresses[i]; final isDef = addr["isDefault"] as bool? ?? i == 0;
            final fullAddr = "${addr["houseNo"]}, ${addr["street"]}, ${addr["city"]}, ${addr["state"]} ${addr["pincode"]}";
            return Container(margin: const EdgeInsets.only(bottom: 14), decoration: BoxDecoration(color: kSurface, borderRadius: BorderRadius.circular(18),
              border: Border.all(color: isDef ? kRoseMid.withOpacity(0.6) : Colors.transparent, width: 1.5),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12)]),
              child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Container(width: 38, height: 38, decoration: BoxDecoration(color: isDef ? kRoseDark : kChampagne.withOpacity(0.6), borderRadius: BorderRadius.circular(10)),
                    child: Icon(addr["type"] == "Home" ? Icons.home_rounded : addr["type"] == "Office" ? Icons.business_rounded : Icons.place_rounded, color: isDef ? Colors.white : kRoseMid, size: 20)),
                  const SizedBox(width: 10), Text(addr["type"], style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 15, color: kTaupeDark)), const Spacer(),
                  if (isDef) Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: kSuccess.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                    child: Text("Default", style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w700, color: kSuccess))),
                ]),
                const SizedBox(height: 10),
                Text(addr["name"] ?? "", style: GoogleFonts.dmSans(fontWeight: FontWeight.w600, fontSize: 13, color: kTaupeDark)),
                const SizedBox(height: 3), Text(fullAddr, style: GoogleFonts.dmSans(fontSize: 13, color: kTaupeLight, height: 1.4)),
                if ((addr["landmark"] as String?)?.isNotEmpty == true) ...[const SizedBox(height: 2), Text("Near: ${addr["landmark"]}", style: GoogleFonts.dmSans(fontSize: 12, color: kTaupeLight))],
                const SizedBox(height: 3), Text(addr["phone"] ?? "", style: GoogleFonts.dmSans(fontSize: 12, color: kTaupeLight)),
                if (!isDef) ...[const SizedBox(height: 10), GestureDetector(
                  onTap: () { final u = List<Map<String, dynamic>>.from(savedAddressesNotifier.value).map((a) => {...a, "isDefault": false}).toList(); u[i]["isDefault"] = true; savedAddressesNotifier.value = u; },
                  child: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7), decoration: BoxDecoration(color: kRoseDark, borderRadius: BorderRadius.circular(8)),
                    child: Text("Set as Default", style: GoogleFonts.dmSans(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600))))],
              ])));
          }),
          GestureDetector(onTap: () => Navigator.push(context, _fadeRoute(const AddAddressScreen())),
            child: Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: kSurface, borderRadius: BorderRadius.circular(18), border: Border.all(color: kRoseMid.withOpacity(0.3), width: 1.5), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(width: 38, height: 38, decoration: BoxDecoration(color: kRoseDark.withOpacity(0.1), shape: BoxShape.circle), child: const Icon(Icons.add_rounded, color: kRoseDark, size: 22)),
                const SizedBox(width: 10), Text("Add New Address", style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 14, color: kRoseDark)),
              ]))),
        ]);
      }),
    );
  }
}

// ─── Payment Screen ───────────────────────────────────────────────────────────
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? _tab;
  final _cardNumCtrl = TextEditingController(); final _cardNameCtrl = TextEditingController();
  final _expiryCtrl = TextEditingController(); final _cvvCtrl = TextEditingController();
  final _accNumCtrl = TextEditingController(); final _ifscCtrl = TextEditingController();
  final _bankNameCtrl = TextEditingController(); final _accHolderCtrl = TextEditingController();
  final _upiCtrl = TextEditingController();
  String? _formErr;

  @override
  void dispose() { for (final c in [_cardNumCtrl, _cardNameCtrl, _expiryCtrl, _cvvCtrl, _accNumCtrl, _ifscCtrl, _bankNameCtrl, _accHolderCtrl, _upiCtrl]) c.dispose(); super.dispose(); }

  void _saveCard() {
    if (_cardNumCtrl.text.trim().length < 16 || _cardNameCtrl.text.trim().isEmpty || _expiryCtrl.text.trim().isEmpty || _cvvCtrl.text.trim().length < 3) { setState(() => _formErr = "Please enter valid card details."); return; }
    savedPaymentsNotifier.value = [...savedPaymentsNotifier.value, {"type": "card", "label": "•••• ${_cardNumCtrl.text.trim().substring(_cardNumCtrl.text.trim().length - 4)}", "name": _cardNameCtrl.text.trim(), "icon": "💳"}];
    setState(() { _tab = null; _formErr = null; }); for (final c in [_cardNumCtrl, _cardNameCtrl, _expiryCtrl, _cvvCtrl]) c.clear();
    _snack("Card added!");
  }

  void _saveBank() {
    if ([_accNumCtrl, _ifscCtrl, _bankNameCtrl, _accHolderCtrl].any((c) => c.text.trim().isEmpty)) { setState(() => _formErr = "Please enter all bank details."); return; }
    savedPaymentsNotifier.value = [...savedPaymentsNotifier.value, {"type": "bank", "label": "${_bankNameCtrl.text.trim()} A/C", "name": _accHolderCtrl.text.trim(), "icon": "🏦"}];
    setState(() { _tab = null; _formErr = null; }); for (final c in [_accNumCtrl, _ifscCtrl, _bankNameCtrl, _accHolderCtrl]) c.clear();
    _snack("Bank details added!");
  }

  void _saveUpi() {
    final u = _upiCtrl.text.trim();
    if (u.isEmpty || !u.contains('@')) { setState(() => _formErr = "Enter a valid UPI ID (e.g. name@upi)."); return; }
    savedPaymentsNotifier.value = [...savedPaymentsNotifier.value, {"type": "upi", "label": u, "name": "", "icon": "📲"}];
    setState(() { _tab = null; _formErr = null; }); _upiCtrl.clear();
    _snack("UPI ID added!");
  }

  void _snack(String msg) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg, style: GoogleFonts.dmSans(fontWeight: FontWeight.w600)), backgroundColor: kSuccess, behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), margin: const EdgeInsets.fromLTRB(16, 0, 16, 90)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: kIvory,
      appBar: AppBar(backgroundColor: kIvory, elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, color: kTaupeDark, size: 20),
          onPressed: () { if (_tab != null) { setState(() { _tab = null; _formErr = null; }); } else { Navigator.pop(context); } }),
        title: Text(_tab == null ? "Payment Methods" : _tab == 'card' ? "Add Bank Card" : _tab == 'bank' ? "Add Bank Details" : "Add UPI ID",
          style: GoogleFonts.cormorantGaramond(fontSize: 22, fontWeight: FontWeight.w600, color: kTaupeDark))),
      body: _tab == null ? _list() : _tab == 'card' ? _cardForm() : _tab == 'bank' ? _bankForm() : _upiForm(),
    );
  }

  Widget _list() => ValueListenableBuilder<List<Map<String, dynamic>>>(valueListenable: savedPaymentsNotifier, builder: (_, payments, __) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (payments.isNotEmpty) ...[
          Text("Saved Methods", style: GoogleFonts.cormorantGaramond(fontSize: 18, fontWeight: FontWeight.w600, color: kTaupeDark)),
          const SizedBox(height: 12),
          ...payments.map((p) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: kSurface,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8)
                    ]),
                child: Row(children: [
                  Text(p["icon"], style: const TextStyle(fontSize: 28)),
                  const SizedBox(width: 14),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p["label"],
                            style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: kTaupeDark)),
                        if ((p["name"] as String).isNotEmpty)
                          Text(p["name"],
                              style: GoogleFonts.dmSans(
                                  fontSize: 12, color: kTaupeLight))
                      ])
                ]))),
          const SizedBox(height: 20),
          Text("Add New Method", style: GoogleFonts.cormorantGaramond(fontSize: 18, fontWeight: FontWeight.w600, color: kTaupeDark)),
          const SizedBox(height: 12),
        ],
        ...[
          {"tab": "card", "icon": "💳", "title": "Add Bank Card", "sub": "Visa, Mastercard, RuPay"},
          {"tab": "bank", "icon": "🏦", "title": "Add Bank Details", "sub": "Account number & IFSC"},
          {"tab": "upi", "icon": "📲", "title": "Add UPI ID", "sub": "GPay, PhonePe, Paytm"},
        ].map((item) => GestureDetector(
              onTap: () => setState(() {
                _tab = item["tab"];
                _formErr = null;
              }),
              child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: kSurface,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8)
                      ]),
                  child: Row(children: [
                    Text(item["icon"]!,
                        style: const TextStyle(fontSize: 28)),
                    const SizedBox(width: 14),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text(item["title"]!,
                              style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: kTaupeDark)),
                          Text(item["sub"]!,
                              style: GoogleFonts.dmSans(
                                  fontSize: 12, color: kTaupeLight))
                        ])),
                    const Icon(Icons.chevron_right_rounded, color: Colors.grey)
                  ]))),
        ),
      ],
    );
  });

  Widget _errBanner() => _formErr == null ? const SizedBox() : Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: Colors.red.withOpacity(0.08), borderRadius: BorderRadius.circular(12)),
    child: Text(_formErr!, style: GoogleFonts.dmSans(color: Colors.red, fontSize: 13)));

  Widget _cardForm() => ListView(padding: const EdgeInsets.all(16), children: [
    _errBanner(),
    _pf(Icons.credit_card_rounded, "Card Number *", _cardNumCtrl, type: TextInputType.number, maxLen: 19), const SizedBox(height: 12),
    _pf(Icons.person_outline_rounded, "Name on Card *", _cardNameCtrl), const SizedBox(height: 12),
    Row(children: [Expanded(child: _pf(Icons.calendar_today_outlined, "MM/YY *", _expiryCtrl)), const SizedBox(width: 12), Expanded(child: _pf(Icons.lock_outline_rounded, "CVV *", _cvvCtrl, type: TextInputType.number, maxLen: 4, obscure: true))]),
    const SizedBox(height: 24),
    SizedBox(height: 54, child: ElevatedButton(onPressed: _saveCard, style: ElevatedButton.styleFrom(backgroundColor: kRoseDark, foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), child: Text("Save Card", style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w700)))),
  ]);

  Widget _bankForm() => ListView(padding: const EdgeInsets.all(16), children: [
    _errBanner(),
    _pf(Icons.account_balance_outlined, "Bank Name *", _bankNameCtrl), const SizedBox(height: 12),
    _pf(Icons.person_outline_rounded, "Account Holder Name *", _accHolderCtrl), const SizedBox(height: 12),
    _pf(Icons.numbers_rounded, "Account Number *", _accNumCtrl, type: TextInputType.number), const SizedBox(height: 12),
    _pf(Icons.code_rounded, "IFSC Code *", _ifscCtrl), const SizedBox(height: 24),
    SizedBox(height: 54, child: ElevatedButton(onPressed: _saveBank, style: ElevatedButton.styleFrom(backgroundColor: kRoseDark, foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), child: Text("Save Bank Details", style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w700)))),
  ]);

  Widget _upiForm() => ListView(padding: const EdgeInsets.all(16), children: [
    _errBanner(),
    Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: kGoldLight, borderRadius: BorderRadius.circular(14)),
      child: Text("Enter your UPI ID: yourname@bankname\nE.g. nandini@okicici, 9876543210@paytm", style: GoogleFonts.dmSans(fontSize: 13, color: kTaupeDark, height: 1.5))),
    const SizedBox(height: 16),
    _pf(Icons.account_balance_wallet_outlined, "UPI ID *", _upiCtrl, type: TextInputType.emailAddress), const SizedBox(height: 24),
    SizedBox(height: 54, child: ElevatedButton(onPressed: _saveUpi, style: ElevatedButton.styleFrom(backgroundColor: kRoseDark, foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), child: Text("Save UPI ID", style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w700)))),
  ]);

  Widget _pf(IconData icon, String hint, TextEditingController ctrl, {TextInputType type = TextInputType.text, int? maxLen, bool obscure = false}) {
    return TextField(controller: ctrl, keyboardType: type, obscureText: obscure, maxLength: maxLen, style: GoogleFonts.dmSans(color: kTaupeDark, fontSize: 13.5),
      decoration: InputDecoration(hintText: hint, hintStyle: GoogleFonts.dmSans(color: kTaupeLight.withOpacity(0.7), fontSize: 13),
        prefixIcon: Icon(icon, color: kRoseLight, size: 18), filled: true, fillColor: kSurface, contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: kRoseMid, width: 1.5)), counterText: "", isDense: true));
  }
}

// ─── Help & Support Screen ────────────────────────────────────────────────────
class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final contacts = [
      {"icon": "📞", "label": "Phone", "value": "8882626610", "sub": "Mon–Sat, 9 AM – 6 PM"},
      {"icon": "📧", "label": "Personal Email", "value": "nandini9348@gmail.com", "sub": "Personal queries"},
      {"icon": "💬", "label": "Support Email", "value": "support@cookiecloud.in", "sub": "Order & delivery support"},
      {"icon": "📸", "label": "Instagram", "value": "@cookiecloudofficial", "sub": "DM us anytime"},
    ];
    return Scaffold(backgroundColor: kIvory,
      appBar: AppBar(backgroundColor: kIvory, elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, color: kTaupeDark, size: 20), onPressed: () => Navigator.pop(context)),
        title: Text("Help & Support", style: GoogleFonts.cormorantGaramond(fontSize: 22, fontWeight: FontWeight.w600, color: kTaupeDark))),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(gradient: const LinearGradient(colors: [kRoseDark, Color(0xFFC8938A)]), borderRadius: BorderRadius.circular(20)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text("🍪", style: TextStyle(fontSize: 36)), const SizedBox(height: 8),
            Text("Cookie Cloud Support", style: GoogleFonts.cormorantGaramond(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white)),
            Text("We're here to help! Reach us through any of the channels below.", style: GoogleFonts.dmSans(fontSize: 13, color: Colors.white70, height: 1.5))])),
        const SizedBox(height: 20),
        ...contacts.map((c) => Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: kSurface, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)]),
          child: Row(children: [
            Container(width: 48, height: 48, decoration: BoxDecoration(color: kChampagne.withOpacity(0.6), borderRadius: BorderRadius.circular(12)),
              child: Center(child: Text(c["icon"]!, style: const TextStyle(fontSize: 24)))),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(c["label"]!, style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 13, color: kTaupeLight)),
              Text(c["value"]!, style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 15, color: kTaupeDark)),
              Text(c["sub"]!, style: GoogleFonts.dmSans(fontSize: 12, color: kTaupeLight)),
            ])),
          ]))),
        const SizedBox(height: 20),
        Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: kGoldLight, borderRadius: BorderRadius.circular(16), border: Border.all(color: kGold.withOpacity(0.3))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("FAQ", style: GoogleFonts.cormorantGaramond(fontSize: 18, fontWeight: FontWeight.w600, color: kTaupeDark)),
            const SizedBox(height: 12),
            ...[
              ["What are your delivery hours?", "We deliver daily from 9 AM to 9 PM."],
              ["How long does delivery take?", "Usually 30–60 mins depending on your location and item."],
              ["Do you offer eggless options?", "Yes! Many items are eggless. Check the 🌱 badge on item detail pages."],
              ["Can I modify my order?", "Contact us within 5 minutes of placing the order via phone or email."],
              ["What if my order arrives damaged?", "Email support@cookiecloud.in within 2 hours with a photo. We'll make it right!"],
            ].map((faq) => Padding(padding: const EdgeInsets.only(bottom: 12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Q: ${faq[0]}", style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 13, color: kTaupeDark)),
              const SizedBox(height: 4),
              Text("A: ${faq[1]}", style: GoogleFonts.dmSans(fontSize: 13, color: kTaupeLight, height: 1.4)),
            ]))),
          ])),
        const SizedBox(height: 40),
      ]),
    );
  }
}

// ─── Wishlist Screen ──────────────────────────────────────────────────────────
class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: kIvory,
      appBar: AppBar(backgroundColor: kIvory, elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, color: kTaupeDark, size: 20), onPressed: () => Navigator.pop(context)),
        title: Text("My Wishlist", style: GoogleFonts.cormorantGaramond(fontSize: 24, fontWeight: FontWeight.w600, color: kTaupeDark))),
      body: ValueListenableBuilder<Set<String>>(valueListenable: wishlistNotifier, builder: (_, wl, __) {
        final items = products.where((p) => wl.contains(p["name"])).toList();
        if (items.isEmpty) return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Text("🤍", style: TextStyle(fontSize: 60)), const SizedBox(height: 16), Text("Your wishlist is empty", style: GoogleFonts.cormorantGaramond(fontSize: 22, fontWeight: FontWeight.w600, color: kTaupeDark)), const SizedBox(height: 8), Text("Save items you love!", style: GoogleFonts.dmSans(color: kTaupeLight))]));
        return GridView.builder(padding: const EdgeInsets.fromLTRB(16, 8, 16, 100), itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.72, crossAxisSpacing: 12, mainAxisSpacing: 12),
          itemBuilder: (_, i) => _ProductCard(product: items[i]));
      }),
    );
  }
}

// ─── Profile Screen ───────────────────────────────────────────────────────────
class ProfileScreen extends StatelessWidget {
  final void Function(int) onNavigate;
  const ProfileScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final user = UserStore.getUser(_loggedInEmail);
    final name = user?['name'] ?? 'Guest';
    final email = user?['email'] ?? _loggedInEmail;
    final phone = user?['phone'] ?? '';
    final initial = name.isNotEmpty ? name[0].toUpperCase() : 'G';

    return Scaffold(backgroundColor: kIvory, body: CustomScrollView(slivers: [
      SliverToBoxAdapter(child: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [kRoseDark, Color(0xFFC8938A)]), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32))),
        padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).padding.top + 16, 20, 28),
        child: Column(children: [
          Container(width: 80, height: 80, decoration: BoxDecoration(shape: BoxShape.circle, color: kGold.withOpacity(0.25), border: Border.all(color: kGold.withOpacity(0.6), width: 2)),
            child: Center(child: Text(initial, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: kGold)))),
          const SizedBox(height: 12),
          Text(name, style: GoogleFonts.cormorantGaramond(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white)),
          const SizedBox(height: 2), Text(email, style: GoogleFonts.dmSans(color: Colors.white60, fontSize: 13)),
          if (phone.isNotEmpty) ...[const SizedBox(height: 2), Text(phone, style: GoogleFonts.dmSans(color: Colors.white60, fontSize: 12))],
          const SizedBox(height: 16),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ValueListenableBuilder<List<Map<String, dynamic>>>(valueListenable: orderHistoryNotifier, builder: (_, o, __) => _stat("${o.length}", "Orders")),
            const SizedBox(width: 20),
            ValueListenableBuilder<Set<String>>(valueListenable: wishlistNotifier, builder: (_, w, __) => _stat("${w.length}", "Wishlist")),
            const SizedBox(width: 20), _stat("4.9", "Rating"),
          ]),
        ]),
      )),
      SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(16, 24, 16, 8), child: Column(children: [
        _tile(Icons.shopping_bag_outlined, "My Orders", "Track your orders", onTap: () => onNavigate(3)),
        _tile(Icons.favorite_border_rounded, "Wishlist", "Saved for later", onTap: () => Navigator.push(context, _fadeRoute(const WishlistScreen()))),
        _tile(Icons.location_on_outlined, "Addresses", "Manage delivery addresses", onTap: () => Navigator.push(context, _fadeRoute(const AddressesScreen()))),
        _tile(Icons.payment_outlined, "Payment Methods", "Cards, UPI & bank details", onTap: () => Navigator.push(context, _fadeRoute(const PaymentScreen()))),
        _tile(Icons.help_outline_rounded, "Help & Support", "FAQs & contact us", onTap: () => Navigator.push(context, _fadeRoute(const HelpSupportScreen()))),
        const SizedBox(height: 16),
        SizedBox(width: double.infinity, height: 50, child: OutlinedButton(
          onPressed: () { _loggedInEmail = ''; Navigator.pushReplacement(context, _fadeRoute(const LoginPage())); },
          style: OutlinedButton.styleFrom(foregroundColor: Colors.red, side: const BorderSide(color: Colors.red), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
          child: Text("Sign Out", style: GoogleFonts.dmSans(fontWeight: FontWeight.w700)))),
        const SizedBox(height: 100),
      ]))),
    ]));
  }

  static Widget _stat(String v, String l) => Column(children: [
    Text(v, style: GoogleFonts.cormorantGaramond(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white)),
    Text(l, style: GoogleFonts.dmSans(fontSize: 11, color: Colors.white60)),
  ]);

  static Widget _tile(IconData icon, String title, String sub, {required VoidCallback onTap}) {
    return Container(margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: kSurface, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
      child: ListTile(onTap: onTap,
        leading: Container(width: 40, height: 40, decoration: BoxDecoration(color: kChampagne.withOpacity(0.6), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: kRoseMid, size: 20)),
        title: Text(title, style: GoogleFonts.dmSans(fontWeight: FontWeight.w600, fontSize: 14, color: kTaupeDark)),
        subtitle: Text(sub, style: GoogleFonts.dmSans(fontSize: 12, color: kTaupeLight)),
        trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey, size: 20),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))));
  }
}