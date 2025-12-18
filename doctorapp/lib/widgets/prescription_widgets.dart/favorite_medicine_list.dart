import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef OnFavoriteTap =
    void Function(String medicineName, int index, bool selected);

class FavoriteMedicineList extends StatelessWidget {
  final List<String> favorites;
  final Set<int> selectedIndices;
  final OnFavoriteTap onTap;

  const FavoriteMedicineList({
    super.key,
    required this.favorites,
    required this.selectedIndices,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(favorites.length, (index) {
        final m = favorites[index];
        final isSelected = selectedIndices.contains(index);
        return GestureDetector(
          onTap: () => onTap(m, index, isSelected),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 6.h),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        m,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 4.h),
                      const Text(
                        '1-2 tablets / Every 6 hours',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 28.r,
                  height: 28.r,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF09CD4A)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: isSelected
                        ? null
                        : Border.all(color: Colors.grey.shade300),
                  ),
                  child: isSelected
                      ? Icon(Icons.check, color: Colors.white, size: 18.r)
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
