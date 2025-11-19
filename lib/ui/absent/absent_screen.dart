import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:attendance_app/ui/home_screen.dart';

class AbsentScreen extends StatefulWidget {
  const AbsentScreen({super.key});

  @override
  State<AbsentScreen> createState() => _AbsentScreenState();
}

class _AbsentScreenState extends State<AbsentScreen> {
  var categoriesList = <String>[
    "Please Choose:",
    "Others",
    "Permission",
    "Sick",
  ];

  final controllerName = TextEditingController();
  double dLat = 0.0, dLong = 0.0;
  final CollectionReference dataCollection = FirebaseFirestore.instance
      .collection('attendance');

  int dateHours = 0, dateMinutes = 0;
  String dropValueCategories = "Please Choose:";
  final fromController = TextEditingController();
  String strAlamat = '', strDate = '', strTime = '', strDateTime = '';
  final toController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  //show progress dialog
  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: const Text("Please Wait..."),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  //submit data absent to firebase
  Future<void> submitAbsen(
    String nama,
    String keterangan,
    String from,
    String until,
  ) async {
    // Validasi input sebelum mengirim ke Firebase
    if (nama.isEmpty ||
        keterangan == "Please Choose:" ||
        from.isEmpty ||
        until.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.white),
              SizedBox(width: 10),
              Text(
                "Pastikan semua data telah diisi!",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Menampilkan loader
    showLoaderDialog(context);

    try {
      await dataCollection.add({
        'address': '-',
        'name': nama,
        'description': keterangan,
        'datetime': '$from - $until',
        'created_at': FieldValue.serverTimestamp(), // Tambahkan timestamp
      });

      // Tutup loader sebelum menampilkan pesan sukses
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle_outline, color: Colors.white),
              SizedBox(width: 10),
              Text(
                "Yeay! Attendance Report Succeeded!",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Kembali ke halaman utama
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      // Jika terjadi error, tutup loader
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Ups, terjadi kesalahan: $e",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Info Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF9800), Color(0xFFFFB74D)],
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.white, size: 32),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Permission Request",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Fill the form to request permission",
                              style: TextStyle(
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
              // Name Input
              const Text(
                "Your Name",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A008F),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  controller: controllerName,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    hintText: "Enter your full name",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[400],
                    ),
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
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Reason Dropdown
              const Text(
                "Reason",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A008F),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey[50],
                  ),
                  child: DropdownButton(
                    dropdownColor: Colors.white,
                    value: dropValueCategories,
                    onChanged: (value) {
                      setState(() {
                        dropValueCategories = value.toString();
                      });
                    },
                    items: categoriesList.map((value) {
                      IconData icon;
                      switch (value) {
                        case "Sick":
                          icon = Icons.sick_outlined;
                          break;
                        case "Permission":
                          icon = Icons.event_available;
                          break;
                        case "Others":
                          icon = Icons.more_horiz;
                          break;
                        default:
                          icon = Icons.help_outline;
                      }
                      return DropdownMenuItem(
                        value: value.toString(),
                        child: Row(
                          children: [
                            Icon(icon, size: 20, color: const Color(0xFF1A008F)),
                            const SizedBox(width: 12),
                            Text(
                              value.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    underline: Container(height: 0),
                    isExpanded: true,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Date Range
              const Text(
                "Date Range",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A008F),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextField(
                        readOnly: true,
                        controller: fromController,
                        onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  builder: (
                                    BuildContext context,
                                    Widget? child,
                                  ) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: const ColorScheme.light(
                                          onPrimary: Colors.white,
                                          onSurface: Colors.white,
                                          primary: Colors.blueAccent,
                                        ),
                                        datePickerTheme:
                                            const DatePickerThemeData(
                                              headerBackgroundColor:
                                                  Colors.blueAccent,
                                              backgroundColor: Color.fromARGB(
                                                255,
                                                0,
                                                0,
                                                0,
                                              ),
                                              headerForegroundColor:
                                                  Colors.white,
                                              surfaceTintColor: Colors.white,
                                            ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(9999),
                                );
                          if (pickedDate != null) {
                            fromController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          hintText: "From date",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                          prefixIcon: const Icon(
                            Icons.calendar_today,
                            color: Color(0xFF1A008F),
                            size: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextField(
                        readOnly: true,
                        controller: toController,
                        onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  builder: (
                                    BuildContext context,
                                    Widget? widget,
                                  ) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: const ColorScheme.light(
                                          onPrimary: Colors.white,
                                          onSurface: Colors.white,
                                          primary: Colors.blueAccent,
                                        ),
                                        datePickerTheme:
                                            const DatePickerThemeData(
                                              headerBackgroundColor:
                                                  Colors.blueAccent,
                                              backgroundColor: Color.fromARGB(
                                                255,
                                                0,
                                                0,
                                                0,
                                              ),
                                              headerForegroundColor:
                                                  Colors.white,
                                              surfaceTintColor: Colors.white,
                                            ),
                                      ),
                                      child: widget!,
                                    );
                                  },
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(9999),
                                );
                          if (pickedDate != null) {
                            toController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          hintText: "To date",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                          prefixIcon: const Icon(
                            Icons.event,
                            color: Color(0xFF1A008F),
                            size: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    if (controllerName.text.isEmpty ||
                        dropValueCategories == "Please Choose:" ||
                        fromController.text.isEmpty ||
                        toController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Row(
                            children: [
                              Icon(Icons.warning_amber_rounded, color: Colors.white),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text("Please complete all fields!"),
                              ),
                            ],
                          ),
                          backgroundColor: Colors.orange[700],
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    } else {
                      submitAbsen(
                        controllerName.text.toString(),
                        dropValueCategories.toString(),
                        fromController.text,
                        toController.text,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9800),
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shadowColor: const Color(0xFFFF9800).withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.send, size: 24),
                      SizedBox(width: 12),
                      Text(
                        "Submit Request",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}