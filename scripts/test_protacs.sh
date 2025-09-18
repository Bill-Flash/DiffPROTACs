#!/bin/bash
set -e

CUDA_VISIBLE_DEVICES=1 \
python test_ddp.py \
  --model_path checkpoints/protacs_best.ckpt \
  --data_path datasets \
  --test_data_prefix protacs_test \
  --output_dir protacs_all \
  --n_samples 10 \
  | tee logs/protacs_test.log
