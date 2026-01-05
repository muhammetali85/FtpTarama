FTP ile Tarama Klasörü Kurulumu ve Kullanımı 

Bu sistem, çok fonksiyonlu yazıcılardan yapılan taramaların doğrudan Linux bilgisayardaki bir klasöre düşmesini sağlar.

Sistemi Kurma
Adım 1 – Kodu İndirin

Terminali açın ve aşağıdaki komutları çalıştırın:

git clone https://github.com/muhammetali85/FtpTarama
cd FtpTarama

Adım 2 – Scripti Çalıştırılabilir Yapın
chmod +x FtpTarama.sh


(Script adı farklıysa, GitHub’daki dosya adına göre düzenleyin.)

Adım 3 – Scripti Çalıştırın
sudo ./FtpTarama.sh


Script otomatik olarak:

Pure-FTPd kurar (yoksa)

Oturum açmış kullanıcıyı bulur

Kullanıcının ev dizinine TARAMA klasörü oluşturur

Gerekli izinleri verir

bilgiler.txt dosyasını üretir

Kurulum tamamlandığında ekranda bir hata görmüyorsanız sistem hazırdır.



FTP servisi çalışıyor olmalıdır

Yazıcı ve bilgisayar aynı ağda olmalıdır

Klasör adı büyük harflerle TARAMA olmalıdır
