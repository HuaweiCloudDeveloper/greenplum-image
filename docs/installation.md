# Greenplum部署指南

# 一、环境准备

### 系统配置
> -  服务器：鲲鹏服务器
> -  操作系统：Huawei Cloud EulerOS 2.0 64bit
> - CPU: 2vCPUs 或更高
> - RAM: 4GB 或更大
> - Disk: 至少 40GB

### 配置Yum源
备份原配置文件
```
mkdir /etc/yum.repos.d/bak
mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/bak
```
配置openEulerOS 22.03源
```
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
```
激活Yum源
```
yum clean all
yum makecache
```
### 配置编译与运行环境
```
pip install setuptools psutil cffi pyproject.toml cryptography paramiko ipaddress enum34 epydoc
sudo yum install -y postgresql-devel gcc
pip install psycopg2
sudo yum -y install curl-devel bzip2-devel openssl-devel readline-devel perl-ExtUtils-Embed libxml2-devel openldap-devel pam pam-devel perl-devel apr-devel libevent-devel libyaml libyaml-devel libedit-devel libffi-devel bison flex flex-devel net-tools wget cmake libzstd-devel
```
#### 手动编译安装，如遇到网络不畅的情况，可手动下载对应包。

```
#zstd
wget https://codeload.github.com/facebook/zstd/zip/refs/tags/v1.4.3
unzip v1.4.3
cd zstd-1.4.3/
make
make install
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
cd ..

#gp-xerces
git clone https://gitee.com/WilliamLeoV/gp-xerces.git
cd gp-xerces
./configure
make -j `nproc`
make install
cd ..
echo export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib  >> /etc/profile
source /etc/profile

#ninja
wget https://github.com/ninja-build/ninja/archive/refs/tags/v1.10.1.zip
unzip ninja-1.10.1.zip
cd ninja-1.10.1
./configure.py --bootstrap 
cp ninja /usr/local/bin/
cd ..

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
```

# 二、源码下载与编译安装
下载源码7.1.0
```
cd /home
git clone -b 7.1.0 https://gitee.com/mirrors/gpdb.git
```
编译安装
```
cd gpdb
./configure --with-perl --with-python --with-libxml --prefix=/usr/local/gpdb
make
make install
```
清除多余文件
```
cd ..
rm -rf gpdb
rm -rf gporca
rm -rf gp-xerces
rm -rf ninja-1.10.1*
```
设置环境变量
```
echo source /usr/local/gpdb/greenplum_path.sh >> /etc/profile
source /etc/profile
```