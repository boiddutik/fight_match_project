import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vertical_weight_slider/vertical_weight_slider.dart';

import '../../../../core/constants/svgs.dart';
import '../../../../core/utils/measurement_converters.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  final _controller = WeightSliderController(
    initialWeight: 175,
    interval: 1,
    minWeight: 25,
    maxWeight: 1500,
  );
  int weightInLb = 175;
  bool isLb = true;

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
          'Weight',
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isLb = false;
                        });
                      },
                      child: Chip(
                        elevation: 0,
                        labelStyle: TextStyle(
                          color: isLb ? Colors.black : Colors.white,
                        ),
                        label: const SizedBox(
                          width: 30,
                          child: Center(
                            child: Text(
                              'Kg',
                              style: TextStyle(
                                fontFamily: 'Zen',
                              ),
                            ),
                          ),
                        ),
                        backgroundColor:
                            isLb ? Colors.white : const Color(0xFF2b2b2b),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color:
                                isLb ? Colors.white : const Color(0xFF2b2b2b),
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isLb = true; // Switch to inch
                        });
                      },
                      child: Chip(
                        elevation: 0,
                        labelStyle: TextStyle(
                          color: isLb ? Colors.white : Colors.black,
                        ),
                        label: const SizedBox(
                          width: 30,
                          child: Center(
                            child: Text(
                              'Lb',
                              style: TextStyle(
                                fontFamily: 'Zen',
                              ),
                            ),
                          ),
                        ),
                        backgroundColor:
                            isLb ? const Color(0xFF2b2b2b) : Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color:
                                isLb ? const Color(0xFF2b2b2b) : Colors.white,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(Svgs.indicatorHeightAndWeight),
                ],
              ),
              const SizedBox(height: 20),
              // Value Cards
              SizedBox(
                height: 110,
                width: 120,
                child: Card.filled(
                  elevation: 0,
                  color: const Color(0xFFe2e2e2),
                  surfaceTintColor: const Color(0xFFe2e2e2),
                  child: Center(
                    child: Text(
                      !isLb
                          ? poundsToKg(weightInLb).toString()
                          : weightInLb.toString(),
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
              const SizedBox(height: 50),
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
                    weightInLb = value.toInt();
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
      persistentFooterButtons: [
        ElevatedButton(
          child: const Text('Save'),
          onPressed: () {},
        ),
      ],
    );
  }
}
