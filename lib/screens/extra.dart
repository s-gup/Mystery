//import 'package:flutter/material.dart';
//
//class Extra extends StatefulWidget {
//  @override
//  _ExtraState createState() => _ExtraState();
//}
//
//class _ExtraState extends State<Extra> {
//  @override
//
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          title: Text('BMI CALCULATOR'),
//        ),
//        body: Column(
//          crossAxisAlignment: CrossAxisAlignment.stretch,
//          children: <Widget>[
//            Expanded(
//                child: Row(
//                  children: <Widget>[
//                    Expanded(
//                      child: ReusableCard(
//                        onPress: () {
//                          setState(() {
//                            selectedCard = Gender.male;
//                          });
//                        },
//                        colour: selectedCard == Gender.male
//                            ? kActiveCardColor
//                            : kInactiveCardColor,
//                        cardChild: IconContents(
//                          icon: FontAwesomeIcons.mars,
//                          label: 'MAN',
//                        ),
//                      ),
//                    ),
//                    Expanded(
//                      child: ReusableCard(
//                        onPress: () {
//                          setState(() {
//                            selectedCard = Gender.female;
//                          });
//                        },
//                        colour: selectedCard == Gender.female
//                            ? kActiveCardColor
//                            : kInactiveCardColor,
//                        cardChild: IconContents(
//                          icon: FontAwesomeIcons.venus,
//                          label: 'WOMAN',
//                        ),
//                      ),
//                    )
//                  ],
//                )),
//            Expanded(
//              child: ReusableCard(
//                colour: kActiveCardColor,
//                cardChild: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Text(
//                      'HEIGHT',
//                      style: kLabelTestStyle,
//                    ),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      crossAxisAlignment: CrossAxisAlignment.baseline,
//                      textBaseline: TextBaseline.alphabetic,
//                      children: <Widget>[
//                        Text(
//                          height.toString(),
//                          style: kNumberTextStyle,
//                        ),
//                        Text(
//                          'cm',
//                          style: kLabelTestStyle,
//                        )
//                      ],
//                    ),
//                    SliderTheme(
//                      data: SliderTheme.of(context).copyWith(
//                        inactiveTrackColor: Color(0xFF8D8E98),
//                        thumbColor: Color(0xFFEB1555),
//                        activeTrackColor: Colors.white,
//                        overlayColor: Color(0x29EB1555),
//                        thumbShape:
//                        RoundSliderThumbShape(enabledThumbRadius: 15.0),
//                        overlayShape:
//                        RoundSliderOverlayShape(overlayRadius: 30.0),
//                      ),
//                      child: Slider(
//                        value: height.toDouble(),
//                        min: 120.0,
//                        max: 220.0,
//                        onChanged: (double newValue) {
//                          setState(() {
//                            height = newValue.round();
//                          });
//                        },
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ),
//            Expanded(
//              child: Row(
//                children: <Widget>[
//                  Expanded(
//                    child: ReusableCard(
//                      colour: kActiveCardColor,
//                      cardChild: Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          Text(
//                            'WEIGHT',
//                            style: kLabelTestStyle,
//                          ),
//                          Text(
//                            weight.toString(),
//                            style: kNumberTextStyle,
//                          ),
//                          Row(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              RoundIconButton(
//                                icon: FontAwesomeIcons.minus,
//                                onPress: () {
//                                  setState(() {
//                                    weight--;
//                                  });
//                                },
//                              ),
//                              SizedBox(
//                                width: 10,
//                              ),
//                              RoundIconButton(
//                                icon: FontAwesomeIcons.plus,
//                                onPress: () {
//                                  setState(() {
//                                    weight++;
//                                  });
//                                },
//                              )
//                            ],
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),
//                  Expanded(
//                    child: ReusableCard(
//                      colour: kActiveCardColor,
//                      cardChild: Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          Text(
//                            'AGE',
//                            style: kLabelTestStyle,
//                          ),
//                          Text(
//                            age.toString(),
//                            style: kNumberTextStyle,
//                          ),
//                          Row(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              RoundIconButton(
//                                icon: FontAwesomeIcons.minus,
//                                onPress: () {
//                                  setState(() {
//                                    age--;
//                                  });
//                                },
//                              ),
//                              SizedBox(
//                                width: 10,
//                              ),
//                              RoundIconButton(
//                                icon: FontAwesomeIcons.plus,
//                                onPress: () {
//                                  setState(() {
//                                    age++;
//                                  });
//                                },
//                              )
//                            ],
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//            GestureDetector(
//              onTap: () {
//                CalculatorBrain calc = CalculatorBrain(height, weight);
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                    builder: (context) => ResultPage(
//                      bmiResult: calc.getResult(),
//                      resValue: calc.calculateBMI(),
//                      interpretation: calc.getInterpretation(),
//                    ),
//                  ),
//                );
//              },
//              child: Container(
//                child: Center(
//                  child: Text(
//                    'CALCULATE',
//                    style: kLargeButtonTextStyle,
//                  ),
//                ),
//                width: double.infinity,
//                height: kBottomContainerHeight,
//                color: kBottomContainerColor,
//                margin: EdgeInsets.only(top: 10.0),
//                padding: EdgeInsets.only(bottom: 20.0),
//              ),
//            )
//          ],
//        ));
//  }
//}
//
//}
