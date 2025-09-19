###安装最新稳定版本7.1.0
######-----参考鲲鹏社区移植步骤，适配HCE2.0-----######

#配置Yum源
##HCE官网上说可以配置openEulerOS的源
##https://support.huaweicloud.com/usermanual-hce/hce_repo.html#section1
##结合来看，鲲鹏社区的应该可行

#备份
mkdir /etc/yum.repos.d/bak
mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/bak
#配置openEulerOS 22.03源
sudo cat > /etc/yum.repos.d/openEuler.repo << 'EOF'
[OS]
name=OS
baseurl=http://repo.openeuler.org/openEuler-22.03-LTS-SP1/OS/$basearch/
enabled=1
gpgcheck=1
gpgkey=http://repo.openeuler.org/openEuler-22.03-LTS-SP1/OS/$basearch/RPM-GPG-KEY-openEuler

[everything]
name=everything
baseurl=http://repo.openeuler.org/openEuler-22.03-LTS-SP1/everything/$basearch/
enabled=1
gpgcheck=1
gpgkey=http://repo.openeuler.org/openEuler-22.03-LTS-SP1/everything/$basearch/RPM-GPG-KEY-openEuler

[EPOL]
name=EPOL
baseurl=http://repo.openeuler.org/openEuler-22.03-LTS-SP1/EPOL/main/$basearch/
enabled=1
gpgcheck=1
gpgkey=http://repo.openeuler.org/openEuler-22.03-LTS-SP1/OS/$basearch/RPM-GPG-KEY-openEuler

[debuginfo]
name=debuginfo
baseurl=http://repo.openeuler.org/openEuler-22.03-LTS-SP1/debuginfo/$basearch/
enabled=1
gpgcheck=1
gpgkey=http://repo.openeuler.org/openEuler-22.03-LTS-SP1/debuginfo/$basearch/RPM-GPG-KEY-openEuler

[source]
name=source
baseurl=http://repo.openeuler.org/openEuler-22.03-LTS-SP1/source/
enabled=1
gpgcheck=1
gpgkey=http://repo.openeuler.org/openEuler-22.03-LTS-SP1/source/RPM-GPG-KEY-openEuler

[update]
name=update
baseurl=http://repo.openeuler.org/openEuler-22.03-LTS-SP1/update/$basearch/
enabled=1
gpgcheck=1
gpgkey=http://repo.openeuler.org/openEuler-22.03-LTS-SP1/OS/$basearch/RPM-GPG-KEY-openEuler

[update-source]
name=update-source
baseurl=http://repo.openeuler.org/openEuler-22.03-LTS-SP1/update/source/
enabled=1
gpgcheck=1
gpgkey=http://repo.openeuler.org/openEuler-22.03-LTS-SP1/source/RPM-GPG-KEY-openEuler
EOF
##激活
yum clean all
yum makecache

#安装python以及相关库
#原指南让安装python2,HCE2.0自带python3.9,测试是否可以安装,实测可以虽然测试的是7.x的版本

#直接全部安装最新的
pip install setuptools psutil cffi pyproject.toml cryptography paramiko ipaddress enum34 epydoc
##psycopg2 需要编译 C 扩展，这又依赖于 PostgreSQL 的客户端库（libpq 和 libpq-dev 或 postgresql-dev）。
sudo yum install -y postgresql-devel gcc
pip install psycopg2
#pip install setuptools psutil==5.7.0 pbr==5.4.4
#pip install cffi==1.15.0 #python3.9装不了1.14.0
#pip install pyproject.toml cryptography #同，只能安装新版
#pip install paramiko==2.7.2 ipaddress enum34 epydoc
#pip install psycopg2 #初始化要用到这个库，教程未提及,也可能是新版本需要

#安装yum下的库
sudo yum -y install curl-devel bzip2-devel openssl-devel readline-devel perl-ExtUtils-Embed libxml2-devel openldap-devel pam pam-devel perl-devel apr-devel libevent-devel libyaml libyaml-devel libedit-devel libffi-devel bison flex flex-devel net-tools wget cmake libzstd-devel


#需要手动安装的库?

#zstd
wget https://codeload.github.com/facebook/zstd/zip/refs/tags/v1.4.3

unzip v1.4.3
cd zstd-1.4.3/
make
make install
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
cd ..

#yum install -y xerces-c-devel 
#yum默认的包会编译gporca失败，需要源码安装
#gp-xerces
git clone https://gitee.com/WilliamLeoV/gp-xerces.git
cd gp-xerces
./configure
make -j `nproc`
make install
cd ..

echo export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib  >> /etc/profile
source /etc/profile

#源码编译re2c失败，鲲鹏教程无法使用。查看issue发现了m4问题解决方法。可是之前的镜像是用pip安装的，已提交，这。
#原来是因为从发布的tar/zip是不需要re2c的，已经预编译好了，从源码才需要。另外pip安装的是python绑定的re2c，而不是编译时需要的C++工具。
#所以并不需要
wget https://github.com/skvadrik/re2c/releases/download/2.0.3/re2c-2.0.3.tar.xz
tar -xvf re2c-2.0.3.tar.xz
cd re2c-2.0.3
./configure
make
make install

#ninja
wget https://github.com/ninja-build/ninja/archive/refs/tags/v1.10.1.zip
unzip ninja-1.10.1.zip
cd ninja-1.10.1
./configure.py --bootstrap 
cp ninja /usr/local/bin/

#gporca
git clone -b v3.119.0 https://gitee.com/Mr.Lin/gporca.git
#按鲲鹏社区注释157行
mkdir gporca/build
cd gporca/build
cmake -GNinja ..
ninja install
echo /usr/local/lib >> /etc/ld.so.conf
echo /usr/local/lib64 >> /etc/ld.so.conf
ldconfig


##################开始编译安装greenplum
#下载源码7.1.0
cd /home
git clone -b 7.1.0 https://gitee.com/mirrors/gpdb.git
#编译安装
cd gpdb
./configure --with-perl --with-python --with-libxml --prefix=/usr/local/gpdb
make
make install
#清除多余文件
cd ..
rm -rf gpdb
rm -rf gporca
rm -rf gp-xerces
rm -rf ninja-1.10.1*

#设置环境变量
echo source /usr/local/gpdb/greenplum_path.sh >> /etc/profile
source /etc/profile

##自测试
gpstate --version


####使用测试，待续
groupadd gpadmin
useradd -g gpadmin gpadmin
passwd gpadmin

mkdir /data
mkdir -p /data/gpdb/segdata
mkdir -p /data/gpdb/master
chown -R gpadmin:gpadmin /data/gpdb/segdata
chown -R gpadmin:gpadmin /data/gpdb/master

cat << 'EOF' >> /home/gpadmin/.bash_profile
source /usr/local/gpdb/greenplum_path.sh
export PGPORT=5432
export MASTER_DATA_DIRECTORY=/data/gpdb/master/gpseg-1
EOF





