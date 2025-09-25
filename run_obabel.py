import os
import sys
import subprocess
from concurrent.futures import ProcessPoolExecutor, as_completed

def convert(in_path, out_path):
    print(f'Converting {in_path} to {out_path}')
    subprocess.run(
        f'/usr/local/bin/obabel "{in_path}" -O "{out_path}" --gen3d --addH',
        shell=True,
        check=True
    )

def main(input_dir, output_dir, n_workers=1):
    os.makedirs(output_dir, exist_ok=True)
    tasks = []

    # 收集任务
    for root, dirs, files in os.walk(input_dir):
        rel_dir = os.path.relpath(root, input_dir)  # 子目录名
        out_subdir = os.path.join(output_dir, rel_dir)
        os.makedirs(out_subdir, exist_ok=True)

        for f in files:
            if f.endswith('.xyz'):
                in_path = os.path.join(root, f)
                out_fname = f.replace('.xyz', '.sdf')
                out_path = os.path.join(out_subdir, out_fname)
                tasks.append((in_path, out_path))

    # 顺序模式
    if n_workers == 1:
        for in_path, out_path in tasks:
            convert(in_path, out_path)
    else:
        # 并行模式
        with ProcessPoolExecutor(max_workers=n_workers) as executor:
            futures = {executor.submit(convert, in_path, out_path): (in_path, out_path) for in_path, out_path in tasks}
            for future in as_completed(futures):
                in_path, out_path = futures[future]
                try:
                    future.result()
                except Exception as e:
                    print(f"❌ Failed: {in_path} -> {out_path}, error: {e}")

if __name__ == "__main__":
    input_dir = sys.argv[1]
    output_dir = sys.argv[2]
    n_workers = int(sys.argv[3]) if len(sys.argv) > 3 else 1
    main(input_dir, output_dir, n_workers)
