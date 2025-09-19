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






