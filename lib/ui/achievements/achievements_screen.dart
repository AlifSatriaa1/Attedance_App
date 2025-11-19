import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  final CollectionReference dataCollection =
      FirebaseFirestore.instance.collection('attendance');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF1A008F),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text(
          "Achievements & Badges",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: dataCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF1A008F)),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.emoji_events, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    "No achievements yet",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Start attending to unlock badges!",
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                ],
              ),
            );
          }

          // Calculate achievements
          var docs = snapshot.data!.docs;
          Map<String, Map<String, dynamic>> userStats = {};

          for (var doc in docs) {
            var data = doc.data() as Map<String, dynamic>;
            var name = data['name'] ?? 'Unknown';
            var description = data['description'] ?? '';

            if (!userStats.containsKey(name)) {
              userStats[name] = {
                'total': 0,
                'attend': 0,
                'late': 0,
                'streak': 0,
              };
            }

            userStats[name]!['total']++;
            if (description == 'Attend') {
              userStats[name]!['attend']++;
            } else if (description == 'Late') {
              userStats[name]!['late']++;
            }
          }

          // Define achievements
          List<Map<String, dynamic>> achievements = [
            {
              'title': 'First Step',
              'description': 'Complete your first check-in',
              'icon': Icons.flag,
              'color': const Color(0xFF4CAF50),
              'requirement': 1,
              'type': 'total',
            },
            {
              'title': 'Getting Started',
              'description': 'Check in 5 times',
              'icon': Icons.star,
              'color': const Color(0xFF2196F3),
              'requirement': 5,
              'type': 'total',
            },
            {
              'title': 'Committed',
              'description': 'Check in 10 times',
              'icon': Icons.workspace_premium,
              'color': const Color(0xFF9C27B0),
              'requirement': 10,
              'type': 'total',
            },
            {
              'title': 'Dedicated',
              'description': 'Check in 20 times',
              'icon': Icons.military_tech,
              'color': const Color(0xFFFF9800),
              'requirement': 20,
              'type': 'total',
            },
            {
              'title': 'Perfect Attendance',
              'description': 'Never late for 10 check-ins',
              'icon': Icons.verified,
              'color': const Color(0xFF4CAF50),
              'requirement': 10,
              'type': 'attend',
            },
            {
              'title': 'Punctuality Master',
              'description': 'On time for 20 check-ins',
              'icon': Icons.access_time,
              'color': const Color(0xFF00BCD4),
              'requirement': 20,
              'type': 'attend',
            },
            {
              'title': 'Legend',
              'description': 'Check in 50 times',
              'icon': Icons.emoji_events,
              'color': Colors.amber,
              'requirement': 50,
              'type': 'total',
            },
          ];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Card
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.emoji_events,
                          color: Colors.white,
                          size: 48,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Your Achievements",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${_getUnlockedCount(userStats, achievements)} of ${achievements.length} unlocked",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Achievements Grid
                const Text(
                  "All Badges",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A008F),
                  ),
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: achievements.length,
                  itemBuilder: (context, index) {
                    var achievement = achievements[index];
                    bool isUnlocked = _isAchievementUnlocked(
                      userStats,
                      achievement,
                    );
                    return _buildAchievementCard(achievement, isUnlocked);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  int _getUnlockedCount(
    Map<String, Map<String, dynamic>> userStats,
    List<Map<String, dynamic>> achievements,
  ) {
    int count = 0;
    for (var achievement in achievements) {
      if (_isAchievementUnlocked(userStats, achievement)) {
        count++;
      }
    }
    return count;
  }

  bool _isAchievementUnlocked(
    Map<String, Map<String, dynamic>> userStats,
    Map<String, dynamic> achievement,
  ) {
    if (userStats.isEmpty) return false;

    // Get max stats from all users
    int maxValue = 0;
    for (var stats in userStats.values) {
      int value = stats[achievement['type']] ?? 0;
      if (value > maxValue) maxValue = value;
    }

    return maxValue >= achievement['requirement'];
  }

  Widget _buildAchievementCard(
    Map<String, dynamic> achievement,
    bool isUnlocked,
  ) {
    return Card(
      elevation: isUnlocked ? 4 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: isUnlocked
              ? LinearGradient(
                  colors: [
                    (achievement['color'] as Color).withOpacity(0.8),
                    achievement['color'] as Color,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isUnlocked ? null : Colors.grey[200],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Badge Icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: isUnlocked
                    ? Colors.white.withOpacity(0.3)
                    : Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: Icon(
                achievement['icon'] as IconData,
                size: 40,
                color: isUnlocked ? Colors.white : Colors.grey[500],
              ),
            ),
            const SizedBox(height: 12),

            // Title
            Text(
              achievement['title'] as String,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isUnlocked ? Colors.white : Colors.grey[700],
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),

            // Description
            Text(
              achievement['description'] as String,
              style: TextStyle(
                fontSize: 12,
                color: isUnlocked ? Colors.white.withOpacity(0.9) : Colors.grey[600],
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),

            // Status
            if (!isUnlocked)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Locked",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            else
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Unlocked!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
