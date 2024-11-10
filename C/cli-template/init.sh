#!/bin/bash
###
 # @Author: wolf-li
 # @Date: 2024-11-10 15:58:36
 # @LastEditTime: 2024-11-10 16:22:51
 # @LastEditors: wolf-li
 # @Description: 项目初始化(是否有相应的工具) git gcc make gdb valgrind
 # @FilePath: init.sh
 # @Platform: linux（x86-64）
 # talk is cheep show me your code.
### 

## 测试每一个安装包，没有下载的进行安装
yum_pack_name=(
    git
    gcc
    make
    gdb 
    valgrind 
)

apt_pack_name=(
    git
    build-essential
    make
    gdb 
    valgrind 
)

pacman_pack_name=(
    git
    gcc
    make
    gdb 
    valgrind 
)

function is_apt_package_installed() {
  local package_name="$1"
  dpkg -s "$package_name" >/dev/null 2>&1
  if [ $? -ne 0 ];then
    apt install -y $1
  fi
  echo "$1 installed !!!"
}

function is_pacman_package_installed() {
  local package_name="$1"
  pacman -Qi "$package_name" >/dev/null 2>&1
  if [ $? -ne 0 ];then
    pacman install -y $1
  fi
  echo "$1 installed !!!"
}

function is_yum_package_installed(){
  local package_name="$1"
  rpm -q "$package_name" >/dev/null 2>&1
  if [ $? -ne 0 ];then
    yum install -y $1
  fi
  echo "$1 installed !!!"
}

function is_package_installed(){
    case $1 in 
        apt )
            for tmp_pack_name in ${apt_pack_name[*]}; do
                is_apt_package_installed $tmp_pack_name
            done
        ;;
        pacman )
            for tmp_pack_name in ${pacman_pack_name[*]}; do
                is_apt_package_installed $tmp_pack_name
            done
        ;;
        yum )
            for tmp_pack_name in ${yum_pack_name[*]}; do
                is_apt_package_installed $tmp_pack_name
            done
        ;;
        *)
            echo "not support"
        ;;
    esac
}

function identify_package_manager() {
  # 优先尝试使用 lsb_release
  distro=$(lsb_release -is 2>/dev/null)
  if [ -n "$distro" ]; then
    case "$distro" in
      Ubuntu|Debian)
        echo "apt"
        ;;
      Fedora|CentOS|RHEL)
        echo "yum"
        ;;
      Arch)
        echo "pacman"
        ;;
      # 添加更多发行版和对应包管理器的判断
      *)
        echo "Unsupported distribution: $distro"
        ;;
    esac
    return
  fi

  # 如果 lsb_release 不存在，尝试从 /etc/os-release 获取信息
  distro_id=$(grep '^ID=' /etc/os-release | cut -d= -f2 |sed 's/"//g')
  case "$distro_id" in
    ubuntu|debian)
      echo "apt"
      ;;
    fedora|centos|rhel)
      echo "yum"
      ;;
    arch)
      echo "pacman"
      ;;
    # 添加更多发行版和对应包管理器的判断
    *)
      # 如果 /etc/os-release 中也没有找到，尝试其他方法
      # ...
      echo "Failed to identify package manager"
      ;;
  esac
}

is_package_installed $(identify_package_manager)


