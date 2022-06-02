#!/bin/bash

# ---
# Create log for provisioning script and output stdout and stderr to it
# ---
LOG=/var/log/provisioner.log
exec > $LOG 2>&1
set -x

ISDEBIAN=false

if [ -e /etc/lsb-release ]; then
	DISTRO=$(whoami)
    ISDEBIAN=true
fi

mountpoint=/mnt/vdb
device=/dev/vdb

# Set timezone
# export TZ="/usr/share/zoneinfo/America/${timezone}"
# echo "export TZ=\"/usr/share/zoneinfo/America/${timezone}\"" >> ~/.bashrc
# $(cat ~/.bashrc | TZ)

# ---
# Format and mount filesystems
# ---

if [ "$(df -Th | grep ${device} | awk '{print $1}')" == "${device}" ]
then
    echo "${device} has already been mounted."
else
    echo "Format ${device}"

    # This block is necessary to prevent provisioner from continuing before volume is attached
    while [ ! -b ${device} ]; do sleep 1; done

    UUID=$(lsblk -no UUID ${device})

    if [ -z $UUID ]
    then
        mkfs.ext4 ${device}
    fi
    
    if [ ! -d ${mountpoint} ]
    then
        mkdir -p ${mountpoint}
    fi
    
    sleep 5

    grep ${mountpoint} /etc/fstab
    if [ $? -ne 0 ]
    then
        echo "Add ${device} to /etc/fstab"
        echo "UUID=$UUID ${mountpoint}    xfs    noatime    0 0" >> /etc/fstab
    fi

    echo "Mount ${device}"
    mount ${device} ${mountpoint}
fi

df -h

# ---
# Add hostname to /etc/hosts
# ---

grep `hostname` /etc/hosts
if [ $? -ne 0 ]
then
    echo "Add hostname and ip to /etc/hosts"
    echo "${ip} `hostname -s` `hostname`" >> /etc/hosts
fi

# ---
# Move directories from bootdisk to mountpoint
# ---
move_dir () {
    if [ ! -d ${mountpoint}$1 ] # if directory doesn't exist on the mounted volume
    then
        echo "mkdir -p -m 777 ${mountpoint}${1}"
        mkdir -p -m 777 ${mountpoint}${1}
	    chown ${DISTRO}:${DISTRO} ${mountpoint}${1} -R
        if [ -d $1 ] # if directory exists on root volume
        then
            echo "Moving pre-existing data from ${1}...\n" 
            echo "mv $1 ${mountpoint}$(dirname "${1}")"
            mv $1 ${mountpoint}$(dirname "${1}")
        fi
    fi

    echo "Creating symlink..."
    echo "ln -s ${mountpoint}${1} ${1}"
    ln -s ${mountpoint}$1 ${1}
    echo $(ln -s ${mountpoint}$1 ${1})
}

move_dir /var/lib/HPCCSystems
move_dir /opt/HPCCSystems
move_dir /etc/HPCCSystems
move_dir /jenkins

