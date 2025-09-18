#!/bin/bash
set -e
# ==========================================================
# Script: test_geom.sh
# Purpose: 
#   1. 测试模型 (test_ddp.py)
#   2. 运行 OpenBabel 转换 (run_obabel.py)
#   3. 执行 compute 计算 (compute.py)
# 
# Usage:
#   bash test_geom.sh
#
# Output:
#   日志文件保存在 logs/geom_protacs_test_YYYYMMDD_HHMM.log
#   (日志中包含每一步的分隔符和运行环境信息)
#
# Notes:
#   - geom 为数据集名
#   - protacs_test 为测试集前缀
# ==========================================================

TIME_STAMP=$(date +%Y%m%d_%H%M)
LOGFILE="logs/geom_protacs_test_${TIME_STAMP}.log"

mkdir -p logs

# 记录环境信息
echo "==================================================" | tee -a "$LOGFILE"
echo " Run started at: $(date)" | tee -a "$LOGFILE"
echo " Hostname: $(hostname)" | tee -a "$LOGFILE"
echo " Working dir: $(pwd)" | tee -a "$LOGFILE"
echo "==================================================" | tee -a "$LOGFILE"


# 执行步骤
echo "========== Running test_ddp.py ==========" | tee -a "$LOGFILE"
python test_ddp.py \
  --model_path checkpoints/geom_best.ckpt \
  --data_path datasets \
  --test_data_prefix protacs_test \
  --output_dir geom_protacs_out \
  --n_samples 10 \
  | tee -a "$LOGFILE"

echo "========== Running run_obabel.py ==========" | tee -a "$LOGFILE"
python run_obabel.py geom_protacs_out geom_protacs_obabel_out \
  | tee -a "$LOGFILE"

echo "========== Running compute.py ==========" | tee -a "$LOGFILE"
python compute.py geom_protacs_out 10 \
  | tee -a "$LOGFILE"

echo "日志已保存到: $LOGFILE"
