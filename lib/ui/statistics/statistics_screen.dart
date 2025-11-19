import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
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
          "Statistics & Analytics",
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
                  Icon(Icons.bar_chart, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    "No data available yet",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          }

          // Calculate statistics
          var docs = snapshot.data!.docs;
          int total = docs.length;
          int attend = 0;
          int late = 0;
          int sick = 0;
          int permission = 0;
          int familyEmergency = 0;
          int others = 0;

          Map<String, int> dailyStats = {};
          Map<String, int> monthlyStats = {};
          Set<String> uniqueUsers = {};

          for (var doc in docs) {
            var data = doc.data() as Map<String, dynamic>;
            var description = data['description'] ?? '';
            var name = data['name'] ?? '';
            
            // Count unique users
            if (name.isNotEmpty) {
              uniqueUsers.add(name);
            }
            
            switch (description) {
              case 'Attend':
                attend++;
                break;
              case 'Late':
                late++;
                break;
              case 'Sick':
                sick++;
                break;
              case 'Permission':
                permission++;
                break;
              case 'Family Emergency':
                familyEmergency++;
                break;
              default:
                others++;
            }

            // Daily stats
            var datetime = data['datetime'] ?? '';
            if (datetime.isNotEmpty) {
              try {
                // Handle both formats: "18 November 2025 | 08:15:30" and "18/11/2025 - 20/11/2025"
                String dateStr;
                if (datetime.contains('|')) {
                  dateStr = datetime.split('|')[0].trim();
                } else if (datetime.contains('-')) {
                  dateStr = datetime.split('-')[0].trim();
                } else {
                  dateStr = datetime;
                }
                
                dailyStats[dateStr] = (dailyStats[dateStr] ?? 0) + 1;
                
                // Monthly stats
                try {
                  DateTime date;
                  if (dateStr.contains('/')) {
                    date = DateFormat('dd/MM/yyyy').parse(dateStr);
                  } else {
                    date = DateFormat('dd MMMM yyyy').parse(dateStr);
                  }
                  String monthKey = DateFormat('MMM yyyy').format(date);
                  monthlyStats[monthKey] = (monthlyStats[monthKey] ?? 0) + 1;
                } catch (e) {
                  // Skip if date parsing fails
                }
              } catch (e) {
                // Skip if date parsing fails
              }
            }
          }

          // Calculate rates
          int actualAttendance = attend + late; // Both count as attendance
          double attendanceRate = total > 0 ? (actualAttendance / total * 100) : 0;
          double punctualityRate = actualAttendance > 0 ? (attend / actualAttendance * 100) : 0;
          double absenceRate = total > 0 ? ((sick + permission + familyEmergency + others) / total * 100) : 0;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Overview Card
                _buildOverviewCard(total, attendanceRate, punctualityRate, uniqueUsers.length),
                const SizedBox(height: 24),

                // Quick Stats Row
                Row(
                  children: [
                    Expanded(
                      child: _buildQuickStatCard(
                        "Total Users",
                        uniqueUsers.length.toString(),
                        Icons.people,
                        const Color(0xFF2196F3),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildQuickStatCard(
                        "Absence Rate",
                        "${absenceRate.toStringAsFixed(1)}%",
                        Icons.event_busy,
                        const Color(0xFFF44336),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Status Breakdown
                const Text(
                  "Status Breakdown",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A008F),
                  ),
                ),
                const SizedBox(height: 16),
                _buildStatusGrid(attend, late, sick, permission, familyEmergency, others),
                const SizedBox(height: 24),

                // Performance Indicators
                const Text(
                  "Performance Indicators",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A008F),
                  ),
                ),
                const SizedBox(height: 16),
                _buildPerformanceCard(attendanceRate, punctualityRate, absenceRate, total),
                const SizedBox(height: 24),

                // Monthly Trends
                if (monthlyStats.isNotEmpty) ...[
                  const Text(
                    "Monthly Trends",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A008F),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildMonthlyTrends(monthlyStats),
                  const SizedBox(height: 24),
                ],

                // Recent Activity
                const Text(
                  "Recent Activity",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A008F),
                  ),
                ),
                const SizedBox(height: 16),
                _buildRecentTrends(dailyStats),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOverviewCard(int total, double attendanceRate, double punctualityRate, int users) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
          ),
        ),
        child: Column(
          children: [
            const Icon(Icons.analytics, color: Colors.white, size: 48),
            const SizedBox(height: 16),
            const Text(
              "Overall Statistics",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Based on $total records from $users user(s)",
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildOverviewItem("Total", total.toString(), Icons.list),
                _buildOverviewItem(
                  "Attendance",
                  "${attendanceRate.toStringAsFixed(1)}%",
                  Icons.trending_up,
                ),
                _buildOverviewItem(
                  "Punctuality",
                  "${punctualityRate.toStringAsFixed(1)}%",
                  Icons.access_time,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStatCard(String label, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color.withOpacity(0.1),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: color.withOpacity(0.8),
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusGrid(int attend, int late, int sick, int permission, int familyEmergency, int others) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _buildStatusCard("On Time", attend, const Color(0xFF4CAF50), Icons.check_circle),
        _buildStatusCard("Late", late, const Color(0xFFFF9800), Icons.access_time),
        _buildStatusCard("Sick", sick, const Color(0xFFF44336), Icons.sick),
        _buildStatusCard("Permission", permission, const Color(0xFF2196F3), Icons.event_available),
        if (familyEmergency > 0)
          _buildStatusCard("Family", familyEmergency, const Color(0xFFFF5722), Icons.family_restroom),
        if (others > 0)
          _buildStatusCard("Others", others, const Color(0xFF9C27B0), Icons.more_horiz),
      ],
    );
  }

  Widget _buildStatusCard(String label, int count, Color color, IconData icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.8), color],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 32),
            const SizedBox(height: 8),
            Text(
              count.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceCard(double attendanceRate, double punctualityRate, double absenceRate, int total) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildProgressIndicator(
              "Attendance Rate",
              attendanceRate,
              const Color(0xFF4CAF50),
              "Attend + Late",
            ),
            const SizedBox(height: 20),
            _buildProgressIndicator(
              "Punctuality Rate",
              punctualityRate,
              const Color(0xFF2196F3),
              "On Time / Total Attendance",
            ),
            const SizedBox(height: 20),
            _buildProgressIndicator(
              "Absence Rate",
              absenceRate,
              const Color(0xFFF44336),
              "Sick + Permission + Others",
            ),
            const SizedBox(height: 20),
            _buildProgressIndicator(
              "Activity Level",
              total > 20 ? 100 : (total / 20 * 100),
              const Color(0xFF9C27B0),
              "Based on 20 records target",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(String label, double value, Color color, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "${value.toStringAsFixed(1)}%",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: value / 100,
            backgroundColor: color.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildMonthlyTrends(Map<String, int> monthlyStats) {
    var sortedEntries = monthlyStats.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key));
    var recentMonths = sortedEntries.take(6).toList();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.calendar_month, color: Color(0xFF1A008F), size: 20),
                const SizedBox(width: 8),
                const Text(
                  "Last 6 Months",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...recentMonths.map((entry) {
              int maxValue = recentMonths.map((e) => e.value).reduce((a, b) => a > b ? a : b);
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text(
                        entry.key,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: entry.value / maxValue,
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF667EEA),
                          ),
                          minHeight: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF667EEA).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        entry.value.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF667EEA),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentTrends(Map<String, int> dailyStats) {
    var sortedEntries = dailyStats.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key));
    var recentEntries = sortedEntries.take(7).toList();

    if (recentEntries.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Text(
              "No recent activity",
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ),
      );
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: recentEntries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      entry.key,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: entry.value / 10,
                        backgroundColor: Colors.grey[200],
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF1A008F),
                        ),
                        minHeight: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    entry.value.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A008F),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
