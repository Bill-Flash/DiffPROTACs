import os
from glob import glob
from openbabel import pybel

def convert_xyz_to_sdf(input_dir, output_dir=None):
    if output_dir is None:
        output_dir = input_dir

    # 遍历所有子目录
    subdirs = [d for d in glob(os.path.join(input_dir, "*")) if os.path.isdir(d)]
    for sub in subdirs:
        xyz_files = glob(os.path.join(sub, "*.xyz"))
        for xyz_file in xyz_files:
            try:
                mol = next(pybel.readfile("xyz", xyz_file))
                base = os.path.splitext(os.path.basename(xyz_file))[0]  # e.g. true_ / 0_ / 1_
                sdf_path = os.path.join(sub, f"{base}.sdf")
                mol.write("sdf", sdf_path, overwrite=True)
                print(f"[OK] {xyz_file} -> {sdf_path}")
            except Exception as e:
                print(f"[FAIL] {xyz_file}: {e}")

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument("input_dir", help="目录，包含多个uuid子目录，每个子目录下有xyz文件")
    parser.add_argument("--output_dir", help="保存SDF的目录（默认覆盖到input_dir）", default=None)
    args = parser.parse_args()

    convert_xyz_to_sdf(args.input_dir, args.output_dir)
