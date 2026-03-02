import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/share_widgets/custom_back_button.dart';

// ─── Data models ─────────────────────────────────────────────────────────────

enum HistoryType { prescription, labResult, visit, procedure }

class PatientHistoryEntry {
  final String title;
  final String subtitle;
  final String date;
  final HistoryType type;
  final String? note;

  const PatientHistoryEntry({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.type,
    this.note,
  });
}

// ─── Sample data ─────────────────────────────────────────────────────────────

const _sampleHistory = [
  PatientHistoryEntry(
    title: 'Prescription Issued',
    subtitle: 'Paracetamol 500mg · Omeprazole 20mg',
    date: '20 Feb 2026',
    type: HistoryType.prescription,
    note: 'Take after meals. Follow-up in 2 weeks.',
  ),
  PatientHistoryEntry(
    title: 'Lab Result — CBC',
    subtitle: 'Complete Blood Count',
    date: '14 Feb 2026',
    type: HistoryType.labResult,
    note: 'All values within normal range.',
  ),
  PatientHistoryEntry(
    title: 'Routine Visit',
    subtitle: 'General check-up · BP: 118/76 · Temp: 98.4°F',
    date: '10 Jan 2026',
    type: HistoryType.visit,
  ),
  PatientHistoryEntry(
    title: 'Prescription Issued',
    subtitle: 'Amoxicillin 500mg · Ibuprofen 400mg',
    date: '05 Jan 2026',
    type: HistoryType.prescription,
    note: 'Bacterial infection. Complete the full course.',
  ),
  PatientHistoryEntry(
    title: 'Lab Result — Lipid Panel',
    subtitle: 'Cholesterol · LDL · HDL · Triglycerides',
    date: '22 Dec 2025',
    type: HistoryType.labResult,
    note: 'LDL slightly elevated. Diet modification recommended.',
  ),
  PatientHistoryEntry(
    title: 'Minor Procedure',
    subtitle: 'Wound dressing — right forearm',
    date: '10 Dec 2025',
    type: HistoryType.procedure,
  ),
  PatientHistoryEntry(
    title: 'Routine Visit',
    subtitle: 'Follow-up on hypertension · BP: 122/80',
    date: '01 Nov 2025',
    type: HistoryType.visit,
  ),
];

// ─── Screen ───────────────────────────────────────────────────────────────────

class PatientHistoryScreen extends StatefulWidget {
  const PatientHistoryScreen({super.key});

  static Route route() =>
      MaterialPageRoute(builder: (_) => const PatientHistoryScreen());

  static Future<void> push(BuildContext context) =>
      Navigator.of(context).push(route());

  @override
  State<PatientHistoryScreen> createState() => _PatientHistoryScreenState();
}

class _PatientHistoryScreenState extends State<PatientHistoryScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  static const _tabs = ['All', 'Prescriptions', 'Lab Results', 'Visits'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<PatientHistoryEntry> get _filtered {
    switch (_tabController.index) {
      case 1:
        return _sampleHistory
            .where((e) => e.type == HistoryType.prescription)
            .toList();
      case 2:
        return _sampleHistory
            .where((e) => e.type == HistoryType.labResult)
            .toList();
      case 3:
        return _sampleHistory
            .where(
              (e) =>
                  e.type == HistoryType.visit ||
                  e.type == HistoryType.procedure,
            )
            .toList();
      default:
        return _sampleHistory;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const CustomBackButton(),
        centerTitle: true,
        title: Text(
          'Patient History',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ── Patient info card ────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(14.r),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28.r,
                        backgroundImage: const AssetImage(
                          'assets/images/logo.png',
                        ),
                        backgroundColor: Colors.grey.shade200,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mary De Silva',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15.sp,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Age: 28  ·  ID: E00210  ·  Ref: App-2025002',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _StatusBadge(
                        label: 'Active',
                        color: const Color(0xFF10B981),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Stats row ────────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  _StatTile(
                    icon: Icons.receipt_long_rounded,
                    label: 'Prescriptions',
                    value: _sampleHistory
                        .where((e) => e.type == HistoryType.prescription)
                        .length
                        .toString(),
                    color: const Color(0xFF4A3FFF),
                  ),
                  SizedBox(width: 10.w),
                  _StatTile(
                    icon: Icons.biotech_rounded,
                    label: 'Lab Results',
                    value: _sampleHistory
                        .where((e) => e.type == HistoryType.labResult)
                        .length
                        .toString(),
                    color: const Color(0xFF0EA5E9),
                  ),
                  SizedBox(width: 10.w),
                  _StatTile(
                    icon: Icons.local_hospital_rounded,
                    label: 'Visits',
                    value: _sampleHistory
                        .where(
                          (e) =>
                              e.type == HistoryType.visit ||
                              e.type == HistoryType.procedure,
                        )
                        .length
                        .toString(),
                    color: const Color(0xFF10B981),
                  ),
                ],
              ),
            ),

            SizedBox(height: 12.h),

            // ── Tabs ─────────────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: const Color(0xFF4A3FFF),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black54,
                  labelStyle: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  padding: EdgeInsets.all(4.r),
                  tabs: _tabs.map((t) => Tab(text: t)).toList(),
                ),
              ),
            ),

            SizedBox(height: 12.h),

            // ── History list ─────────────────────────────────────────────
            Expanded(
              child: _filtered.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.folder_open_rounded,
                            size: 48.r,
                            color: Colors.grey.shade300,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'No records found',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 4.h,
                      ),
                      itemCount: _filtered.length,
                      separatorBuilder: (_, __) => SizedBox(height: 10.h),
                      itemBuilder: (context, i) =>
                          _HistoryCard(entry: _filtered[i]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Reusable widgets ─────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22.r),
            SizedBox(height: 6.h),
            Text(
              value,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final PatientHistoryEntry entry;

  const _HistoryCard({required this.entry});

  static const _typeConfig = {
    HistoryType.prescription: (
      icon: Icons.receipt_long_rounded,
      color: Color(0xFF4A3FFF),
      bg: Color(0xFFEEF2FF),
    ),
    HistoryType.labResult: (
      icon: Icons.biotech_rounded,
      color: Color(0xFF0EA5E9),
      bg: Color(0xFFE0F2FE),
    ),
    HistoryType.visit: (
      icon: Icons.local_hospital_rounded,
      color: Color(0xFF10B981),
      bg: Color(0xFFE6F7EB),
    ),
    HistoryType.procedure: (
      icon: Icons.medical_services_rounded,
      color: Color(0xFFF59E0B),
      bg: Color(0xFFFEF3C7),
    ),
  };

  @override
  Widget build(BuildContext context) {
    final cfg = _typeConfig[entry.type]!;

    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(14.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon badge
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: cfg.bg,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(cfg.icon, color: cfg.color, size: 20.r),
            ),
            SizedBox(width: 12.w),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          entry.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13.sp,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        entry.date,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    entry.subtitle,
                    style: TextStyle(fontSize: 12.sp, color: Colors.black54),
                  ),
                  if (entry.note != null) ...[
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.notes_rounded,
                            size: 13.r,
                            color: Colors.black38,
                          ),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Text(
                              entry.note!,
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.black54,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
