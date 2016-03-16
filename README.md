# BuggyApp

This app contains a few bugs. Once the bugs are fixed, it should be capable of
fetching a list of stories and displaying their titles and authors in a table.

## Goals

1. Fix the bugs so that it actually displays the top ten stories on Wattpad.
2. Replace the UITableView with a UICollectionView that displays the stories in a grid.
3. Make it fetch the next set of stories when the user scrolls to the end (increase the number of stories fetched initially if necessary), and add them to the collection. Each response contains a `nextUrl` property that will provide the next set of results.
4. Persist the stories to disk so that, when the app starts up, it initially displays the last set of fetched stories. When it gets a new set of stories from the server, it should replace the previous cached ones.

