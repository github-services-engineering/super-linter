#!/usr/bin/env python3
"""
Unit tests for JavaLinter class

"""
import unittest

from superlinter.linters.JavaLinter import JavaLinter
from superlinter.tests.test_superlinter.helpers import utilstest


class JavaLinterTest(unittest.TestCase):
    def setUp(self):
        utilstest.linter_test_setup()

    def test_success(self):
        utilstest.test_linter_success(JavaLinter(), self)

    def test_failure(self):
        utilstest.test_linter_failure(JavaLinter(), self)

    def test_get_linter_version(self):
        utilstest.test_get_linter_version(JavaLinter(), self)
