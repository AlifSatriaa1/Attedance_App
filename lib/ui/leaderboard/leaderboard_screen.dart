import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
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
          "Leaderboard",
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
                    "No leaderboard data yet",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          }

          // Calculate user statistics
          Map<String, Map<String, dynamic>> userStats = {};

          for (var doc in snapshot.data!.docs) {
            var data = doc.data() as Map<String, dynamic>;
            var name = data['name'] ?? 'Unknown';
            var description = data['description'] ?? '';

            if (!userStats.containsKey(name)) {
              userStats[name] = {
                'total': 0,
                'attend': 0,
                'late': 0,
                'sick': 0,
                'permission': 0,
                'score': 0,
              };
            }

            userStats[name]!['total']++;

            switch (description) {
              case 'Attend':
                userStats[name]!['attend']++;
                userStats[name]!['score'] += 10; // 10 points for on-time
                break;
              case 'Late':
                userStats[name]!['late']++;
                userStats[name]!['score'] += 5; // 5 points for late
                break;
              case 'Sick':
                userStats[name]!['sick']++;
                userStats[name]!['score'] += 2; // 2 points for sick
                break;
              case 'Permission':
                userStats[name]!['permission']++;
                userStats[name]!['score'] += 3; // 3 points for permission
                break;
            }
          }

          // Sort by score
          var sortedUsers = userStats.entries.toList()
            ..sort((a, b) => b.value['score'].compareTo(a.value['score']));

          return SingleChildScrollView(
            child: Column(
              children: [
                // Top 3 Podium
                if (sortedUsers.length >= 3) _buildPodium(sortedUsers),

                // Leaderboard List
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Rankings",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A008F),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: sortedUsers.length,
                        itemBuilder: (context, index) {
                          var entry = sortedUsers[index];
                          return _buildLeaderboardCard(
                            rank: index + 1,
                            name: entry.key,
                            stats: entry.value,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPodium(List<MapEntry<String, Map<String, dynamic>>> users) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A008F), Color(0xFF3D1FA8)],
        ),
      ),
      child: Column(
        children: [
          const Icon(Icons.emoji_events, color: Colors.amber, size: 48),
          const SizedBox(height: 8),
          const Text(
            "Top Performers",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // 2nd Place
              if (users.length >= 2)
                _buildPodiumCard(
                  rank: 2,
                  name: users[1].key,
                  score: users[1].value['score'],
                  height: 120,
                  color: Colors.grey[400]!,
                ),
              const SizedBox(width: 16),
              // 1st Place
              _buildPodiumCard(
                rank: 1,
                name: users[0].key,
                score: users[0].value['score'],
                height: 160,
                color: Colors.amber,
              ),
              const SizedBox(width: 16),
              // 3rd Place
              if (users.length >= 3)
                _buildPodiumCard(
                  rank: 3,
                  name: users[2].key,
                  score: users[2].value['score'],
                  height: 100,
                  color: Colors.brown[300]!,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPodiumCard({
    required int rank,
    required String name,
    required int score,
    required double height,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 4),
          ),
          child: Center(
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : '?',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 100,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "#$rank",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "$score pts",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboardCard({
    required int rank,
    required String name,
    required Map<String, dynamic> stats,
  }) {
    Color rankColor;
    IconData rankIcon;

    if (rank == 1) {
      rankColor = Colors.amber;
      rankIcon = Icons.emoji_events;
    } else if (rank == 2) {
      rankColor = Colors.grey[400]!;
      rankIcon = Icons.emoji_events;
    } else if (rank == 3) {
      rankColor = Colors.brown[300]!;
      rankIcon = Icons.emoji_events;
    } else {
      rankColor = const Color(0xFF1A008F);
      rankIcon = Icons.person;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: rank <= 3 ? 4 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Rank Badge
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: rankColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (rank <= 3)
                    Icon(rankIcon, color: rankColor, size: 20)
                  else
                    Text(
                      "#$rank",
                      style: TextStyle(
                        color: rankColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 16),

            // User Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _buildStatBadge(
                        Icons.check_circle,
                        stats['attend'].toString(),
                        const Color(0xFF4CAF50),
                      ),
                      const SizedBox(width: 8),
                      _buildStatBadge(
                        Icons.access_time,
                        stats['late'].toString(),
                        const Color(0xFFFF9800),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${stats['total']} total",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Score
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [rankColor.withOpacity(0.8), rankColor],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    stats['score'].toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "points",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBadge(IconData icon, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
