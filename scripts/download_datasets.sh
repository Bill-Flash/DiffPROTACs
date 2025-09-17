#!/bin/bash
set -e

# 数据存放目录
DATA_DIR="datasets"
mkdir -p $DATA_DIR

echo "==> 下载 DiffPROTACs 数据集 (ZINC, GEOM, PROTAC-DB) ..."
wget -c https://bailab.siais.shanghaitech.edu.cn/service/DiffPROTACs-generated.tgz -O $DATA_DIR/DiffPROTACs-generated.tgz

echo "==> 解压 ..."
tar -xvzf $DATA_DIR/DiffPROTACs-generated.tgz -C $DATA_DIR

echo "==> 清理压缩包 ..."
rm $DATA_DIR/DiffPROTACs-generated.tgz

echo "==> 数据集准备完成，内容如下："
ls -lh $DATA_DIR
