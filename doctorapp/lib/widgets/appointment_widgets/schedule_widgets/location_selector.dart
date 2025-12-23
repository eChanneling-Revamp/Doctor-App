import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationSelector extends StatelessWidget {
  final String selectedLocation;
  final List<String> locations;
  final ValueChanged<String?> onChanged;

  const LocationSelector({
    super.key,
    required this.selectedLocation,
    required this.locations,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Location',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.r),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: DropdownButton<String>(
              value: selectedLocation,
              isExpanded: true,
              underline: const SizedBox(),
              items: locations.map((String location) {
                return DropdownMenuItem<String>(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
