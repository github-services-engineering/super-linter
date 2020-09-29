# !/usr/bin/env python3
"""
Unit tests for YamlLinter class
This class has been automatically generated by .automation/build.py, please do not update it manually
"""
import unittest

from superlinter.linters.YamlLinter import YamlLinter
from superlinter.tests.test_superlinter.helpers import utilstest


class YamlLinterTest(unittest.TestCase):
    def setUp(self):
        utilstest.linter_test_setup()

    def test_success(self):
        utilstest.test_linter_success(YamlLinter(), self)

    def test_failure(self):
        utilstest.test_linter_failure(YamlLinter(), self)

    def test_get_linter_version(self):
        utilstest.test_get_linter_version(YamlLinter(), self)
