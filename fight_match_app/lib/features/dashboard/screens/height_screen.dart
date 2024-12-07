import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vertical_weight_slider/vertical_weight_slider.dart';

import '../../../core/constants/svgs.dart';
import '../../../core/utils/measurement_converters.dart';

class HeightScreen extends StatefulWidget {
  const HeightScreen({super.key});

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  final _controller = WeightSliderController(
    initialWeight: 175,
    interval: 1,
    minWeight: 30,
    maxWeight: 365,
  );
  int heightInCm = 175;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SvgPicture.asset(Svgs.backButton),
          ),
        ),
        title: const Text(
          'Height',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Feet display & Unit Toggle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 120,
                      child: Card.filled(
                        elevation: 0,
                        color: const Color(0xFFe2e2e2),
                        surfaceTintColor: const Color(0xFFe2e2e2),
                        child: Center(
                          child: Text(
                            convertCmToFeetAndInche(heightInCm),
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF747474),
                              fontFamily: 'Zen',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Chip(
                      elevation: 0,
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      label: SizedBox(
                        width: 30,
                        child: Center(
                          child: Text(
                            'cm',
                            style: TextStyle(
                              fontFamily: 'Zen',
                            ),
                          ),
                        ),
                      ),
                      backgroundColor: Color(0xFF2b2b2b),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color(0xFF2b2b2b),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              // Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(Svgs.indicatorHeightAndWeight),
                ],
              ),
              const SizedBox(height: 20),
              // Value Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 135,
                    width: 90,
                    child: Card.filled(
                      elevation: 0,
                      color: const Color(0xFFf7f7f7),
                      surfaceTintColor: const Color(0xFFf7f7f7),
                      child: Center(
                        child: Text(
                          (heightInCm - 1).toString(),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF747474),
                            fontFamily: 'Zen',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 180,
                    width: 120,
                    child: Card.filled(
                      elevation: 0,
                      color: const Color(0xFFe2e2e2),
                      surfaceTintColor: const Color(0xFFe2e2e2),
                      child: Center(
                        child: Text(
                          heightInCm.toString(),
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF747474),
                            fontFamily: 'Zen',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 135,
                    width: 90,
                    child: Card.filled(
                      elevation: 0,
                      color: const Color(0xFFf7f7f7),
                      surfaceTintColor: const Color(0xFFf7f7f7),
                      child: Center(
                        child: Text(
                          (heightInCm + 1).toString(),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF747474),
                            fontFamily: 'Zen',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Slider
              VerticalWeightSlider(
                height: 60,
                unit: MeasurementUnit.inch,
                diameterRatio: 10000,
                controller: _controller,
                isVertical: false,
                haptic: Haptic.mediumImpact,
                decoration: const PointerDecoration(
                  width: 40.0,
                  height: 3.0,
                  smallColor: Color(0xFFd5d5d5),
                  largeColor: Color(0xFFd5d5d5),
                  mediumColor: Color(0xFFd5d5d5),
                  gap: 5.0,
                ),
                onChanged: (double value) {
                  setState(() {
                    heightInCm =
                        value.toInt(); // Update the value when the slider moves
                  });
                },
                indicator: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 3.0,
                  width: 40.0,
                  alignment: Alignment.centerLeft,
                ),
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: const [
        // CustomRoundedButton(
        //   text: 'Save',
        //   onPressed: () {},
        // ),
      ],
    );
  }
}
