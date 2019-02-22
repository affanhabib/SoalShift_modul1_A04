# Laporan Penjelasan

1. Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah nature.zip. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh file tersebut jika pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari jumat pada bulan Februari.
	Hint: Base64, Hexdump
	
	### Jawab
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

14 14 14 2 5 /bin/bash /home/aku/Downloads/SoalShift/soal1.sh

2. Anda merupakan pegawai magang pada sebuah perusahaan retail, dan anda diminta untuk memberikan laporan berdasarkan file WA_Sales_Products_2012-14.csv. Laporan yang diminta berupa:

	a. Tentukan negara dengan penjualan(quantity) terbanyak pada tahun 2012.
	
	b. Tentukan tiga product line yang memberikan penjualan(quantity)
terbanyak pada soal poin a.

	c. Tentukan tiga product yang memberikan penjualan(quantity) terbanyak berdasarkan tiga product line yang didapatkan pada soal poin b.
	
	### Jawab
	[Source Code](/soal2.sh)
	
	#### a. Negara dengan Penjualan Terbanyak
	```bash
	awk -F ',' '{if($7=="2012") qnt[$1]+=$10;} END {for(i in qnt) print qnt[i] "-" i}' WA_Sales_Products_2012-14.csv | sort -n -r | head -1 | awk -F '-' '{print "- " $2}'
	```
	
	- `if($7=="2012") qnt[$1]+=$10;` untuk menghitung quantity tiap-tiap negara pada tahun 2012.
	- `for(i in qnt) print qnt[i] "-" i` mencetak nama negara dan jumlah quantity-nya.
	- `sort -n -r` mengurutkan quantity terbesar ke terkecil.
	- `head -1` mengambil baris teratas.
	- `awk -F '-' '{print "- " $2}'` untuk hanya mencetak nama negara
	
	#### b. 3 Product Line Teratas pada Negara dengan Penjualan Terbanyak
	```bash
	awk -F ',' '{if($7=="2012" && $1=="United States") qnt[$4]+=$10;} END{for(i in qnt) print qnt[i] "-" i}' WA_Sales_Products_2012-14.csv | sort -n -r | head -3 | awk -F '-' '{print "- " $2}'
	```
	
	Hampir sama dengan poin a, namun ada sedikit tambahan.
	
	- `$1=="United States` karena yang diminta adalah Product Line pada negara dengan penjualan tertinggi.
	- `qnt[$4]+=$10;` menjadi `$4` karena dikelompokkan tiap Product Line (kolom4).
	- `head -3` mengambil 3 teratas.
	- `awk -F '-' '{print "- " $2}'` jika pada poin a digunakan untuk mencetak nama negara, sekarang untuk mencetak nma Product Line.
	
	#### c. 3 Product Teratas pada Product Line Teratas
	```bash
	awk -F ',' '{if($7=="2012" && $1=="United States" &&($4=="Personal Accessories" || $4=="Outdoor Protection" || $4=="Camping Equipment")) qnt[$6]+=$10;} END {for(i in qnt) print qnt[i] "-" i}' WA_Sales_Products_2012-14.csv | sort -n -r | head -3 | awk -F '-' '{print "* " $2}'
	```
	
	Perbedaan dengan yang sebelumnya,
	- `($4=="Personal Accessories" || $4=="Outdoor Protection" || $4=="Camping Equipment")` terdapat syarat tambahan berdasarkan Product Line 3 teratas.
	- `qnt[$6]+=$10;` penghitungan quantity dikelompokkan berdasarkan nama Product (kolom 6).

3. Buatlah sebuah script bash yang dapat menghasilkan password secara acak sebanyak 12 karakter yang terdapat huruf besar, huruf kecil, dan angka. Password acak tersebut disimpan pada file berekstensi .txt dengan ketentuan pemberian nama sebagai berikut:

	a. Jika tidak ditemukan file password1.txt maka password acak tersebut disimpan pada file bernama password1.txt

	b. Jika file password1.txt sudah ada maka password acak baru akan
disimpan pada file bernama password2.txt dan begitu seterusnya.

	c. Urutan nama file tidak boleh ada yang terlewatkan meski filenya
dihapus.

	d. Password yang dihasilkan tidak boleh sama.
	
	### Jawab
Untuk  membuat password secara random, maka digunakan perintah :
pass="$(dd if=/dev/urandom|tr -dc A-Za-z0-9|head -c 12)"

Selanjutnya, kita harus melakukan predict apakah string yang berasi ter generate terdiri dari 
uppercas, lowercas, dan angka.
low=0
            upp=0
            num=0
            for char in pass
            do
                if [[ $char == [A-Z] ]]
                    then
                    let upp=$upp+1;
                    fi
                if [[ $char == [a-z] ]]
                    then
                    let low=$low+1;
                    fi
                if [[ $char == [0-9] ]]
                    then
                    let num=$num+1;
                    fi
            done
            [ $upp -gt 0 ] && [ $low -gt 0] && [$num -gt 0]
do :;done

Setelah itu, untuk menyimpan file sesuai urutan, dan menseleksi apakah password sudah tergenerate atau belum, gunakan perintah:
i=1
        file=/home/aku/Downloads/SoalShift/pass/password
        while [ -f "$file$i.txt" ]
        do
                value=$(<$file$i.txt)
                if test "$temp" = "$pass"
                then
                        break
                fi
                let i=$i+1
        done
        if test "$temp" = "$pass"
        then
                continue
        fi
        break
        done
echo "$pass" >$file$i.txt
	
	
4. Lakukan backup file syslog setiap jam dengan format nama file “jam:menit tanggal- bulan-tahun”. Isi dari file backup terenkripsi dengan konversi huruf (string manipulation) yang disesuaikan dengan jam dilakukannya backup misalkan sebagai berikut:

	a. Huruf b adalah alfabet kedua, sedangkan saat ini waktu menunjukkan	pukul 12, sehingga huruf b diganti dengan huruf alfabet yang memiliki urutan ke 12+2 = 14.

	b. Hasilnya huruf b menjadi huruf n karena huruf n adalah huruf ke
empat belas, dan seterusnya.

	c. setelah huruf z akan kembali ke huruf a

	d. Backup file syslog setiap jam.

	e. dan buatkan juga bash script untuk dekripsinya.
	
	### Jawab
	

5. Buatlah sebuah script bash untuk menyimpan record dalam syslog yang memenuhi kriteria berikut:

	a. Tidak mengandung string “sudo”, tetapi mengandung string “cron”, serta buatlah pencarian stringnya tidak bersifat case sensitive,
sehingga huruf kapital atau tidak, tidak menjadi masalah.

	b. Jumlah field (number of field) pada baris tersebut berjumlah kurang dari 13.

	c. Masukkan record tadi ke dalam file logs yang berada pada direktori /home/[user]/modul1.

	d. Jalankan script tadi setiap 6 menit dari menit ke 2 hingga 30, contoh 13:02, 13:08, 13:14, dst.
	
	### Jawab
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
2-30/6 * * * * /bin/bash /home/aku/Downloads/SoalShift/soal5.sh
```
