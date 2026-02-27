import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/share_widgets/buttons.dart';
import '../../widgets/share_widgets/custom_back_button.dart';
import '../../utils/snackbar_utils.dart';
import '../../utils/responsive_utils.dart';
import '../../widgets/reminder_widgets/add_reminder_sheet.dart';
import '../../widgets/reminder_widgets/reminder_card.dart';
import '../../models/reminder.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  final List<Reminder> _reminders = [
    Reminder(
      title: 'Morning Medication',
      time: const TimeOfDay(hour: 8, minute: 0),
      repeat: 'Daily',
      description: 'After breakfast',
      category: 'Medicine Reminder',
    ),
    Reminder(
      title: 'Clinic Appointment',
      time: const TimeOfDay(hour: 11, minute: 30),
      repeat: 'None',
      description: 'Dr. Silva — Room 3',
      category: 'Appointment Reminder',
    ),
    Reminder(
      title: 'Follow-up call',
      time: const TimeOfDay(hour: 15, minute: 0),
      repeat: 'Weekly',
      description: 'Discuss test results',
      category: 'Follow-up Reminder',
    ),
    // Reminder(
    //   title: 'Blood Test',
    //   time: const TimeOfDay(hour: 9, minute: 0),
    //   repeat: 'None',
    //   description: 'Fasting required',
    //   category: 'Lab/Test Reminder',
    // ),
    // Reminder(
    //   title: 'Evening Walk',
    //   time: const TimeOfDay(hour: 18, minute: 0),
    //   repeat: 'Daily',
    //   description: '20 minutes',
    //   category: 'Health Routine Reminder',
    // ),
  ];

  void _openAddReminderSheet() async {
    final newReminder = await showModalBottomSheet<Reminder>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const AddReminderSheet(),
      ),
    );

    if (newReminder != null) {
      setState(() => _reminders.insert(0, newReminder));
    }
  }

  void _deleteReminder(int index) {
    final removed = _reminders[index];
    setState(() => _reminders.removeAt(index));
    SnackbarUtils.show(
      context,
      'Deleted "${removed.title}"',
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () => setState(() => _reminders.insert(index, removed)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: CustomBackButton(),
        // centerTitle: true,
        title: Text(
          'Reminders',
          style: TextStyle(
            color: Colors.black87,
            fontSize: ResponsiveUtils.fontSizeXLarge,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: CustomOutlinedButton(
              onPressed: _openAddReminderSheet,
              text: 'Add Reminder',
              height: 40.h,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: _reminders.isEmpty
            ? Center(
                child: Text(
                  'No reminders yet',
                  style: TextStyle(
                    fontSize: ResponsiveUtils.fontSizeRegular,
                    color: Colors.black54,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: _reminders.length,
                itemBuilder: (context, index) {
                  final r = _reminders[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Dismissible(
                      key: ValueKey(
                        '${r.title}-${r.time.hour}-${r.time.minute}',
                      ),
                      direction: DismissDirection.horizontal,
                      confirmDismiss: (dir) async {
                        return await showDialog<bool>(
                              context: context,
                              builder: (c) => AlertDialog(
                                title: const Text('Delete reminder'),
                                content: Text('Delete "${r.title}"?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(c).pop(false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(c).pop(true),
                                    child: const Text('Delete'),
                                  ),
                                ],
                              ),
                            ) ??
                            false;
                      },
                      background: Container(
                        padding: EdgeInsets.only(left: 20.w),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      secondaryBackground: Container(
                        padding: EdgeInsets.only(right: 20.w),
                        alignment: Alignment.centerRight,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (dir) {
                        final currentIndex = _reminders.indexOf(r);
                        if (currentIndex != -1) _deleteReminder(currentIndex);
                      },
                      child: ReminderCard(
                        reminder: r,
                        onToggle: (v) => setState(() => r.enabled = v),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
