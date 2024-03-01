
set -x

merge_base() {
    git merge-base main HEAD
}

# Check if a specific target needs to be built
#
# Typically this will be more complicated, and will depend on the
# environment variables your CI system provides, and your build system
# (Gradle, buck, bazel etc.). Here we use a simple test to see if this
# is a Pull Request, and if the target hasn't changed from the main
# branch.
is_target_affected() {
    if [ "$CIRCLE_BRANCH" = "main" ] ; then
        return 0 # always build the main branch.
    fi

    return ! ( git diff --exit-code `merge_base` $1 )
}

maybe_run_target() {
    if ( is_target_affected $1 ) ; then
        cd $1 && ./gen.sh
        ~/screenshotbot/recorder --directory screenshots --channel "monorepo-example/$1"
        cd ..
    fi
}

for target in target1 target2 target3 ; do
    maybe_run_target $target
done

echo "run-all-tests done"
