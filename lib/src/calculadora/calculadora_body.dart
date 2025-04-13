import 'package:flutter/material.dart';
import 'package:net_split/src/resultados/resultados_screen.dart';
import 'package:net_split/src/shared/controllers/providers/provider.dart';
import 'package:net_split/src/widgets/UI/cidr_picker.dart';
import 'package:net_split/src/widgets/UI/custom_text.dart';
import 'package:net_split/src/widgets/UI/ip_picker.dart';
import 'package:net_split/src/widgets/subnet_mask_picker.dart';
import 'package:provider/provider.dart';

class CalculadoraBody extends StatelessWidget {
  const CalculadoraBody({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final calculatorState = context.watch<CalculatorState>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          'Endereço IP:',
          color: Colors.blue,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.025),
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IpPicker(
                  inputIp: calculatorState.inputIp,
                  onChangeIpAddress: (newIp) {
                    calculatorState.setIp(newIp);
                    calculatorState.setIpError(null);
                  },
                  inputIpError: calculatorState.ipError,
                ),
                CidrPicker(
                  inputCidr: calculatorState.inputCidr,
                  onChangeCidr: (newCidr) {
                    calculatorState.setCidr(newCidr);
                    calculatorState.setCidrError(null);
                  },
                  errorText:
                      calculatorState.cidrError ??
                      calculatorState.liveCidrError,
                  onValidate:
                      (value) => calculatorState.validateCidrLive(value),
                ),
              ],
            ),
          ],
        ),
        SubnetMaskPicker(
          inputMask: calculatorState.inputMask,
          onChangeMask: calculatorState.setMask,
          cidr: calculatorState.inputCidr,
          onChangeCidr: (newCidr) {
            // Use the combined update method
            calculatorState.updateCidrAndMask(newCidr);
          },
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                calculatorState.canCalculate
                    ? const Color.fromARGB(255, 233, 30, 99)
                    : const Color.fromARGB(255, 161, 126, 138),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            disabledBackgroundColor:
                isDark
                    ? const Color.fromARGB(255, 177, 127, 145)
                    : const Color.fromARGB(255, 196, 145, 162),
            disabledForegroundColor: Colors.white,
          ),
          onPressed:
              calculatorState.canCalculate
                  ? () {
                    calculatorState.calculateSubnet();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ResultadosScreen(
                              ip: calculatorState.inputIp,
                              mask: calculatorState.inputMask,
                              cidr: calculatorState.inputCidr.toString(),
                            ),
                      ),
                    );
                  }
                  : null,
          child: CustomText(
            "CALCULAR",
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
