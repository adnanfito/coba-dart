import 'dart:io';

List<String> tasks = [];

void main() {
  while (true) {
    print('\n--- APLIKASI TODO LIST ---');
    print('1. Tambah Tugas');
    print('2. Lihat Semua Tugas');
    print('3. Hapus Tugas');
    print('4. Keluar');
    print('--------------------------');
    stdout.write('Pilih menu: ');

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        addTask();
        break;
      case '2':
        viewTasks();
        break;
      case '3':
        deleteTask();
        break;
      case '4':
        print('Terima kasih! Sampai jumpa.');
        return;
      default:
        print('Pilihan tidak valid, silakan coba lagi.');
    }
  }
}

void addTask() {
  stdout.write('Masukkan nama tugas baru: ');
  String? task = stdin.readLineSync();

  if (task != null && task.isNotEmpty) {
    tasks.add(task);
    print(
      '"'
      '$task'
      '" berhasil ditambahkan!',
    );
  } else {
    print('Nama tugas tidak boleh kosong.');
  }
}

void viewTasks() {
  if (tasks.isEmpty) {
    print('Daftar tugas masih kosong.');
  } else {
    print('\n--- DAFTAR TUGAS ---');
    for (int i = 0; i < tasks.length; i++) {
      print('${i + 1}. ${tasks[i]}');
    }
    print('----------------------');
  }
}

void deleteTask() {
  viewTasks();
  if (tasks.isNotEmpty) {
    stdout.write('Masukkan nomor tugas yang ingin dihapus: ');
    String? input = stdin.readLineSync();

    if (input != null && input.isNotEmpty) {
      try {
        int index = int.parse(input) - 1;

        if (index >= 0 && index < tasks.length) {
          String removedTask = tasks.removeAt(index);
          print(
            'Tugas "'
            '$removedTask'
            '" berhasil dihapus.',
          );
        } else {
          print('Nomor tugas tidak ditemukan.');
        }
      } catch (e) {
        print('Input tidak valid. Harap masukkan nomor.');
      }
    }
  }
}
