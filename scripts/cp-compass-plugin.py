#!/usr/bin/env python3
import json
import os
import subprocess
import sys


def abs_parent(path):
    return os.path.dirname(os.path.abspath(path))

def read_json(file):
    if not os.path.isfile(file):
        return

    with open(file) as f:
        content = '\n'.join(f.readlines())
    return json.loads(content)

def get_package_json_path():
    cwd = os.getcwd()
    while True:
        package_json_path = os.path.join(cwd, 'package.json')
        if os.path.isfile(package_json_path):
            return package_json_path
        else:
            cwd = abs_parent(cwd)
            if not os.path.isdir(cwd) or cwd == '/':
                return

def get_package_name(package_json_path):
    if not package_json_path:
        return

    package_json = read_json(package_json_path)
    return package_json['name']

def find_compass_repo():
    cwd = abs_parent(os.getcwd())
    while True:
        compass_dir = os.path.join(cwd, 'compass')
        if os.path.isdir(compass_dir):
            compass_package_json = os.path.join(compass_dir, 'package.json')
            compass_package_name = get_package_name(compass_package_json)
            if compass_package_name == 'mongodb-compass':
               return compass_dir 
        
        cwd = abs_parent(cwd)
        if not os.path.isdir(cwd) or cwd == '/':
            return

def main(additional_paths):
    package_json_path = get_package_json_path()
    package_name = get_package_name(package_json_path)
    if package_name == 'mongodb-compass':
        print('ERR: Cannot run from inside compass repo!')
        sys.exit(1)
        return

    if not package_name:
        print('ERR: Could not determine local package')
        sys.exit(1)
        return
    print('Package Name: ' + package_name)

    compass_repo = find_compass_repo()
    if not compass_repo:
        print('ERR: Could not determine local compass repo')
        sys.exit(1)
        return
    
    compass_node_modules = os.path.join(compass_repo, 'node_modules')
    dest_path = os.path.join(compass_node_modules, package_name)

    if os.path.isdir(dest_path):
        print('Removing old package...')
        subprocess.call(['rm', '-rf', dest_path])

    subprocess.call(['mkdir', dest_path])

    all_paths = ['package.json', 'lib', 'styles'] + additional_paths
    for path in all_paths:
        sub_path = os.path.join(os.path.dirname(package_json_path), path)
        if not os.path.exists(sub_path):
            continue

        print('COPYING ' + path + '...')
        print('   from: ' + sub_path)
        print('     to: ' + dest_path)

        result = subprocess.call(['cp', '-r', sub_path, dest_path])
        if result != 0:
            print('ERR: Running copy failed, see output')
            sys.exit(result)
            return
    
    print('Done.')


if __name__ == '__main__':
    import sys
    main(sys.argv[1:])

