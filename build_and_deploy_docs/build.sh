#!/bin/bash
set -e

if [ $# != 2 ]; then
    >&2 echo "Unexpected number of arguments.  Got $#, expected 2"
    exit 1
fi

action_path=$(dirname "$0")
build_dir="$1"
pkg_name="$2"

echo ${action_path@A}
echo ${build_dir@A}
echo ${pkg_name@A}

# need to source workspace so that the package is found
. install/local_setup.bash

# find path to python package directory
python_dir=$("${action_path}/find_python_package.py" ${pkg_name})
echo "Python package path: ${python_dir}"
if [[ -n "${python_dir}" ]]; then
    python_dir_arg="--python-dir=${python_dir}"
else
    python_dir_arg=""
fi

set -x  # print the bcat command when executing
bcat -o "${build_dir}" -p . ${python_dir_arg} --verbose