if [ ${ISDEBIAN} == true ]
then
    apt --fix-broken install -y
    apt-get upgrade -y
    apt install openjdk-11-jdk -y
    apt install -f
    apt-get install -f
    apt autoremove -y

    if [ "$(cat /etc/lsb-release | grep 'DISTRIB_RELEASE')" == "DISTRIB_RELEASE=18.04" ]
    then
        apt-get install cmake bison flex build-essential binutils-dev libldap2-dev libcppunit-dev libicu-dev libxslt1-dev zlib1g-dev libboost-regex-dev \
        libarchive-dev python-dev libv8-dev default-jdk libapr1-dev libaprutil1-dev libiberty-dev libhiredis-dev libtbb-dev libxalan-c-dev libnuma-dev \
        nodejs libevent-dev libatlas-base-dev libblas-dev python3-dev default-libmysqlclient-dev libsqlite3-dev r-base-dev r-cran-rcpp r-cran-rinside \
        r-cran-inline libmemcached-dev libcurl4-openssl-dev pkg-config libtool autotools-dev automake libssl-dev -y

    elif [ "$(cat /etc/lsb-release | grep 'DISTRIB_RELEASE')" == "DISTRIB_RELEASE=20.04" ]
    then
        apt install -y r-base
        apt-get install cmake bison flex build-essential binutils-dev libldap2-dev libcppunit-dev libicu-dev libxslt1-dev zlib1g-dev \
        libboost-regex-dev libarchive-dev python-dev libv8-dev default-jdk libapr1-dev libaprutil1-dev libiberty-dev libhiredis-dev libtbb-dev \
        libxalan-c-dev libnuma-dev nodejs libevent-dev libatlas-base-dev libblas-dev python3-dev default-libmysqlclient-dev libsqlite3-dev r-base-dev \
        r-cran-rcpp r-cran-rinside r-cran-inline libmemcached-dev libcurl4-openssl-dev pkg-config libtool autotools-dev automake libssl-dev -y

    else
        echo "It seems like you are trying to use a Ubuntu version that the HPCC Systems does not support.\n
        The support for this version may have ended or not yet available.\n
        Please contact the HPCC Systems team for further assistance.\n
        Issue Tracker: https://track.hpccsystems.com/"
    fi


else
    yum install epel-release java-1.8.0-openjdk wget git -y
    yum update -y

    if [ $(cat /etc/os-release | grep VERSION_ID) == 'VERSION_ID="7"' ]
    then
        # Enable EPEL
        #yum --enablerepo=LN-epel
        sed -i '/LN-epel/,/enabled=0/ s/enabled=0/enabled=1/' /etc/yum.repos.d/LexisNexis.repo
        sed -i '/LN-base/,/enabled=0/ s/enabled=0/enabled=1/' /etc/yum.repos.d/LexisNexis.repo
        sed -i '/LN-updates/,/enabled=0/ s/enabled=0/enabled=1/' /etc/yum.repos.d/LexisNexis.repo

        # Copy RPM-GPG-KEY for EPEL-7 into /etc/pki/rpm-gpg
        cp /home/centos/RPM-GPG-KEY-EPEL-7 /etc/pki/rpm-gpg
        cp /home/centos/RPM-GPG-KEY-remi /etc/pki/rpm-gpg
        
        yum install gcc-c++ gcc make bison flex binutils-devel openldap-devel libicu-devel libxslt-devel libarchive-devel boost-devel openssl-devel \
        apr-devel apr-util-devel hiredis-devel numactl-devel mariadb-devel libevent-devel tbb-devel atlas-devel python34 libmemcached-devel sqlite-devel \
        v8-devel python-devel python34-devel java-1.8.0-openjdk-devel R-core-devel R-Rcpp-devel R-inline R-RInside-devel nodejs cmake3 rpm-build libcurl-devel -y

    elif [ $(cat /etc/os-release | grep VERSION_ID) == 'VERSION_ID="8"' ]
    then
       yum install gcc-c++ gcc make bison flex binutils-devel openldap-devel libicu-devel libxslt-devel libarchive-devel boost-devel openssl-devel \
       apr-devel apr-util-devel hiredis-devel numactl-devel mariadb-devel libevent-devel tbb-devel atlas-devel libmemcached-devel sqlite-devel python2-devel \
       python3-devel java-1.8.0-openjdk-devel R-core-devel R-Rcpp-devel R-inline R-RInside-devel nodejs cmake3 rpm-build libcurl-devel -y
    else
        echo "It seems like you are trying to use a Centos version that the HPCC Systems does not support.\n
        The support for this version may have ended or not yet available.\n
        Please contact the HPCC Systems team for further assistance.\n
        Issue Tracker: https://track.hpccsystems.com/"
    fi
fi

exit 0;