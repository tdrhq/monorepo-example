
set -x
set -e

maybe_run_target() {
    cd $1 && ./gen.sh
    ~/screenshotbot/recorder --directory screenshots --channel "monorepo-example/$1"
}

for target in "target1 target2 target3" ; do
    maybe_run_target $target
done

echo "run-all-tests done"
