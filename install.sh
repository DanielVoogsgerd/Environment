cat <<EOM >/etc/yum.repos.d/epel-bootstrap.repo
[epel]
name=Bootstrap EPEL
mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=epel-\$releasever&arch=\$basearch
failovermethod=priority
enabled=0
gpgcheck=0
EOM


yum --enablerepo=epel -y install epel-release wget
rm -f /etc/yum.repos.d/epel-bootstrap.repo


cd /etc/yum.repos.d &&wget http://rpms.famillecollet.com/enterprise/remi.repo
yum --enablerepo=remi -y install puppet


# Set a progress bar in the Curl config
echo progress-bar >> ~/.curlrc

curl http://download.realiseweb.nl/init.pp | puppet

echo "Done installing the important stuff"

su - daniel -c="curl http://download.realiseweb.nl/environment | bash"
