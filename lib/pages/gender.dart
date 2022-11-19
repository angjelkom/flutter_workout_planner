import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../widgets/gender.dart';

class GenderPage extends ConsumerStatefulWidget {
  const GenderPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GenderPageState();
}

class _GenderPageState extends ConsumerState<GenderPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'How do you identify?',
          style: Theme.of(context).textTheme.headline6,
        ),
        Expanded(
          child: Center(
            child: GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 4 / 3, crossAxisCount: 2),
                children: const [
                  GenderWidget(
                    name: 'Male',
                    icon: MdiIcons.genderMale,
                    color: Color(0xff2b9ef6),
                  ),
                  GenderWidget(
                      name: 'Female',
                      icon: MdiIcons.genderFemale,
                      color: Color(0xffe447a1)),
                  GenderWidget(
                      name: 'Intersex',
                      icon: MdiIcons.genderMaleFemale,
                      colors: [Color(0xfffcd94c), Color(0xff701eb1)]),
                  GenderWidget(
                      name: 'Genderfluid',
                      icon: MdiIcons.genderMaleFemaleVariant,
                      colors: [Color(0xfff975a1), Color(0xff333ebc)]),
                  GenderWidget(
                    name: 'Trans',
                    icon: MdiIcons.genderTransgender,
                    colors: [Color(0xff78cbf5), Color(0xffeaabb8)],
                  ),
                  GenderWidget(
                    name: 'Non Binary',
                    icon: MdiIcons.genderNonBinary,
                    colors: [Color(0xfffef42f), Color(0xff9c59d2)],
                  ),
                ]),
          ),
        ),
      ],
    );
  }
}
