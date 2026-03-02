import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/patient_history_entry.dart';
import '../../widgets/patient_history_widgets/history_card.dart';
import '../../widgets/patient_history_widgets/history_stat_tile.dart';
import '../../widgets/patient_history_widgets/history_status_badge.dart';
import '../../widgets/share_widgets/custom_back_button.dart';

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
                      HistoryStatusBadge(
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
                  HistoryStatTile(
                    icon: Icons.receipt_long_rounded,
                    label: 'Prescriptions',
                    value: _sampleHistory
                        .where((e) => e.type == HistoryType.prescription)
                        .length
                        .toString(),
                    color: const Color(0xFF4A3FFF),
                  ),
                  SizedBox(width: 10.w),
                  HistoryStatTile(
                    icon: Icons.biotech_rounded,
                    label: 'Lab Results',
                    value: _sampleHistory
                        .where((e) => e.type == HistoryType.labResult)
                        .length
                        .toString(),
                    color: const Color(0xFF0EA5E9),
                  ),
                  SizedBox(width: 10.w),
                  HistoryStatTile(
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
                          HistoryCard(entry: _filtered[i]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
