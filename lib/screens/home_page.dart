import 'package:coffeshop_ui/screens/cart_page.dart';
import 'package:coffeshop_ui/screens/order_history_page.dart';
import 'package:coffeshop_ui/screens/product_detail_page.dart';
import 'package:coffeshop_ui/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> coffeeMenu = const [
    {
      'name': 'Espresso',
      'price': 'IDR 25.000',
      'image': 'assets/images/espresso.jpeg',
    },
    {
      'name': 'Cappuccino',
      'price': 'IDR 30.000',
      'image': 'assets/images/cappuccino.jpeg',
    },
    {
      'name': 'Latte',
      'price': 'IDR 28.000',
      'image': 'assets/images/machiato.jpeg',
    },
  ];

  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      Center(
        child: Scaffold(
          backgroundColor: const Color(0xffF3E5AB),

          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: const Text(
              'Baltivers Coffee',
              style: TextStyle(
                color: Color(0xff6C9A8B),
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout, color: Color(0xfff9f4ee)),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ZoomIn(
                  duration: const Duration(milliseconds: 700),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/banner.jpg',
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FadeInDown(
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    'Daily Special',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[900],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.9,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: coffeeMenu.length,
                  itemBuilder: (context, index) {
                    final item = coffeeMenu[index];
                    return FadeInUp(
                      duration: Duration(milliseconds: 400 + index * 100),
                      child: Card(
                        color: Color(0xffF3E5AB),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Color(0xff4B2E2B)),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            Navigator.of(context).push(
                              _createRoute(
                                ProductDetailPage(
                                  name: item['name'],
                                  image: item['image'],
                                  price: item['price'],
                                  description:
                                      'A delicious and fresh ${item['name']} made with premium beans and perfect aroma.',
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Jangan gunakan Expanded di sini
                                Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: Image.asset(
                                      item['image'],
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height *
                                          0.1,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  item['name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff4B2E2B),
                                    fontSize: 16,
                                  ),
                                ),
                                const Spacer(), // dorong ke bawah
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item['price'],
                                      style: TextStyle(
                                        color: Color(0xff4B2E2B),
                                      ),
                                    ),
                                    IconButton(
                                      style: IconButton.styleFrom(
                                        backgroundColor: Color(0xff6C9A8B),
                                      ),
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.add,
                                        color: Color(0xffF3E5AB),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      Center(child: CartPage()),
      Center(
        child: OrderHistoryPage(
          orderHistory: [
            {
              'id': 1,
              'date': '2025-06-09',
              'total': 75000,
              'address': 'Jl. Kopi No. 12, Bandung',
              'notes': 'Tanpa gula',
              'items': [
                {'name': 'Espresso', 'price': 25000, 'quantity': 2},
                {'name': 'Latte', 'price': 25000, 'quantity': 1},
              ],
            },
            {
              'id': 2,
              'date': '2025-06-01',
              'total': 25000,
              'address': '',
              'notes': '',
              'items': [
                {'name': 'Cappuccino', 'price': 25000, 'quantity': 1},
              ],
            },
          ],
        ),
      ),
      Center(
        child: ProfilePage(
          name: "Iqbaaleff",
          email: "iqbaalfadillah19@gmail.com",
        ),
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: Color(0xff6C9A8B),

        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.shopping_cart),
        title: ("Cart"),
        activeColorPrimary: Color(0xff6C9A8B),

        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.history),
        title: ("Order History"),
        activeColorPrimary: Color(0xff6C9A8B),

        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: ("Profile"),
        activeColorPrimary: Color(0xff6C9A8B),

        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineToSafeArea: true,
      backgroundColor: Color(0xffF3E5AB),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      navBarStyle: NavBarStyle.style12,
    );
  }

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
