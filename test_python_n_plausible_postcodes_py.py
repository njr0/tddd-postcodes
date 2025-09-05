"""
test_python_n_plausible_postcodes_py.py: Automatically generated test code from tdda gentest.

Generation command:

tdda gentest 'python n_plausible_postcodes.py' 'test_python_n_plausible_postcodes_py.py' '.'
"""

import os
import sys
import tempfile

from tdda.referencetest import ReferenceTestCase
from tdda.referencetest.gentest import exec_command


class Test_PYTHON_N_PLAUSIBLE_POSTCODES(ReferenceTestCase):
    command = 'python n_plausible_postcodes.py'
    cwd = os.path.abspath(os.path.dirname(__file__))
    refdir = os.path.join(cwd, 'ref', 'python_n_plausible_postcodes_py')

    generated_files = [
        os.path.join(cwd, 'n-plausible-postcodes-defs.tex'),
    os.path.join(cwd, 'n-plausible-postcodes-results.json')
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

    def test_n_plausible_postcodes_defs_tex(self):
        self.assertTextFileCorrect(os.path.join(self.cwd, 'n-plausible-postcodes-defs.tex'),
                                   os.path.join(self.refdir, 'n-plausible-postcodes-defs.tex'),
                                   encoding='ascii')

    def test_n_plausible_postcodes_results_json(self):
        self.assertTextFileCorrect(os.path.join(self.cwd, 'n-plausible-postcodes-results.json'),
                                   os.path.join(self.refdir, 'n-plausible-postcodes-results.json'),
                                   encoding='ascii')

if __name__ == '__main__':
    ReferenceTestCase.main()
