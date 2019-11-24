#!/bin/bash
#
# build.sh <hub|singleuser> <name>
#

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

set -e

TYPE="$1"
NAME="$2"
TAG="$(hostname)-$(date '+%Y%m%d%H%M%S')"

docker build -t "$NAME:$TAG" . 1>&2

# Are we being run from a hub config dir? If so, be helpful and
# update the relevant config.
VALDIR="$(dirname $(dirname $DIR))/values"
if [[ -d "$VALDIR" ]]; then
	cat > "$VALDIR/$TYPE.image.yaml" <<-EOF
	$TYPE:
	  image:
	    name: $NAME
	    tag: $TAG
	EOF
	echo "note: updated $VALDIR/$TYPE.image.yaml to point to $NAME:$TAG" 1>&2
fi

echo "$NAME:$TAG"
