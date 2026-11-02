import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/constants.dart';
import '../viewmodels/setting_view_model.dart';

class CurrencyDialog extends ConsumerStatefulWidget {
  const CurrencyDialog({super.key});

  @override
  ConsumerState<CurrencyDialog> createState() => _CurrencyDialogState();
}

class _CurrencyDialogState extends ConsumerState<CurrencyDialog> {
  late String selectedCurrency;

  @override
  void initState() {
    super.initState();
    selectedCurrency =
        ref.read(settingViewModelProvider).value ?? Constants.currencyVnd;
  }

  Future<void> saveCurrency() async {
    await ref
        .read(settingViewModelProvider.notifier)
        .changeCurrency(selectedCurrency);
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Đơn vị tiền tệ'),
      content: RadioGroup<String>(
        groupValue: selectedCurrency,
        onChanged: (value) {
          if (value != null) {
            setState(() {
              selectedCurrency = value;
            });
          }
        },
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: Text('VND (Việt Nam Đồng)'),
              value: Constants.currencyVnd,
            ),
            RadioListTile<String>(
              title: Text('USD (Đô la Mỹ)'),
              value: Constants.currencyUsd,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy'),
        ),
        FilledButton(onPressed: saveCurrency, child: const Text('Lưu')),
      ],
    );
  }
}
