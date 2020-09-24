#!/usr/bin/env python3
"""
Unit tests for DockerfileDockerfileLintLinter class

@author: Nicolas Vuillamy
"""
import unittest

from superlinter.linters.DockerfileHadolintLinter import DockerfileHadolintLinter
from superlinter.tests.test_superlinter.helpers import utilstest


class DockerfileHadolintLinterTest(unittest.TestCase):
    def setUp(self):
        utilstest.linter_test_setup()

    # temporary disable
    # def test_success(self):
    #    utilstest.test_linter_success(DockerfileHadolintLinter(), self)

    def test_failure(self):
        utilstest.test_linter_failure(DockerfileHadolintLinter(), self)

    def test_get_linter_version(self):
        utilstest.test_get_linter_version(DockerfileHadolintLinter(), self)
