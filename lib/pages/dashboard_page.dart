import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/announcement_item.dart';
import '../models/dashboardcards.dart';
import '../models/event_item.dart';
import 'dashboard_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  String _userEmail = ''; // To store and display the user's email.

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _userEmail = prefs.getString('userEmail') ??
        ''; // Default to empty string if null.
    setState(() {}); // Refresh the UI to show the email.
  }

  // Example data for dashboard cards (replace with actual data)
  final List<DashboardCardData> _dashboardCards = [
    DashboardCardData(
      title: 'Total Members',
      count: 150, // Replace with actual member count from database
      icon: Icons.people,
      color: Colors.blue,
    ),
    DashboardCardData(
      title: 'Upcoming Events',
      count: 5, // Replace with actual event count
      icon: Icons.event,
      color: Colors.green,
    ),
    DashboardCardData(
      title: 'Visits Scheduled',
      count: 10, // Replace with actual visit count
      icon: Icons.location_on,
      color: Colors.orange,
    ),
    DashboardCardData(
      title: 'Prayer Requests',
      count: 20, // Replace with actual prayer request count
      icon: Icons.favorite,
      color: Colors.purple,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _logout(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Welcome, $_userEmail!', // Display the user's email here.
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.0, // Ensure cards are square-shaped
                ),
                itemCount: _dashboardCards.length,
                shrinkWrap: true,
                physics:
                const NeverScrollableScrollPhysics(), // Disable grid view scrolling
                itemBuilder: (context, index) {
                  final cardData = _dashboardCards[index];
                  return DashboardCard(cardData: cardData);
                },
              ),
              const SizedBox(height: 20),
              // Add other dashboard sections here (e.g., upcoming events, recent activities)
              _buildUpcomingEventsSection(),
              _buildAnnouncementsSection(),
            ],
          ),
        ),
      ),
    );
  }

  // Function to handle logout
  Future<void> _logout(BuildContext context) async {
    // Clear login status
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('userEmail'); // Remove user email
    // Navigate to login page
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  // Example of an upcoming events section
  Widget _buildUpcomingEventsSection() {
    // Sample upcoming events data (replace with actual data from database)
    final List<EventItem> upcomingEvents = [
      EventItem(
        title: 'Sunday Service',
        date: DateTime.parse('2024-07-28 10:00:00'),
        location: 'Main Sanctuary',
      ),
      EventItem(
        title: 'Bible Study',
        date: DateTime.parse('2024-07-30 19:00:00'),
        location: 'Fellowship Hall',
      ),
      EventItem(
        title: 'Youth Meeting',
        date: DateTime.parse('2024-08-02 18:00:00'),
        location: 'Youth Center',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upcoming Events',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        // Use a ListView.builder for the list of events
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(), // Disable list view scrolling
          itemCount: upcomingEvents.length,
          itemBuilder: (context, index) {
            final event = upcomingEvents[index];
            // Use the intl package's DateFormat to format the date
            final formattedDate = DateFormat('MMM dd, yyyy, h:mm a').format(event.date);
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align items to the start
                  children: [
                    const Icon(Icons.event, color: Colors.blue), // Add an event icon
                    const SizedBox(width: 10),
                    Expanded( // Use Expanded to take up remaining space
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.title,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            formattedDate,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          Text(
                            'Location: ${event.location}',
                            style: const TextStyle(color: Colors.grey),
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
      ],
    );
  }

  Widget _buildAnnouncementsSection() {
    // Sample announcement data (replace with actual data from database)
    final List<AnnouncementItem> announcements = [
      AnnouncementItem(
        title: 'New Church Website',
        date: DateTime.parse('2024-07-25'),
        content: 'Our new website is live! Visit us at www.example.com.',
      ),
      AnnouncementItem(
        title: 'Special Prayer Meeting',
        date: DateTime.parse('2024-07-28'),
        content: 'Join us for a special prayer meeting next Sunday at 7 PM.',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Announcements',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: announcements.length,
          itemBuilder: (context, index) {
            final announcement = announcements[index];
            final formattedDate = DateFormat('MMM dd, yyyy').format(announcement.date);
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      announcement.title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      formattedDate,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      announcement.content,
                      style: const TextStyle(color: Colors.black87),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}