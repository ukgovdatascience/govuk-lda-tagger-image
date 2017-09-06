""" Docker image produces expected test outputs
"""
# coding: utf-8

import pytest
import os
import subprocess
import shutil
import filecmp

class TestDockerOutput(object):

    def setup_method(self):
        
        """
        Run docker container using define defaults
        """
        
        subprocess.call('docker run -i --rm -v ${PWD}/tests/output:/mnt/output \
            -v ${PWD}/tests/experiments:/mnt/experiments \
            -v ${PWD}/tests/input:/mnt/input \
            ukgovdatascience/govuk-lda-tagger-image:latest python train_lda.py \
            --output-topics /mnt/output/test_topics.csv \
            --output-tags /mnt/output/test_tags.csv \
            --vis-filename /mnt/output/test_vis.html \
            --numtopics 7 \
            --passes 1 \
            import /mnt/input/test_url_text.csv', shell=True)

    def teardown_method(self):
        """
        Delete all the outputs created by the docker container
        """

        shutil.rmtree('tests/output')
        shutil.rmtree('tests/experiments')

    def test_files_are_produced(self):
        """
        Test that the expected files are produced by docker container.
        """

        assert os.path.isfile('tests/output/test_tags.csv')
        assert os.path.isfile('tests/output/test_topics.csv')
        assert os.path.isfile('tests/output/test_vis.html')

    @pytest.mark.xfail
    def test_output_contents_match(self):
        """
        Test that the output files match comparisons.
        """

        assert filecmp.dircmp('tests/output', 'tests/comparison_output')
