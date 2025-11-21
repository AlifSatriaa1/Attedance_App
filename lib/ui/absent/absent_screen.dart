import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:attendance_app/ui/home_screen.dart';
import 'package:attendance_app/widgets/success_dialog.dart';
import 'package:attendance_app/utils/custom_snackbar.dart';
import 'package:attendance_app/widgets/gradient_button.dart';

class AbsentScreen extends StatefulWidget {
  const AbsentScreen({super.key});

  @override
  State<AbsentScreen> createState() => _AbsentScreenState();
}

class _AbsentScreenState extends State<AbsentScreen> {
  int currentStep = 0;
  late PageController pageController;
  
  final controllerName = TextEditingController();
  final controllerReason = TextEditingController();
  final fromController = TextEditingController();
  final toController = TextEditingController();
  
  String selectedCategory = '';
  DateTime? fromDate;
  DateTime? toDate;
  
  final CollectionReference dataCollection =
      FirebaseFirestore.instance.collection('attendance');

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    pageController.dispose();
    controllerName.dispose();
    controllerReason.dispose();
    fromController.dispose();
    toController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> categories = [
    {
      'title': 'Sick',
      'icon': Icons.sick_outlined,
      'color': const Color(0xFFF44336),
      'description': 'Medical leave or illness',
    },
    {
      'title': 'Permission',
      'icon': Icons.event_available,
      'color': const Color(0xFF2196F3),
      'description': 'Personal matters or appointments',
    },
    {
      'title': 'Family Emergency',
      'icon': Icons.family_restroom,
      'color': const Color(0xFFFF9800),
      'description': 'Family-related urgent matters',
    },
    {
      'title': 'Others',
      'icon': Icons.more_horiz,
      'color': const Color(0xFF9C27B0),
      'description': 'Other reasons',
    },
  ];

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
          "Request Permission",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xFF1A008F),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Row(
              children: [
                _buildStepIndicator(0, "Info", Icons.person),
                _buildStepLine(0),
                _buildStepIndicator(1, "Reason", Icons.description),
                _buildStepLine(1),
                _buildStepIndicator(2, "Date", Icons.calendar_today),
              ],
            ),
          ),

          // Content
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  currentStep = index;
                });
              },
              children: [
                _buildStep1(),
                _buildStep2(),
                _buildStep3(),
              ],
            ),
          ),

          // Navigation Buttons
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                if (currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          currentStep--;
                        });
                        pageController.animateToPage(
                          currentStep - 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: Color(0xFF1A008F)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Back",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A008F),
                        ),
                      ),
                    ),
                  ),
                if (currentStep > 0) const SizedBox(width: 12),
                Expanded(
                  flex: currentStep == 0 ? 1 : 2,
                  child: GradientButton(
                    text: currentStep == 2 ? "Submit Request" : "Next",
                    icon: currentStep == 2 ? Icons.send : Icons.arrow_forward,
                    onPressed: _handleNext,
                    height: 56,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(int step, String label, IconData icon) {
    bool isActive = currentStep >= step;
    bool isCurrent = currentStep == step;

    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.white.withOpacity(0.3),
            shape: BoxShape.circle,
            border: isCurrent
                ? Border.all(color: Colors.amber, width: 3)
                : null,
          ),
          child: Icon(
            icon,
            color: isActive ? const Color(0xFF1A008F) : Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.white.withOpacity(0.6),
            fontSize: 12,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine(int step) {
    bool isActive = currentStep > step;
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 30),
        color: isActive ? Colors.white : Colors.white.withOpacity(0.3),
      ),
    );
  }

  // Step 1: Personal Info
  Widget _buildStep1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Personal Information",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A008F),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Let's start with your basic information",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 32),

          // Name Input
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: TextField(
                controller: controllerName,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: "Enter your full name",
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: Color(0xFF1A008F),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Helper Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue[700], size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Make sure to enter your full name as registered",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.blue[900],
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

  // Step 2: Reason Selection
  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Select Reason",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A008F),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Choose the reason for your absence",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),

          // Category Cards
          ...categories.map((category) {
            bool isSelected = selectedCategory == category['title'];
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategory = category['title'] as String;
                });
              },
              child: Card(
                margin: const EdgeInsets.only(bottom: 16),
                elevation: isSelected ? 4 : 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: isSelected
                        ? category['color'] as Color
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: isSelected
                        ? LinearGradient(
                            colors: [
                              (category['color'] as Color).withOpacity(0.1),
                              (category['color'] as Color).withOpacity(0.05),
                            ],
                          )
                        : null,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: (category['color'] as Color).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          category['icon'] as IconData,
                          color: category['color'] as Color,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category['title'] as String,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? category['color'] as Color
                                    : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              category['description'] as String,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle,
                          color: category['color'] as Color,
                          size: 28,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),

          // Additional Reason (Optional)
          if (selectedCategory.isNotEmpty) ...[
            const SizedBox(height: 8),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: TextField(
                  controller: controllerReason,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Additional details (optional)",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Step 3: Date Selection
  Widget _buildStep3() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Select Date Range",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A008F),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "When will you be absent?",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 32),

          // From Date
          const Text(
            "From",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => _selectDate(context, true),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey[50],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A008F).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.calendar_today,
                        color: Color(0xFF1A008F),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        fromDate != null
                            ? DateFormat('EEEE, dd MMMM yyyy').format(fromDate!)
                            : "Select start date",
                        style: TextStyle(
                          fontSize: 16,
                          color: fromDate != null
                              ? Colors.black87
                              : Colors.grey[400],
                          fontWeight: fromDate != null
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // To Date
          const Text(
            "To",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => _selectDate(context, false),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey[50],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A008F).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.event,
                        color: Color(0xFF1A008F),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        toDate != null
                            ? DateFormat('EEEE, dd MMMM yyyy').format(toDate!)
                            : "Select end date",
                        style: TextStyle(
                          fontSize: 16,
                          color: toDate != null
                              ? Colors.black87
                              : Colors.grey[400],
                          fontWeight: toDate != null
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            ),
          ),

          // Duration Display
          if (fromDate != null && toDate != null) ...[
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.access_time, color: Colors.white, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Duration",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "${toDate!.difference(fromDate!).inDays + 1} day(s)",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Summary Card
          if (fromDate != null && toDate != null) ...[
            const SizedBox(height: 24),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Summary",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A008F),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildSummaryRow(Icons.person, "Name", controllerName.text),
                    const Divider(height: 24),
                    _buildSummaryRow(Icons.description, "Reason", selectedCategory),
                    const Divider(height: 24),
                    _buildSummaryRow(
                      Icons.calendar_today,
                      "Period",
                      "${DateFormat('dd MMM').format(fromDate!)} - ${DateFormat('dd MMM yyyy').format(toDate!)}",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSummaryRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF1A008F), size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF1A008F),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isFromDate) {
          fromDate = picked;
          fromController.text = DateFormat('dd/MM/yyyy').format(picked);
          // Reset toDate if it's before fromDate
          if (toDate != null && toDate!.isBefore(picked)) {
            toDate = null;
            toController.clear();
          }
        } else {
          if (fromDate == null) {
            CustomSnackbar.show(
              context,
              message: "Please select start date first",
              type: SnackbarType.warning,
            );
            return;
          }
          if (picked.isBefore(fromDate!)) {
            CustomSnackbar.show(
              context,
              message: "End date cannot be before start date",
              type: SnackbarType.error,
            );
            return;
          }
          toDate = picked;
          toController.text = DateFormat('dd/MM/yyyy').format(picked);
        }
      });
    }
  }

  void _handleNext() {
    if (currentStep == 0) {
      // Validate Step 1
      if (controllerName.text.trim().isEmpty) {
        CustomSnackbar.show(
          context,
          message: "Please enter your name",
          type: SnackbarType.warning,
        );
        return;
      }
      setState(() {
        currentStep = 1;
      });
      pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (currentStep == 1) {
      // Validate Step 2
      if (selectedCategory.isEmpty) {
        CustomSnackbar.show(
          context,
          message: "Please select a reason",
          type: SnackbarType.warning,
        );
        return;
      }
      setState(() {
        currentStep = 2;
      });
      pageController.animateToPage(
        2,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (currentStep == 2) {
      // Validate Step 3 and Submit
      if (fromDate == null || toDate == null) {
        CustomSnackbar.show(
          context,
          message: "Please select both dates",
          type: SnackbarType.warning,
        );
        return;
      }
      _submitRequest();
    }
  }

  Future<void> _submitRequest() async {
    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: Color(0xFF1A008F),
            ),
            const SizedBox(height: 20),
            const Text(
              "Submitting request...",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );

    try {
      String dateRange =
          "${DateFormat('dd/MM/yyyy').format(fromDate!)} - ${DateFormat('dd/MM/yyyy').format(toDate!)}";
      String fullReason = controllerReason.text.trim().isNotEmpty
          ? "$selectedCategory: ${controllerReason.text.trim()}"
          : selectedCategory;

      await dataCollection.add({
        'name': controllerName.text.trim(),
        'address': '-',
        'description': selectedCategory,
        'datetime': dateRange,
        'reason': fullReason,
        'created_at': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        Navigator.of(context).pop(); // Close loading

        // Show success dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => SuccessDialog(
            title: "Request Submitted!",
            message:
                "Your permission request has been submitted successfully",
            onDismiss: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop(); // Close loading
        CustomSnackbar.show(
          context,
          message: "Error: $e",
          type: SnackbarType.error,
        );
      }
    }
  }
}
