# SoalShift_modul1_A01

index |
--- | 
[nomor 1](#no1) |
[nomor 2](#no2) |
[nomor 3](#no3) |
[nomor 4](#no4) |
[nomor 5](#no5) |

### <a name="no1" ></a>Nomor 1
---
Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah
dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah
nature.zip. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh
file tersebut jika pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari
jumat pada bulan Februari.

``` bash
for f in ./nature/*; do
        hexdump -C "$f"
        base64 -d "$f" | xxd -r > ./nature/hasil/$(basename $f .jpg)_baru.jpg
done
```
__penjelasan__

asumsi kita telah mendownload *`nature.zip`* . 
file tersebut berisi gambar-gambar yang telah terenkripsi dengan `base64`
selanjutnya membuat folder baru bernama `nature` dan di dalam folder tersebut kita buatkan folder dengan nama `hasil` .
barulah membuat file script bash dengan nama `prak1soal1.sh`

``` bash
for f in ./nature/*; do
        ...
done
```
syntax di atas digunakan untuk fungsi *for each* pada semua file foto yang ada di dalam folder nature.

``` bash
hexdump -C "$f"
done
```
syntax di atas digunakan untuk menjaadikan *hexadeximal* .

``` bash
base64 -d "$f" | xxd -r > ./nature/hasil/$(basename $f .jpg)_baru.jpg
done
```
syntax di atas digunakan untuk men*decode* file gambar yang telah di*hexdump* lalu di*reverse* ke bentuk format gambar kembali ke *binary* .

barulah kita masukkan ke dalam crontab untuk pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah harijumat pada bulan Februari
```
14 14 14 2 5 /bin/bash /home/vagrant/prak1soal1.sh
```
salah satu hasil gambarnya
![alt text](https://raw.githubusercontent.com/siannas/SoalShift_modul1_A01/master/assets/45598582_271525256867288_4803901167934701139_n_baru.jpg "Gambar_hasil_1")


### <a name="no2" ></a>Nomor 2
---
Anda merupakan pegawai magang pada sebuah perusahaan retail, dan anda diminta
untuk memberikan laporan berdasarkan file WA_Sales_Products_2012-14.csv.
Laporan yang diminta berupa:

* a. Tentukan negara dengan penjualan(quantity) terbanyak pada tahun 2012.
* b. Tentukan tiga product line yang memberikan penjualan(quantity)terbanyak pada soal poin a.
* c. Tentukan tiga product yang memberikan penjualan(quantity)terbanyak berdasarkan tiga product line yang didapatkan pada soalpoin b.

``` shell
file="assets/WA_Sales_Products_2012-14.csv"

temp=`awk 'BEGIN { FS = ","; OFS= ";";ORS="|"} ; { if($7==2012) print $1,$4,$6,$10}' < $file | sort -t ';' -k 4 -V -r `

# 2.a
echo "Nomor 2A"
echo $temp | awk 'BEGIN { FS = ";" ; RS="|"} NR>1{print $1} NR==2{exit}'

# 2.b
echo ""
echo "Nomor 2B"
produk=`echo $temp | awk 'BEGIN {FS=";" ; RS="|" ; ORS="|" } ( NR>1 && !seen[$2]++ ){print $2}' | awk 'BEGIN{FS=";" ; RS="|" ; ORS="|"}{print $0} NR==3{exit}'`
echo $produk | awk 'BEGIN {FS=";" ; RS="|"} {print}'

# 2.c
echo "Nomor 2C"
IFS='|' read -r -a array <<< $produk

for element in "${array[@]}"
do
        echo $temp | awk -v cmpr="$element" 'BEGIN {FS=";" ; RS="|" } ( $2==cmpr ){print $3}' | head -1
done
```
__penjelasan__

asumsi kita telah mendownload *`assets/WA_Sales_Products_2012-14.csv`* . 
File tersebut berisi sekumpulan data Produk, kuantitas, negara , dan lain-lain. 
Pertama tama kita perlu mendapatkan data yang dibutuhkan.
``` shell
file="assets/WA_Sales_Products_2012-14.csv"
temp=`awk 'BEGIN { FS = ","; OFS= ";";ORS="|"} ; { if($7==2012) print $1,$4,$6,$10}' < $file | sort -t ';' -k 4 -V -r `
```
syntax di atas digunakan untuk mengambil file yang dimaksud lalu diambil data-data yang diperlukan yaitu negara, produk, produk line, dan kuantitas. 
Semua data tersebut kemudian diurutkan dari kuantitas terbersar hingga terkecil dan disimpan dalam variabel *temp* untuk digunakan di pertanyaan berikutnya.

``` shell
# 2.a
echo "Nomor 2A"
echo $temp | awk 'BEGIN { FS = ";" ; RS="|"} NR>1{print $1} NR==2{exit}'
```
Pada nomor 2a cukup dengan menampilkan nama negara pada urutan teratas yang ada dalam variabel *temp* .

``` shell
# 2.b
echo ""
echo "Nomor 2B"
produk=`echo $temp | awk 'BEGIN {FS=";" ; RS="|" ; ORS="|" } ( NR>1 && !seen[$2]++ ){print $2}' | awk 'BEGIN{FS=";" ; RS="|" ; ORS="|"}{print $0} NR==3{exit}'`
echo $produk | awk 'BEGIN {FS=";" ; RS="|"} {print}'
```
Pada nomor 2b kita perlu mengolah data yang ada dalam variabel *temp* . data yang dimaksud diambil pada field `product line` yaitu pada field ke `2` .
jangan lupa tambahkan kondisi `!seen[$2]++` agar muncul secara identik.
Barulah kita tampilkan hasil sebanyak tiga teratas saja. Hasil tersebut kita masukkan ke dalam variabel produk agar bisa digunakan pada soal berikutnya.

``` shell
# 2.c
echo "Nomor 2C"
IFS='|' read -r -a array <<< $produk
```
syntax di atas digunakan untuk membuat array dengan nama *array* dari data product line dalam variabel produk.

``` shell
for element in "${array[@]}"
do
        echo $temp | awk -v cmpr="$element" 'BEGIN {FS=";" ; RS="|" } ( $2==cmpr ){print $3}' | head -1
done
```
Berikutnya kita tampilkan produk teratas pada setiap produk line dengan menggunakan `for`. 



### <a name="no3" ></a>Nomor 3
---
Buatlah sebuah script bash yang dapat menghasilkan password secara acak
sebanyak 12 karakter yang terdapat huruf besar, huruf kecil, dan angka. Password
acak tersebut disimpan pada file berekstensi .txt dengan ketentuan pemberian nama
sebagai berikut:

* a. Jika tidak ditemukan file password1.txt maka password acak tersebut disimpan pada file bernama password1.txt
* b. Jika file password1.txt sudah ada maka password acak baru akan disimpan pada file bernama password2.txt dan begitu seterusnya.
* c. Urutan nama file tidak boleh ada yang terlewatkan meski filenya dihapus.
* d. Password yang dihasilkan tidak boleh sama.



### <a name="no4" ></a>Nomor 4
---
Lakukan backup file syslog setiap jam dengan format nama file “jam:menit tanggal-
bulan-tahun”. Isi dari file backup terenkripsi dengan konversi huruf (string
manipulation) yang disesuaikan dengan jam dilakukannya backup misalkan sebagai
berikut:

* a. Huruf b adalah alfabet kedua, sedangkan saat ini waktu menunjukkanpukul 12, sehingga huruf b diganti dengan huruf alfabet yang memiliki urutan ke 12+2 = 14.
* b. Hasilnya huruf b menjadi huruf n karena huruf n adalah huruf ke empat belas, dan seterusnya.
* c. setelah huruf z akan kembali ke huruf a
* d. Backup file syslog setiap jam.
* e. dan buatkan juga bash script untuk dekripsinya.



### <a name="no5" ></a>Nomor 5
---
Buatlah sebuah script bash untuk menyimpan record dalam syslog yang memenuhi
kriteria berikut:

* a. Tidak mengandung string “sudo”, tetapi mengandung string “cron”, serta buatlah pencarian stringnya tidak bersifat case sensitive, sehingga huruf kapital atau tidak, tidak menjadi masalah.
* b. Jumlah field (number of field) pada baris tersebut berjumlah kurang dari 13.
* c. Masukkan record tadi ke dalam file logs yang berada pada direktori `/home/[user]/modul1.`
* d. Jalankan script tadi setiap 6 menit dari menit ke 2 hingga 30, contoh 13:02, 13:08, 13:14, dst.

``` shell
awk '/cron/ || /CRON/ && !/sudo/ && !/SUDO/' /var/log/syslog | awk 'NF < 13' >> /home/vagrant/modul1/syslogno5.log
```

__penjelasan__

``` shell
awk '/cron/ || /CRON/ && !/sudo/ && !/SUDO/' /var/log/syslog
```
Perintah awk di atas untuk mencari data pada *`syslog`* dengan kata kunci **cron** dan bukan **sudo** dan harus *case insensitive* .

barulah kita tampilkan line syslog degan jumlah field kurang dari 13 dan dimasukkan ke dalam file `/home/vagrant/modul1/syslogno5.log`

untuk mensetting crontab:
Every 6th minutes, from 2 through 30.

``` shell
2-30/6 * * * * /bin/bash /home/vagrant/prak1soal5.sh
```
