import 'package:eco_track/model/activity.dart';
import 'package:eco_track/model/activity_category.dart';
import 'package:flutter/material.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  List<EcoPuan> aktiviteler = [
    EcoPuan(activityName: "Yürüyüş", puan: 10),
    EcoPuan(activityName: "Bisiklet Sürme", puan: 20),
    EcoPuan(activityName: "Geri Dönüşüm", puan: 15),
    EcoPuan(activityName: "Toplu Taşıma Kullanma", puan: 5),
  ];

  int toplamPuan = 50;

  List<AktiviteKategori> kategoriler = [
    AktiviteKategori(kategoriAdi: "Yürüyüş", puan: 10),
    AktiviteKategori(kategoriAdi: "Bisiklet Sürme", puan: 20),
    AktiviteKategori(kategoriAdi: "Geri Dönüşüm", puan: 15),
    AktiviteKategori(kategoriAdi: "Toplu Taşıma Kullanma", puan: 5),
    AktiviteKategori(kategoriAdi: "Enerji Tasarrufu", puan: 25),
    AktiviteKategori(kategoriAdi: "Ağaç Dikme", puan: 30),
    AktiviteKategori(kategoriAdi: "Su Tasarrufu", puan: 10),
    AktiviteKategori(kategoriAdi: "Organik Gıda Tüketimi", puan: 20),
    AktiviteKategori(
        kategoriAdi: "Yenilenebilir Enerji Kullanımı", puan: 40),
    AktiviteKategori(kategoriAdi: "Doğa Temizliği", puan: 50),
  ];

  void puanEkle(int puan) {
    setState(() {
      toplamPuan += puan;
    });
  }

  void aktiviteEkle(String ad, int puan) {
    setState(() {
      aktiviteler.add(EcoPuan(activityName: ad, puan: puan));
      puanEkle(puan);
    });
  }

  Future<void> _showAddActivityDialog() async {
    AktiviteKategori? secilenKategori;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Yeni Aktivite Ekle'),
          content: DropdownButtonFormField<AktiviteKategori>(
            hint: const Text('Kategori Seçin'),
            items: kategoriler.map((AktiviteKategori kategori) {
              return DropdownMenuItem<AktiviteKategori>(
                value: kategori,
                child: Text(kategori.kategoriAdi),
              );
            }).toList(),
            onChanged: (value) {
              secilenKategori = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('İptal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Ekle'),
              onPressed: () {
                if (secilenKategori != null) {
                  aktiviteEkle(
                      secilenKategori!.kategoriAdi, secilenKategori!.puan);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aktivite Sayfası"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Toplam Puan: $toplamPuan",
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: aktiviteler.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.green[200],
                    elevation: 5,
                    child: ListTile(
                      title: Text(aktiviteler[index].activityName),
                      trailing: Text(
                        "+${aktiviteler[index].puan} puan",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      onTap: () => puanEkle(aktiviteler[index].puan),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _showAddActivityDialog,
              child: const Text('Yeni Aktivite Ekle'),
            ),
          ],
        ),
      ),
    );
  }
}
