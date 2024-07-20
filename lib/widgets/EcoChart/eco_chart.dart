import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'eco_chart_model.dart';

class EcoChart extends StatelessWidget {
  const EcoChart({super.key});

  @override
  Widget build(BuildContext context) {
    //*TODO: Veriler Veri Tabanından gelecek
    final List<ChartData> chartData = [
      ChartData('Plastik', 34, Colors.green),
      ChartData('Cam', 30, Colors.blueAccent),
      ChartData('Elektrik', 25, Colors.blueGrey),
      ChartData('Diğerleri', 8, Colors.orange)
    ];

    return Center(
      child: SfCircularChart(
        tooltipBehavior: TooltipBehavior(
          enable: true,
          format: '%point.y',
        ),
        series: <CircularSeries>[
          // Render pie chart
          PieSeries<ChartData, String>(
            dataSource: chartData,
            pointColorMapper: (ChartData data, _) => data.color,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            dataLabelMapper: (ChartData data, _) =>
                data.x, // Etiketin hangi değeri alacağını seçiyoruz
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition
                  .outside, // Etiketlerin dışarıda olmasını sağlıyor.
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
