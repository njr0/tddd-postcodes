"""
test_python_postcodes_py.py: Automatically generated test code from tdda gentest.

Generation command:

tdda gentest 'python postcodes.py' 'test_python_postcodes_py.py' '.'
"""

import os
import sys
import tempfile

from tdda.referencetest import ReferenceTestCase
from tdda.referencetest.gentest import exec_command


class Test_PYTHON_POSTCODES(ReferenceTestCase):
    command = 'python postcodes.py'
    cwd = os.path.abspath(os.path.dirname(__file__))
    refdir = os.path.join(cwd, 'ref', 'python_postcodes_py')

    generated_files = [
        os.path.join(cwd, 'postcodes-defs.tex'),
    os.path.join(cwd, 'postcodes.json')
    ]
    @classmethod
    def setUpClass(cls):
        for path in cls.generated_files:
            if os.path.exists(path):
                os.unlink(path)
        (cls.output,
         cls.error,
         cls.exception,
         cls.exit_code,
         cls.duration) = exec_command(cls.command, cls.cwd)

    def test_no_exception(self):
        self.assertIsNone(self.exception)

    def test_exit_code(self):
        self.assertEqual(self.exit_code, 0)

    def test_stdout(self):
        self.assertStringCorrect(self.output,
                                 os.path.join(self.refdir, 'STDOUT'))

    def test_stderr(self):
        self.assertStringCorrect(self.error,
                                 os.path.join(self.refdir, 'STDERR'))

    def test_postcodes_defs_tex(self):
        self.assertTextFileCorrect(os.path.join(self.cwd, 'postcodes-defs.tex'),
                                   os.path.join(self.refdir, 'postcodes-defs.tex'),
                                   encoding='ascii')

    def test_postcodes_json(self):
        self.assertTextFileCorrect(os.path.join(self.cwd, 'postcodes.json'),
                                   os.path.join(self.refdir, 'postcodes.json'),
                                   encoding='ascii')

if __name__ == '__main__':
    ReferenceTestCase.main()
