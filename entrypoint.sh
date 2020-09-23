#!/usr/bin/env bash

export PYTHONPATH=$PATHONPATH:`pwd`

if [ "${TEST_CASE_RUN}" == "true" ] ; then
  echo "RUNNING TEST CASES"
  echo ""
  echo "[CURRENT FOLDER CONTENT]"
  ls -1
  if [ -d "/tmp/lint" ]; then
      echo "[CONTENT OF /tmp/lint]"
      ls "/tmp/lint" -1
      echo ""
  fi
  if [ -d "/action" ]; then
      echo "[CONTENT OF /action]"
      ls "/action" -1
      echo ""
  fi
  python -m superlinter.test
else
  python -m superlinter.run
fi
