#!/bin/bash

# 生成一个带时间戳的日志文件名，例如 all_runs_20250918_1630.log, 第一个变量名为方法，第二个变量名为数据集，第三个是测试集
logfile="logs/DiffPROTAC_geom_geom_$(date +%Y%m%d_%H%M).log"

for i in {1..10}; do
    echo "========== Running with $i ==========" >> "$logfile"
    python compute.py geom_out $i >> "$logfile" 2>&1
done

echo "日志已保存到: $logfile"
