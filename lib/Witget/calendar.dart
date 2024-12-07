import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPopup {
  static Future<DateTime?> showCalendar(BuildContext context) async {
    DateTime selectedDay = DateTime.now();
    DateTime focusedDay = DateTime.now();

    return await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Phần hiển thị ngày được chọn
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: Color(0xFFD479FF),
                ),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${selectedDay.year}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${selectedDay.month}/${selectedDay.day}/${selectedDay.year}",
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        )),
                      ),
                    ],
                  ),
                ),
              ),

              // Phần lịch
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TableCalendar(
                  focusedDay: focusedDay,
                  firstDay: DateTime(2000),
                  lastDay: DateTime(2100),
                  calendarFormat: CalendarFormat.month,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  selectedDayPredicate: (day) => isSameDay(selectedDay, day),
                  onDaySelected: (newSelectedDay, newFocusedDay) {
                    selectedDay = newSelectedDay;
                    focusedDay = newFocusedDay;
                    (context as Element).markNeedsBuild();
                  },
                  calendarStyle: CalendarStyle(
                    todayDecoration: const BoxDecoration(
                      color: Color.fromRGBO(188, 124, 237, 0.2),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: const BoxDecoration(
                      color: Color(0xFFD479FF),
                      shape: BoxShape.circle,
                    ),
                    defaultTextStyle: TextStyle(
                        color: Theme.of(context).colorScheme.background),
                    weekendTextStyle: TextStyle(
                        color: Theme.of(context).colorScheme.background),
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                      color: Theme.of(context).colorScheme.background,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: Color(0xFFD479FF), // Màu icon trái
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: Color(0xFFD479FF), // Màu icon phải
                    ),
                  ),
                ),
              ),

              // Nút hành động
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(null);
                      },
                      child: Text(
                        "HỦY",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.background),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD479FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(selectedDay);
                      },
                      child: const Text(
                        "OK",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
