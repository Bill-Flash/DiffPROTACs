#!/bin/bash
set -e

CUDA_VISIBLE_DEVICES=2 \
python test_ddp.py \
  --model_path checkpoints/zinc_best.ckpt \
  --data_path datasets \
  --test_data_prefix zinc_test \
  --output_dir zinc_out \
  --n_samples 10 \
  | tee logs/zinc_test.log
