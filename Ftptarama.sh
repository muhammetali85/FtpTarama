#!/bin/bash

# Root kontrolü
if [ "$EUID" -ne 0 ]; then
    echo "Bu script root olarak çalıştırılmalıdır."
    exit 1
fi

# Gerçek oturum açmış kullanıcıyı bul
if [ -n "$SUDO_USER" ]; then
    REAL_USER="$SUDO_USER"
else
    REAL_USER="$(whoami)"
fi

USER_HOME=$(eval echo "~$REAL_USER")
TARGET_DIR="$USER_HOME/TARAMA"

echo "Gerçek kullanıcı      : $REAL_USER"
echo "Kullanıcı home dizini : $USER_HOME"

echo "Pure-FTPd kontrol ediliyor..."

# Pure-FTPd kontrolü
if command -v pure-ftpd >/dev/null 2>&1 || command -v pure-ftpd-mysql >/dev/null 2>&1; then
    echo "Pure-FTPd zaten kurulu."
else
    echo "Pure-FTPd kurulu değil. Kurulum başlatılıyor..."

    if [ -f /etc/debian_version ]; then
        apt update -y
        apt install -y pure-ftpd
    elif [ -f /etc/redhat-release ]; then
        yum install -y epel-release
        yum install -y pure-ftpd
    else
        echo "Desteklenmeyen Linux dağıtımı."
        exit 1
    fi

    echo "Pure-FTPd kurulumu tamamlandı."
fi

echo "TARAMA dizini kontrol ediliyor..."

if [ -d "$TARGET_DIR" ]; then
    echo "TARAMA dizini mevcut. Yetkiler güncelleniyor..."
else
    echo "TARAMA dizini bulunamadı. Oluşturuluyor..."
    mkdir -p "$TARGET_DIR"
fi

# Sahiplik ve tam yetki ver
chown "$REAL_USER:$REAL_USER" "$TARGET_DIR"
chmod 777 "$TARGET_DIR"

echo "İşlem tamamlandı."
echo "Dizin    : $TARGET_DIR"
echo "Sahiplik : $REAL_USER"
echo "Yetkiler : 777 (rwxrwxrwx)"

############################################
# BİLGİLER.TXT OLUŞTURMA
############################################

# Scriptin çalıştırıldığı dizin
SCRIPT_DIR="$(pwd)"
INFO_FILE="$SCRIPT_DIR/bilgiler.txt"

# IP adresini al (aktif, non-loopback)
IP_ADDRESS=$(hostname -I | awk '{print $1}')

# Dosyayı oluştur ve yaz
cat <<EOF > "$INFO_FILE"
===== SİSTEM BİLGİLERİ =====

Kullanıcı Adı :
$REAL_USER

TARAMA Klasörü :
$TARGET_DIR

Bilgisayar IP Adresi :
$IP_ADDRESS

Oluşturulma Tarihi :
$(date '+%Y-%m-%d %H:%M:%S')

============================
EOF

echo "Bilgiler dosyası oluşturuldu:"
echo "$INFO_FILE"
