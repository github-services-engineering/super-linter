#!/usr/bin/env python3
"""
Unit tests for GroovyLinter class

@author: Nicolas Vuillamy
"""
import unittest

from superlinter.linters.MarkdownLinter import MarkdownLinter
from superlinter.tests.test_superlinter.helpers import utilstest


class MarkdownLinterTest(unittest.TestCase):
    def setUp(self):
        utilstest.linter_test_setup()

    def test_success(self):
        utilstest.test_linter_success(MarkdownLinter(), self)

    def test_failure(self):
        utilstest.test_linter_failure(MarkdownLinter(), self)

    def test_get_linter_version(self):
        utilstest.test_get_linter_version(MarkdownLinter(), self)
