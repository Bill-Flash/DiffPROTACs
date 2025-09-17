#!/usr/bin/env bash
# scripts/fetch_data.sh
# 简洁版：下载 DiffLinker 提供的 GEOM & ZINC 预处理数据到 datasets/，
# 并创建与 DiffPROTACs 期望一致的文件名软链，方便直接训练。

set -e
DIR="datasets"
mkdir -p "$DIR"

echo "==> Download GEOM (train/val/test) ..."
wget -c "https://zenodo.org/record/7121278/files/geom_multifrag_train.pt?download=1" -O "$DIR/geom_multifrag_train.pt"
wget -c "https://zenodo.org/record/7121278/files/geom_multifrag_val.pt?download=1"   -O "$DIR/geom_multifrag_val.pt"
wget -c "https://zenodo.org/record/7121278/files/geom_multifrag_test.pt?download=1"  -O "$DIR/geom_multifrag_test.pt"

echo "==> Symlink to DiffPROTACs expected names (GEOM) ..."
ln -sf "geom_multifrag_train.pt" "$DIR/geom_train.pt"
ln -sf "geom_multifrag_val.pt"   "$DIR/geom_val.pt"
ln -sf "geom_multifrag_test.pt"  "$DIR/geom_test.pt"

echo "==> Download ZINC (train/val/test) ..."
wget -c "https://zenodo.org/record/7121271/files/zinc_final_train.pt?download=1" -O "$DIR/zinc_final_train.pt"
wget -c "https://zenodo.org/record/7121271/files/zinc_final_val.pt?download=1"   -O "$DIR/zinc_final_val.pt"
wget -c "https://zenodo.org/record/7121271/files/zinc_final_test.pt?download=1"  -O "$DIR/zinc_final_test.pt"

echo "==> Symlink to common names (ZINC) ..."
ln -sf "zinc_final_train.pt" "$DIR/zinc_train.pt"
ln -sf "zinc_final_val.pt"   "$DIR/zinc_val.pt"
ln -sf "zinc_final_test.pt"  "$DIR/zinc_test.pt"

echo "==> Done. Files in $DIR:"
ls -lh "$DIR"
echo
echo "Tips:"
echo "  - 现在可以直接跑：python main_ddp.py --config configs/geom.yaml"
echo "  - 若想用 ZINC 配置，改用对应的 config 或参数（已提供 zinc_* 软链）"
