import 'package:event_booking_app/features/booking/presentation/screens/booking_history.dart';
import 'package:event_booking_app/features/home/presentation/providers/theme_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import '../providers/home_event_list_provider.dart';

class HomeEventListScreen extends ConsumerStatefulWidget {
  const HomeEventListScreen({super.key});

  @override
  ConsumerState<HomeEventListScreen> createState() =>
      _HomeEventListScreenState();
}

class _HomeEventListScreenState extends ConsumerState<HomeEventListScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final eventsAsync = ref.watch(homeEventListViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const Center(child: FlutterLogo(size: 40)),
        title: Text(
          _selectedIndex == 0 ? "Upcoming Events" : "Booking History",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.dark_mode),
            onPressed: () {
              ref.read(themeNotifierProvider.notifier).toggleTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showLogoutConfirmation(context),
          ),
        ],
      ),
      body: _selectedIndex == 0
          ? eventsAsync.when(
              data: (events) => GridView.builder(
                padding: const EdgeInsets.all(4),
                itemCount: events.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 6,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (_, i) {
                  final e = events[i];
                  return GestureDetector(
                    onTap: () {
                      context.push(
                        '/event-detail',
                        extra: {
                          'event': e,
                          'title': e.title,
                          'date': e.date,
                          'location': e.location,
                          'image': e.thumbnail,
                          'description': e.description,
                          'isBooked': false,
                          'seatNumbers': [''],
                          'bookingDate': ''
                        },
                      );
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 10,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      shadowColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? const Color.fromARGB(60, 233, 225, 225)
                              : Colors.black26,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white24
                              : Colors.grey.shade300,
                          width: 1.2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Image.asset(
                                e.thumbnail,
                                height: 140,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "\$${e.price.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              e.title,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: Wrap(
                              spacing: 10,
                              runSpacing: 4,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.calendar_today,
                                        size: 10, color: Colors.grey),
                                    SizedBox(width: 4),
                                  ],
                                ),
                                Text(
                                  e.date,
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 9),
                                ),
                                const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.location_on,
                                        size: 10, color: Colors.grey),
                                    SizedBox(width: 4),
                                  ],
                                ),
                                Text(
                                  e.location,
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 9),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text("Error: $e")),
            )
          : BookingHistoryScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.deepOrangeAccent,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showModalBottomSheet(
      elevation: 10,
      context: context,
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.white30),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Theme.of(context).cardColor,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.logout, size: 36, color: Colors.red),
              const SizedBox(height: 12),
              const Text(
                'Are you sure you want to logout?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context), // cancel
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        _logout(context);
                      },
                      child: const Text('Logout'),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  void _logout(BuildContext context) {
    final storage = GetStorage();
    storage.erase(); // Clear all data
    context.go('/login'); // Navigate to login
  }
}
