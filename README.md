Program 5 sh dosyasından oluşmaktadır.
Bunlar;
sync_files.sh // Dosyaları silme ve yeniden oluşturma sıfırlama (log, tmp, osman_output).
rand_generator.sh // Random sayı, harf oluşturma ve osman txt'lerini oluşturma.
zip_unzip_files.sh // Osman txt'leri zipleme ve zipten çıkartma. 
move_files.sh // Threadlerin işlenebilmesi için dosyaları move'lama.   
thread_5.sh // Tmp dosyasının altındaki threadleri işleme.

Programın işleyini genel olarak şöyle ;
Ana sh olarak rand_generator.sh çalıştırdığımız zaman, ilk olarak sync_files.sh log, osman_output, tmp ve altında threadlerin işleneceği 1,2,3,4,5 dosyalarını oluşturuyor. rand_generator.sh'ı her çalıştırdığımız zaman bu dosyaları silip tekrar oluşturuyor. Her bilgisayarda çalışması için pwd ile uzantıları ayarladım.

Dosyaların işlenmesinin zaman almasından dolayı ben max size'ı 512 kb belirledim ve ve max size'a göre 1000 satırlı 32 txt dosyası oluşuyor. Thread olarak ise 5 belirledim ve 7 7 7 7 4 şeklinde dosyaları atıyorum ve işletiyorum. Bu boyutlar kontrollü yapı şeklinde genişletilebilir.

1) Dosyaları silme ve tekrar oluşturma ( sync_files.sh ) :
rand_generator.sh'ı çalıştırdığım zaman ilk başta sync_files.sh scriptini çalıştırarak bir senkronizasyon işlemi yapıyorum ve sistemi kurduğum yapıya hazır hale getiriyorum. rand_generator.sh'ı ilk çalıştırdığım zaman file_list.txt, log, tmp ve osman_output dosyalarını oluşturtuyorum. Daha sonraki çalıştırmada bu dosyalar varsa yapı çalıştığı zaman kbunları siliyorum ve yeniden boş dosyaları oluşturuyorum, bu şekilde formatlanmış ve ilk çalıştırdığım haline dönüyor. Daha sonradan karmaşıklık olmaması için konrollü bir yapı oluşturdum.

2) Osman.txt'lerini oluşturma ( rand_generator.sh ) :
İçinde belirlemiş olduğum maksimum size=512KB boyutuna göre log dosyasının içinde her biri 1000 satır, içerisinde rastgele 9 basamaklı sayı ve 5 karakter bulunan osman1.txt ... osman32.txt şeklinde 32 tane dosya oluşturuyor.

3) Zipleme ve Zipten çıkartma ( ) :
zip_unzip_files.sh scripti ile osman1.txt ... osman32.txt dosyalarını txt_logs.zip şeklinde log dosyası içinde zipliyor. Ardından unzipped_files klasörü oluşturup dosyaları buraya çıkartıyor.

4) Osman Dosyalarını Thread İşlemi İçin Taşıma :
Bu işlemi tmp ve altına 1,2,3,4,5 şeklinde klasörler oluşturarak yaptım. 32 dosyayı 7 7 7 7 4 şeklinde 5 dosyaya taşıyor. Taşıma mantığı ise "$ ls log | grep osman | head -7 " komutu ile osman isimli dosyaları grepliyorum 7'sini alıyorum ve file_list.txt isimli dosyaya taşınacak dosyaları echo'lattırıyorum. Ardından for döngüsü ile file_list.txt dosyasının line'larını okutup teker teker out klasöründen tmp/1,2,3,4,5 klasörüne sırayla move ediyorum.

5) 5 Thread ile Dosyaları İşleme :
Bir önceki adımda tmp/1,2,3,4,5 klasörlerine işlenmemiş osman1.txt ... osman32.txt dosyaları sırayla taşındı. Bu sh'da bir thread func oluşturdum oluşturduğum bu functionda çalışan pid ve runtime'ı alıyorum. İlk for ile tmp/1 dosyasının içine giriyorum ve içinde bulunan dosyaları awk komutu ile birlikte 26 geçen satırları filterlıyorum, "hostname -I | awk '{print $1}'" komutu ile pc ip adresini alıyorum (ip kısmında print $1 bazı bilgisayarlarda $2 olabiliyor). filename'i alıyorum ve dosya isimleri "$1"_"$get_pid"_"$get_rtime".txt olacak şekilde dosyaları işliyorum. Bu aşamada satırlar "576266764 dtjka" bu haldeyken "192.168.1.47 tmp/1/osman10.txt 576266764 dtjka" bu şekilde filtrelenip işleniyor.
En son bir for ile bu txt'leri teker teker dolaşıp birleştiriyor ve ardından küçükten büyüğe sıralayıp "osman_output/last_osman_sorted_out_"$get_rtime".txt" şeklinde dosyaya kaydediyorum.
