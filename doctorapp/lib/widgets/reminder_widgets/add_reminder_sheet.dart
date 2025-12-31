import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../share_widgets/inputs.dart';
import '../share_widgets/buttons.dart';
import '../../utils/responsive_utils.dart';
import '../../models/reminder.dart';

class AddReminderSheet extends StatefulWidget {
  const AddReminderSheet({super.key});

  @override
  State<AddReminderSheet> createState() => _AddReminderSheetState();
}

class _AddReminderSheetState extends State<AddReminderSheet> {
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  TimeOfDay _time = const TimeOfDay(hour: 8, minute: 0);
  DateTime? _date;
  String _repeat = 'None';
  String _category = 'Medicine Reminder';

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickTime() async {
    final t = await showTimePicker(context: context, initialTime: _time);
    if (t != null) setState(() => _time = t);
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final d = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365 * 5)),
    );
    if (d != null) setState(() => _date = d);
  }

  void _save() {
    final title = _titleCtrl.text.trim();
    if (title.isEmpty) return;

    final newReminder = Reminder(
      title: title,
      time: _time,
      repeat: _repeat,
      description: _descCtrl.text.trim().isEmpty ? null : _descCtrl.text.trim(),
      category: _category,
    );

    Navigator.of(context).pop(newReminder);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Add Reminder',
            style: TextStyle(
              fontSize: ResponsiveUtils.fontSizeLarge,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12.h),
          CustomTextField(hintText: 'Title', controller: _titleCtrl),
          SizedBox(height: 8.h),
          CustomTextField(
            hintText: 'Description (optional)',
            controller: _descCtrl,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: _pickTime,
                  icon: const Icon(Icons.access_time),
                  label: Text('Time: ${_time.format(context)}'),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.calendar_today),
                  label: Text(
                    _date == null
                        ? 'Date'
                        : '${_date!.day}/${_date!.month}/${_date!.year}',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _repeat,
                  items: const [
                    DropdownMenuItem(value: 'None', child: Text('None')),
                    DropdownMenuItem(value: 'Daily', child: Text('Daily')),
                    DropdownMenuItem(value: 'Weekly', child: Text('Weekly')),
                  ],
                  onChanged: (v) => setState(() => _repeat = v ?? 'None'),
                  decoration: const InputDecoration(labelText: 'Repeat'),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _category,
                  items: const [
                    DropdownMenuItem(
                      value: 'Medicine Reminder',
                      child: Text('Medicine'),
                    ),
                    DropdownMenuItem(
                      value: 'Appointment Reminder',
                      child: Text('Appointment'),
                    ),
                    DropdownMenuItem(
                      value: 'Follow-up Reminder',
                      child: Text('Follow-up'),
                    ),
                    DropdownMenuItem(
                      value: 'Lab/Test Reminder',
                      child: Text('Lab/Test'),
                    ),
                    DropdownMenuItem(
                      value: 'Health Routine Reminder',
                      child: Text('Routine'),
                    ),
                  ],
                  onChanged: (v) => setState(() => _category = v ?? _category),
                  decoration: const InputDecoration(labelText: 'Category'),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 120.w,
                child: CustomOutlinedButton(
                  text: 'Cancel',
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              SizedBox(width: 8.w),
              SizedBox(
                width: 120.w,
                child: CustomButton(text: 'Save', onPressed: _save),
              ),
            ],
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
