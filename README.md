# Aplikasi Todo List Sederhana (Dart CLI)

Ini adalah aplikasi daftar tugas (*todo list*) sederhana yang berjalan di *command-line interface* (CLI). Aplikasi ini dibuat murni menggunakan bahasa Dart dan pustaka `dart:io` untuk interaksi dengan terminal.

Aplikasi ini memungkinkan pengguna untuk:

1.  Menambah tugas baru.
2.  Melihat semua tugas yang ada.
3.  Menghapus tugas dari daftar.
4.  Keluar dari aplikasi.

## Cara Menjalankan

1.  Pastikan Anda memiliki [Dart SDK](https://dart.dev/get-dart) terinstal di sistem Anda.
2.  Simpan kode dalam file bernama `todo.dart`.
3.  Buka terminal Anda dan navigasikan ke direktori tempat file tersebut disimpan.
4.  Jalankan perintah:
    ```bash
    dart todo.dart
    ```

## Penjelasan Kode

### 1\. Impor dan Variabel Global

```dart
import 'dart:io';

List<String> tasks = [];
```

  * **`import 'dart:io';`**: Mengimpor pustaka inti Dart untuk I/O (Input/Output). Ini diperlukan agar kita bisa membaca input dari keyboard (`stdin`) dan menampilkan output ke terminal (`stdout`).
  * **`List<String> tasks = [];`**: Ini adalah variabel global yang bertindak sebagai "database" sementara untuk aplikasi kita. Ini adalah sebuah `List` (daftar) yang akan menyimpan semua tugas (dalam bentuk `String`) selama aplikasi berjalan.

### 2\. Fungsi `main()`

```dart
void main() {
  while (true) {
    // ... (Tampilan Menu) ...
    stdout.write('Pilih menu: ');
    String? choice = stdin.readLineSync();

    switch (choice) {
      // ... (Cases 1, 2, 3) ...
      case '4':
        print('Terima kasih! Sampai jumpa.');
        return;
      // ... (Default) ...
    }
  }
}
```

  * **`void main()`**: Ini adalah **titik masuk** (entry point) utama program. Eksekusi kode dimulai dari sini.
  * **`while (true)`**: Ini adalah *loop* utama aplikasi. Kode di dalamnya akan terus berulang (menampilkan menu, meminta input) sampai pengguna secara eksplisit keluar.
  * **`stdout.write(...)`**: Menampilkan teks ke terminal *tanpa* pindah ke baris baru. Ini berguna untuk menampilkan *prompt* input (cth: "Pilih menu: ").
  * **`stdin.readLineSync()`**: Menjeda eksekusi dan menunggu pengguna mengetik sesuatu lalu menekan Enter. Apa pun yang diketik pengguna akan dibaca sebagai `String`.
  * **`switch (choice)`**: Struktur kontrol yang mengarahkan alur program berdasarkan nilai `choice`.
  * **`case '4': ... return;`**: Jika pengguna memilih '4', program akan mencetak pesan perpisahan dan menjalankan perintah `return`. Perintah `return` di dalam `main` akan menghentikan fungsi `main`, yang sekaligus menghentikan *loop* `while (true)` dan mengakhiri program.

### 3\. Fungsi `addTask()`

```dart
void addTask() {
  stdout.write('Masukkan nama tugas baru: ');
  String? task = stdin.readLineSync();

  if (task != null && task.isNotEmpty) {
    tasks.add(task);
    print('"$task" berhasil ditambahkan!');
  } else {
    print('Nama tugas tidak boleh kosong.');
  }
}
```

  * Fungsi ini dipanggil saat pengguna memilih menu '1'.
  * Ia meminta pengguna memasukkan nama tugas.
  * **`if (task != null && task.isNotEmpty)`**: Ini adalah validasi sederhana untuk memastikan pengguna tidak memasukkan string kosong.
  * **`tasks.add(task)`**: Jika valid, nama tugas baru akan ditambahkan ke akhir `List` global `tasks`.

### 4\. Fungsi `viewTasks()`

```dart
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
```

  * Fungsi ini dipanggil saat pengguna memilih menu '2'.
  * **`if (tasks.isEmpty)`**: Pertama, ia memeriksa apakah ada tugas di dalam `List`.
  * **`for (int i = 0; i < tasks.length; i++)`**: Jika ada, ia akan melakukan *looping* (perulangan) sebanyak jumlah tugas yang ada.
  * **`print('${i + 1}. ${tasks[i]}');`**: Mencetak setiap tugas. Perhatikan `${i + 1}`, ini dilakukan agar nomor tugas yang ditampilkan ke pengguna dimulai dari **1**, meskipun *index* `List` sebenarnya dimulai dari **0**.

### 5\. Fungsi `deleteTask()`

```dart
void deleteTask() {
  viewTasks(); // Tampilkan tugas terlebih dahulu
  if (tasks.isNotEmpty) {
    stdout.write('Masukkan nomor tugas yang ingin dihapus: ');
    String? input = stdin.readLineSync();

    if (input != null && input.isNotEmpty) {
      try {
        int index = int.parse(input) - 1;

        if (index >= 0 && index < tasks.length) {
          String removedTask = tasks.removeAt(index);
          print('Tugas "$removedTask" berhasil dihapus.');
        } else {
          print('Nomor tugas tidak ditemukan.');
        }
      } catch (e) {
        print('Input tidak valid. Harap masukkan nomor.');
      }
    }
  }
}
```

  * Fungsi ini dipanggil saat pengguna memilih menu '3'.
  * **`viewTasks()`**: Fungsi `viewTasks()` dipanggil terlebih dahulu agar pengguna bisa melihat nomor tugas yang ingin dihapus.
  * **`try { ... } catch (e) { ... }`**: Blok ini digunakan untuk *error handling*. Jika pengguna memasukkan sesuatu yang bukan angka (misal: "abc"), `int.parse(input)` akan gagal dan program akan *crash*. `try-catch` menangkap *error* tersebut dan mencetak pesan yang lebih ramah pengguna.
  * **`int index = int.parse(input) - 1;`**: Mengubah input `String` (misal: "1") menjadi `int` (angka 1). Kemudian, dikurangi 1 untuk mendapatkan *index* `List` yang benar (karena *index* list dimulai dari 0).
  * **`if (index >= 0 && index < tasks.length)`**: Validasi untuk memastikan nomor yang dimasukkan pengguna valid dan ada di dalam `List`.
  * **`tasks.removeAt(index)`**: Menghapus item dari `List` pada *index* yang telah ditentukan.
