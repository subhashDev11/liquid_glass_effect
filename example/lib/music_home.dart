import 'package:example/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_effect/liquid_glass_card.dart';
import 'package:liquid_glass_effect/liquid_glass_widgets.dart';

class MusicHome extends StatefulWidget {
  const MusicHome({super.key});

  @override
  State<MusicHome> createState() => _MusicHomeState();
}

class _MusicHomeState extends State<MusicHome> {
  @override
  Widget build(BuildContext context) {
    return LiquidGlassBackground(
      child: ResponsiveWidget(
        desktopView: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: const Text(
              'Liquid Glass UI',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black38,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search, size: 28),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings, size: 28),
              ),
            ],
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios, color: Colors.black38),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
            child: _buildDesktopGrid(context),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(Icons.add),
          ),
        ),
        mobileView: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: const Text(
              'Liquid Glass UI',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black38,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios, color: Colors.black38),
            ),
          ),
          body: _buildMobileList(context),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      childAspectRatio: 1.5,
      children: List.generate(
        data.length,
        (index) => _buildCardContent(context, index, true),
      ),
    );
  }

  Widget _buildMobileList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        // padding: EdgeInsets.only(bottom: 100,),
        itemCount: data.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _buildCardContent(context, index, false),
          );
        },
      ),
    );
  }

  Widget _buildCardContent(BuildContext context, int index, bool isDesktop) {
    final cardData = _getCardData(index);

    return LiquidGlassCard(
      baseColor: cardData.color,
      borderRadius: 20,
      padding: const EdgeInsets.all(20),
      onTap: () {
        // Handle card tap
        debugPrint('Card ${index + 1} tapped');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(cardData.icon, size: 32),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'New',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            cardData.title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            cardData.subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
          if (isDesktop) const Spacer() else SizedBox(height: 20),
          LinearProgressIndicator(
            value: (index % 5 + 1) * 0.2,
            backgroundColor: Colors.white.withValues(alpha: 0.2),
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  final data = [
    _CardData(
      Icons.phone_iphone,
      'Phone',
      'Make calls and messages',
      const Color(0x9934C759),
    ),
    _CardData(
      Icons.mail,
      'Messages',
      'Check your conversations',
      const Color(0x99007AFF),
    ),
    _CardData(
      Icons.music_note,
      'Music',
      'Listen to your favorites',
      const Color(0x99FF2D55),
    ),
    _CardData(
      Icons.photo_camera,
      'Camera',
      'Capture special moments',
      const Color(0x99FF9500),
    ),
    _CardData(
      Icons.map,
      'Maps',
      'Find your way around',
      const Color(0x99AF52DE),
    ),
    _CardData(
      Icons.shopping_cart,
      'Store',
      'Browse products',
      const Color(0x99FFCC00),
    ),
  ];

  _CardData _getCardData(int index) {
    return data[index % data.length];
  }
}

class _CardData {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  _CardData(this.icon, this.title, this.subtitle, this.color);
}
