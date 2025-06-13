import 'package:example/weather_home.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_effect/liquid_glass_effect.dart';
import 'music_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liquid Glass UI',
      debugShowCheckedModeBanner: false,
      theme: createLiquidGlassTheme(
        config: const LiquidGlassConfig(
          blurAmount: 30.0,
          highlightIntensity: 0.3,
          noiseOpacity: 0.05,
        ),
      ),
      // home: const MusicHome(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidGlassBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              spacing: 15,
              children: [
                Text(
                  "This is an example to demonstrate, How to achieve the Liquid Glass UI using the liquid-glass-effect package.",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 14,
                    color: Colors.black38,
                  ),
                ),
                LiquidGlassElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => MusicHome()),
                    );
                  },
                  child: Text("Music"),
                ),
                LiquidGlassOutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => WeatherHome()),
                    );
                  },
                  child: Text("Weather"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
