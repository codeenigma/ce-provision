# Example client-side git-hooks

## Usage
Clone/copy this at the root of your project repository,
and replace the .git/hooks default folder with a symlink
to ../git-hooks.
You can place any .hook file in the matching folder,
pre-commit.d, post-commit.d, etc. Other extensions will
get ignored.