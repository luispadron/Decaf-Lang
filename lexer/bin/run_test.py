#!/usr/bin/env python3

from difflib import context_diff
from pathlib import Path
from shlex import split
from subprocess import PIPE, run
from sys import argv, exit, stderr


def eprint(*args, **kwargs):
    print(*args, file=stderr, **kwargs)


def read_file_at_path(path):
    with path.open() as file:
        return file.read()


def get_files(dir):
    return set(filter(lambda p: p.is_file(), dir.iterdir()))


class TestRunner():
    def __init__(self, args, input, cwd, ext):
        self.args = args
        self.input = input
        self.cwd = cwd
        self.inout = {
            self.cwd / 'in.{0}'.format(ext),
            self.cwd / 'out.{0}'.format(ext)
        }

    def __enter__(self):
        self.files = get_files(self.cwd) - self.inout
        handle = run(self.args, input=self.input, stdout=PIPE, stderr=PIPE,
                     cwd=self.cwd)
        self.new_files = get_files(self.cwd) - self.files - self.inout

        return handle.returncode, handle.stdout, handle.stderr, \
            self.files, self.new_files

    def __exit__(self, type, value, traceback):
        for file in self.new_files:
            file.unlink()


def run_test(args, dir, ext):
    in_path = dir / 'in.{0}'.format(ext)
    out_path = dir / 'out.{0}'.format(ext)

    if not in_path.is_file():
        return '{} does not exist or is not a file!'.format(in_path.name)
    elif not out_path.is_file():
        return '{} does not exist or is not a file!'.format(out_path.name)

    in_contents = read_file_at_path(in_path).encode()

    with TestRunner(args, in_contents, dir, ext) as \
            (ret, stdout, stderr, files, new_files):
        if ret != 0:
            eprint('error occured, printing stderr:')
            eprint(stderr.decode())

            return 'return code {}'.format(ret)

        out_contents = read_file_at_path(out_path).splitlines(keepends=True)
        actual = stdout.decode().splitlines(keepends=True)

        has_diff = False
        for diff in context_diff(out_contents, actual, fromfile='expected',
                                 tofile='actual'):
            has_diff = True
            eprint(diff, end='')

        if has_diff:
            return 'output differed'

        for file in files:
            if file.suffix != '.correct':
                return 'unexpected file "{}" in directory'.format(file.name)

            without_suffix = file.with_suffix('')
            if not without_suffix.is_file():
                return 'expected file "{}" to be created but no file exists' \
                    .format(without_suffix.name)

        correct_files = \
            (p.with_suffix(p.suffix + '.correct') for p in new_files)

        for actual, expected in zip(new_files, correct_files):
            if not expected.is_file():
                return 'created file "{}" but "{}" doesn\'t exist' \
                    .format(actual.name, expected.name)

            actual_contents = \
                read_file_at_path(actual).splitlines(keepends=True)
            expected_contents = \
                read_file_at_path(expected).splitlines(keepends=True)

            has_diff = False
            for diff in context_diff(expected_contents, actual_contents,
                                     fromfile=expected.name,
                                     tofile=actual.name):
                has_diff = True
                eprint(diff, end='')

            if has_diff:
                return 'output of created file "{}" differed' \
                    .format(actual.name)

    return ''


def main():
    if len(argv) < 2:
        exit('missing executable argument!')

    args = split(argv[1])
    ext = argv[2]
    args[-1] = Path(args[-1]).resolve()

    failed = []
    root = Path('test')
    for dir in filter(lambda p: p.is_dir(), root.iterdir()):
        result = run_test(args, dir, ext)
        name = dir.name

        if result:
            eprint('test {} failed: {}'.format(name, result))
            failed.append(name)
        else:
            print('test {} succeeded'.format(name))

    if failed:
        exit("tests failed: {}".format(failed))


if __name__ == '__main__':
    main()