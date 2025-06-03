import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/core/constants/app_colors.dart';
import 'package:mohammed_ashraf/widgets/filter_button.dart';

class FilterScreenDoctor extends StatefulWidget {
  const FilterScreenDoctor({super.key});

  @override
  State<FilterScreenDoctor> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreenDoctor> {
  String? _selectedGender = 'Male';
  String? _selectedAge = 'Under 30 years';
  String? _selectedAppointmentTime = 'Today';
  String? _selectedAppointmentStatus = 'Pending';

  Widget _buildFilterSection(String title, List<String> options, String? selectedValue, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24.0, bottom: 12.0),
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor),
          ),
        ),
        Align( // <--- التعديل هنا
          alignment: Alignment.centerLeft,
          child: Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: options.map((option) {
              return FilterButton(
                label: option,
                isSelected: selectedValue == option,
                onSelected: () {
                  if (selectedValue == option) {
                    onChanged(null);
                  } else {
                    onChanged(option);
                  }
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Filtration',
            style: TextStyle(
                color: AppColors.textColor, fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0.5,
        centerTitle: true,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
            _buildFilterSection(
              'Patient\'s Gender',
              ['Male', 'Female'],
              _selectedGender,
                  (value) => setState(() => _selectedGender = value),
            ),
            _buildFilterSection(
              'Patient\'s Age',
              ['Under 30 years', '30-50 years', 'Above 40 years'],
              _selectedAge,
                  (value) => setState(() => _selectedAge = value),
            ),
            _buildFilterSection(
              'Appointments',
              ['Today', 'This Week', 'Next Week', 'This Month'],
              _selectedAppointmentTime,
                  (value) => setState(() => _selectedAppointmentTime = value),
            ),
            _buildFilterSection(
              'Appointment\'s Status',
              ['Pending', 'Confirmed', 'Completed', 'Cancelled'],
              _selectedAppointmentStatus,
                  (value) => setState(() => _selectedAppointmentStatus = value),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    _selectedGender = null;
                    _selectedAge = null;
                    _selectedAppointmentTime = null;
                    _selectedAppointmentStatus = null;
                  });
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  side: const BorderSide(
                      color: AppColors.primaryColor, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Reset Filter',
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 2,
                ),
                child: const Text('Apply',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}