#!/bin/bash
sudo tee /etc/ImageMagick-6/policy.xml > /dev/null <<EOT
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE policymap [
  <!ELEMENT policymap (policy)+>
  <!ATTLIST policymap xmlns CDATA #FIXED ''>
  <!ELEMENT policy EMPTY>
  <!ATTLIST policy xmlns CDATA #FIXED '' domain NMTOKEN #REQUIRED
    name NMTOKEN #IMPLIED pattern CDATA #IMPLIED rights NMTOKEN #IMPLIED
    stealth NMTOKEN #IMPLIED value CDATA #IMPLIED>
]>
<policymap>
  <policy domain="resource" name="memory" value="256MiB"/>
  <policy domain="resource" name="map" value="512MiB"/>
  <policy domain="resource" name="width" value="16KP"/>
  <policy domain="resource" name="height" value="16KP"/>
  <policy domain="resource" name="area" value="128MB"/>
  <policy domain="resource" name="disk" value="1GiB"/>
  <policy domain="delegate" rights="none" pattern="URL" />
  <policy domain="delegate" rights="none" pattern="HTTPS" />
  <policy domain="delegate" rights="none" pattern="HTTP" />
  <policy domain="path" rights="read" pattern="@*"/>
  <policy domain="coder" rights="none" pattern="PS" />
  <policy domain="coder" rights="none" pattern="PS2" />
  <policy domain="coder" rights="none" pattern="PS3" />
  <policy domain="coder" rights="none" pattern="EPS" />
  <policy domain="coder" rights="none" pattern="PDF" />
  <policy domain="coder" rights="none" pattern="XPS" />
</policymap>
EOT
sudo mkdir /home/dt/QC
cd /home/dt/QC
./test.sh>text.txt
convert -size 2480x3508 -background white -fill black -font Courier label:"$(cat text.txt)" ref.jpg
echo "----------------------------------------script converted to jpg----------------------------------------"
img2pdf ref.jpg -o final.pdf
sleep 1
echo "-----------------------------------------------pdf is uploading-----------------------------------------------"
sshpass -p detect12345 scp final.pdf iot@172.16.100.173:/home/iot/QC-form-all
echo "++++++++++++++++++++++++++++++++++++++++++++Uploaded done++++++++++++++++++++++++++++++++++++++++++++++++++++"
