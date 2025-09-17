#!/bin/bash
set -e

python test_ddp.py \
  --model_path checkpoints/geom_best.ckpt \
  --data_path datasets \
  --test_data_prefix geom_test \
  --output_dir geom_out \
  | tee logs/geom_test.log
