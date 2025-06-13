import 'package:flutter/material.dart';
import 'package:liquid_glass_effect/liquid_glass_effect.dart';


final List<String> images = [
  "assets/bg1.jpg",
  "assets/bg2.jpg",
  "assets/bg3.jpg",
  "assets/bg4.jpg",
];

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  Map<int, Offset> cardPositions = {
    0: const Offset(100, 100),
    1: const Offset(500, 100),
  };

  String selectedImg = images.first;

  @override
  Widget build(BuildContext context) {
    return LiquidGlassBackground(
      backgroundImageProvider: AssetImage(selectedImg),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Row(
                spacing: 10,
                children:
                    images.map((e) {
                      return Expanded(
                        flex: 1,
                        child: LiquidGlassCard(
                          child: Image.asset(e, fit: BoxFit.cover,height: 140,),
                          onTap: (){
                            setState(() {
                              selectedImg = e;
                            });
                          },
                        ),
                      );
                    }).toList(),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  ...cardPositions.entries.map((entry) {
                    return PositionedDraggableCard(
                      key: ValueKey(entry.key),
                      position: entry.value,
                      onDragEnd: (newOffset) {
                        setState(() {
                          cardPositions[entry.key] = newOffset;
                        });
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: _buildCard(entry.key),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(int index) {
    switch (index) {
      case 0:
        return LiquidGlassCard(
          borderRadius: 10,
          padding: const EdgeInsets.all(24),
          baseColor: Colors.white.withValues(alpha: 0.1),
          child: Column(
            children: [
              const Text(
                '32°',
                style: TextStyle(fontSize: 64, fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 8),
              const Text('Partly Cloudy', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 4),
              const Text('H:32° L:28°', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 24),
              _buildHourlyForecast(),
            ],
          ),
        );
      case 1:
        return LiquidGlassCard(
          borderRadius: 24,
          padding: const EdgeInsets.all(24),
          baseColor: Colors.white.withValues(alpha: 0.2),
          child: _buildCalendar(),
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildCalendar() {
    return Column(
      children: [
        const Text(
          'June 2025',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Table(
          border: TableBorder.symmetric(
            inside: BorderSide(color: Colors.white.withValues(alpha:0.1)),
          ),
          children: [
            const TableRow(
              children: [
                _CalendarDay('M', isHeader: true),
                _CalendarDay('T', isHeader: true),
                _CalendarDay('W', isHeader: true),
                _CalendarDay('T', isHeader: true),
                _CalendarDay('F', isHeader: true),
                _CalendarDay('S', isHeader: true),
                _CalendarDay('S', isHeader: true),
              ],
            ),
            TableRow(
              children: [
                _CalendarDay('', isDisabled: true),
                _CalendarDay('', isDisabled: true),
                _CalendarDay('', isDisabled: true),
                _CalendarDay('1'),
                _CalendarDay('2'),
                _CalendarDay('3'),
                _CalendarDay('4'),
              ],
            ),
            TableRow(
              children: [
                _CalendarDay('5'),
                _CalendarDay('6'),
                _CalendarDay('7'),
                _CalendarDay('8'),
                _CalendarDay('9'),
                _CalendarDay('10'),
                _CalendarDay('11', isSelected: true),
              ],
            ),
            TableRow(
              children: [
                _CalendarDay('12'),
                _CalendarDay('13'),
                _CalendarDay('14'),
                _CalendarDay('15'),
                _CalendarDay('16'),
                _CalendarDay('17'),
                _CalendarDay('18'),
              ],
            ),
            TableRow(
              children: [
                _CalendarDay('19'),
                _CalendarDay('20'),
                _CalendarDay('21'),
                _CalendarDay('22'),
                _CalendarDay('23'),
                _CalendarDay('24'),
                _CalendarDay('25'),
              ],
            ),
            TableRow(
              children: [
                _CalendarDay('26'),
                _CalendarDay('27'),
                _CalendarDay('28'),
                _CalendarDay('29'),
                _CalendarDay('30'),
                _CalendarDay('', isDisabled: true),
                _CalendarDay('', isDisabled: true),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          '3:49 PM  Jun 11, 2025',
          style: TextStyle(color: Colors.white.withValues(alpha:0.8)),
        ),
      ],
    );
  }

  Widget _buildHourlyForecast() {
    return SizedBox(
      height: 100,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: 30,
          children: List.generate(5, (index) {
            final hours = ['Now', '1AM', '2AM', '3AM', '4AM', '5AM'];
            final temps = ['32°', '32°', '32°', '32°', '32°', '32°'];
            final icons = [
              Icons.wb_sunny,
              Icons.cloud,
              Icons.wb_cloudy,
              Icons.grain,
              Icons.ac_unit,
              Icons.thunderstorm,
            ];

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(hours[index], style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 8),
                Icon(icons[index], size: 24, color: Colors.white),
                const SizedBox(height: 8),
                Text(temps[index], style: const TextStyle(fontSize: 16)),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _CalendarDay extends StatelessWidget {
  final String day;
  final bool isSelected;
  final bool isDisabled;
  final bool isHeader;

  const _CalendarDay(
    this.day, {
    this.isSelected = false,
    this.isDisabled = false,
    this.isHeader = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration:
          isSelected
              ? BoxDecoration(
                color: Colors.white.withValues(alpha:0.2),
                shape: BoxShape.circle,
              )
              : null,
      child: Center(
        child: Text(
          day,
          style: TextStyle(
            color:
                isDisabled
                    ? Colors.white.withValues(alpha:0.3)
                    : isHeader
                    ? Colors.white.withValues(alpha:0.7)
                    : Colors.white,
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class PositionedDraggableCard extends StatefulWidget {
  final Offset position;
  final Widget child;
  final ValueChanged<Offset> onDragEnd;

  const PositionedDraggableCard({
    super.key,
    required this.position,
    required this.child,
    required this.onDragEnd,
  });

  @override
  State<PositionedDraggableCard> createState() =>
      _PositionedDraggableCardState();
}

class _PositionedDraggableCardState extends State<PositionedDraggableCard> {
  late Offset position;

  @override
  void initState() {
    super.initState();
    position = widget.position;
  }

  @override
  void didUpdateWidget(PositionedDraggableCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.position != oldWidget.position) {
      position = widget.position;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            position += details.delta;
          });
        },
        onPanEnd: (_) {
          widget.onDragEnd(position);
        },
        child: widget.child,
      ),
    );
  }
}
