#!/usr/bin/env bash
# Vendored from https://gitlab.com/gitlab-com/gl-infra/common-template-copier
# Consider contributing upstream when updating this file

# See the README.md for details of how this script works

# Stolen from here: https://gitlab.com/gitlab-com/gl-infra/common-ci-tasks/-/blob/main/scripts/update-asdf-version-variables.sh?ref_type=heads

set -euo pipefail
IFS=$'\n\t'

export LANG=C LC_ALL=C

generate() {
  sort ./.tool-versions |
    awk '
    BEGIN {
      print "# DO NOT MANUALLY EDIT; Run ./scripts/update-asdf-version-variables.sh to update this";
      print "variables:"
    }
    {
      if (!/^#/ && $1 != "" && $2 != "system") {
        gsub("-", "_", $1);
        print "  GL_ASDF_" toupper($1) "_VERSION: " $2
      }
    }
    '
}

generate > ./.gitlab-ci-asdf-versions.yml
