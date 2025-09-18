import os
import sys
import subprocess

def convert(in_path, out_path):
    print(f'Converting {in_path} to {out_path}')
    subprocess.run(f'/usr/local/bin/obabel "{in_path}" -O "{out_path}" --gen3d', shell=True)

input_dir = sys.argv[1]
output_dir = sys.argv[2]
os.makedirs(output_dir, exist_ok=True)

for root, dirs, files in os.walk(input_dir):
    rel_dir = os.path.relpath(root, input_dir)  # 子目录名
    out_subdir = os.path.join(output_dir, rel_dir)
    os.makedirs(out_subdir, exist_ok=True)

    for f in files:
        if f.endswith('.xyz'):
            in_path = os.path.join(root, f)
            out_fname = f.replace('.xyz', '.sdf')
            out_path = os.path.join(out_subdir, out_fname)
            convert(in_path, out_path)
